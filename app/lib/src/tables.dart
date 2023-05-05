import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'tables.g.dart';

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
}

@DriftAccessor(
  tables: [Projects],
)
class ProjectsDao extends DatabaseAccessor<SkaiDb> with _$ProjectsDaoMixin {
  ProjectsDao(super.attachedDatabase);

  Stream<List<Project>> getAllProjects() => select(projects).watch();

  Future<Project> insertEmptySampleProject(int i) async {
    return await into(projects).insertReturning(ProjectsCompanion(
        name: Value('Project $i'),
        description: const Value('This is a sample project description.')));
  }

  Future<void> createSampleProjects() async {
    transaction(() async {
      for (int i = 0; i < 10; i++) {
        await insertSampleProject(i);
      }
    });
  }

  Future<Project> insertSampleProject(int i) async {
    return transaction(() async {
      Project project = await insertEmptySampleProject(i);

      final villa = await db.locationsDao.insertSampleVilla(i);
      final sunnyBeachHouse = await db.locationsDao.insertSampleBeachHouse(i);

      await into(db.scenes).insert(ScenesCompanion(
          projectId: Value(i),
          locationId: Value(villa.id),
          number: const Value(1),
          name: const Value('A normal day at work')));
      await into(db.scenes).insert(ScenesCompanion(
          projectId: Value(i),
          locationId: Value(sunnyBeachHouse.id),
          number: const Value(2),
          name: const Value('Epethany at the beach')));

      return project;
    });
  }

  Future<void> deleteProject(int id) async {
    await delete(projects).delete(ProjectsCompanion(id: Value(id)));
  }
}

final projectsDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.projectsDao;
});

class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();
  TextColumn get name => text()();
}

@DriftAccessor(tables: [Locations])
class LocationsDao extends DatabaseAccessor<SkaiDb> with _$LocationsDaoMixin {
  LocationsDao(super.attachedDatabase);

  Stream<List<Location>> getAllLocations() => select(locations).watch();

  Future<Location> insertSampleBeachHouse(int i) async {
    return await into(locations).insertReturning(LocationsCompanion(
        projectId: Value(i),
        name: const Value('Sunny Beach House, Front Bench')));
  }

  Future<Location> insertSampleVilla(int i) async {
    return await into(locations).insertReturning(LocationsCompanion(
        projectId: Value(i), name: const Value('Villa in the Woods, Office')));
  }
}

final locationsDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.locationsDao;
});

class Scenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();
  IntColumn get locationId => integer().references(Locations, #id)();
  IntColumn get number => integer()();
  TextColumn get name => text()();
}

@DriftAccessor(tables: [Scenes])
class ScenesDao extends DatabaseAccessor<SkaiDb> with _$ScenesDaoMixin {
  ScenesDao(super.attachedDatabase);

  Stream<List<Scene>> getAllScenes() => select(scenes).watch();
}

final scenesDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.scenesDao;
});

@DriftDatabase(
    tables: [Projects, Locations, Scenes],
    daos: [ProjectsDao, LocationsDao, ScenesDao])
class SkaiDb extends _$SkaiDb {
  SkaiDb() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          await m.addColumn(scenes, scenes.locationId);
        }
      },
    );
  }
}

final skaiDbProvider = Provider((ref) => SkaiDb());

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'skaidb.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
