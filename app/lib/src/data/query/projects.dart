import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../tables.dart';
import '../id.dart';

part 'projects.g.dart';

@DriftAccessor(
  tables: [Projects],
)
class ProjectsDao extends DatabaseAccessor<SkaiDb> with _$ProjectsDaoMixin {
  ProjectsDao(super.attachedDatabase);

  Stream<List<Project>> getAllProjects() => select(projects).watch();

  Stream<Map<Id, Project>> getProjectsById(
          List<Id> projectIds) =>
      (select(projects)
            ..where((project) =>
                project.id.isIn(projectIds.map((e) => e.toString()))))
          .watch()
          .map((projects) => {
                for (final project in projects) project.id: project,
              });

  Future<Project> insertEmptySampleProject(int projectNum) async {
    return await into(projects).insertReturning(ProjectsCompanion(
        id: Value(Id.random()),
        name: Value('Project $projectNum'),
        description: const Value('This is a sample project description.')));
  }

  Future<void> createSampleProjects() async {
    transaction(() async {
      for (int i = 0; i < 10; i++) {
        await insertSampleProject(i);
      }
    });
  }

  Future<Project> insertSampleProject(int projectNum) async {
    return transaction(() async {
      Project project = await insertEmptySampleProject(projectNum);

      final villa = await db.locationsDao.insertSampleVilla(project.id);
      final sunnyBeachHouse =
          await db.locationsDao.insertSampleBeachHouse(project.id);

      await into(db.scenes).insert(ScenesCompanion(
          id: Value(Id.random()),
          projectId: Value(project.id),
          locationId: Value(villa.id),
          number: const Value(1),
          name: const Value('A normal day at work')));
      await into(db.scenes).insert(ScenesCompanion(
          id: Value(Id.random()),
          projectId: Value(project.id),
          locationId: Value(sunnyBeachHouse.id),
          number: const Value(2),
          name: const Value('Epethany at the beach')));

      return project;
    });
  }

  Future<void> deleteProject(Id id) async {
    await delete(projects).delete(ProjectsCompanion(id: Value(id)));
  }
}

final projectsDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.projectsDao;
});
