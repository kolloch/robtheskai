import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'uuid.dart';

part 'tables.g.dart';

class UuidConverter extends TypeConverter<List<int>, String> {
  const UuidConverter();

  @override
  List<int> fromSql(String fromDb) {
    return Uuid.parse(fromDb);
  }

  @override
  String toSql(List<int> value) {
    return Uuid.unparse(value);
  }
}

class Projects extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get name => text()();
  TextColumn get description => text()();
}

@DriftAccessor(
  tables: [Projects],
)
class ProjectsDao extends DatabaseAccessor<SkaiDb> with _$ProjectsDaoMixin {
  ProjectsDao(super.attachedDatabase);

  Stream<List<Project>> getAllProjects() => select(projects).watch();

  Future<Project> insertEmptySampleProject(int projectNum) async {
    return await into(projects).insertReturning(ProjectsCompanion(
        id: Value(createRandomUuid()),
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
          id: Value(createRandomUuid()),
          projectId: Value(project.id),
          locationId: Value(villa.id),
          number: const Value(1),
          name: const Value('A normal day at work')));
      await into(db.scenes).insert(ScenesCompanion(
          id: Value(createRandomUuid()),
          projectId: Value(project.id),
          locationId: Value(sunnyBeachHouse.id),
          number: const Value(2),
          name: const Value('Epethany at the beach')));

      return project;
    });
  }

  Future<void> deleteProject(UuidV id) async {
    await delete(projects).delete(ProjectsCompanion(id: Value(id)));
  }
}

final projectsDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.projectsDao;
});

class Locations extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get projectId =>
      text().map(const UuidConverter()).references(Projects, #id)();
  TextColumn get name => text()();
}

@DriftAccessor(tables: [Locations])
class LocationsDao extends DatabaseAccessor<SkaiDb> with _$LocationsDaoMixin {
  LocationsDao(super.attachedDatabase);

  Stream<List<Location>> getAllLocations() => select(locations).watch();

  Future<Location> insertSampleBeachHouse(UuidV projectId) async {
    return await into(locations).insertReturning(LocationsCompanion(
        id: Value(createRandomUuid()),
        projectId: Value(projectId),
        name: const Value('Sunny Beach House, Front Bench')));
  }

  Future<Location> insertSampleVilla(UuidV projectId) async {
    return await into(locations).insertReturning(LocationsCompanion(
        id: Value(createRandomUuid()),
        projectId: Value(projectId),
        name: const Value('Villa in the Woods, Office')));
  }
}

final locationsDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.locationsDao;
});

class Scenes extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get projectId =>
      text().map(const UuidConverter()).references(Projects, #id)();
  TextColumn get locationId =>
      text().map(const UuidConverter()).references(Locations, #id)();
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

class Shots extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get sceneId =>
      text().map(const UuidConverter()).references(Scenes, #id)();
  IntColumn get number => integer()();
  TextColumn get name => text()();
}

@DriftAccessor(tables: [Shots])
class ShotsDao extends DatabaseAccessor<SkaiDb> with _$ShotsDaoMixin {
  ShotsDao(super.attachedDatabase);

  // Stream<Map<int, List<Shot>>> getShotsForGivenScenes(List<String> sceneIds) {
  //   return (select(shots)..where((shot) => shot.sceneId.isIn(sceneIds)))
  //       .watch()
  //       .asyncMap((shots) =>
  //           // group by scene ID to a list of shots
  //           shots.fold<Map<String, List<Shot>>>({}, (map, shot) {
  //             if (map.containsKey(shot.sceneId)) {
  //               map[shot.sceneId]!.add(shot);
  //             } else {
  //               map[shot.sceneId] = [shot];
  //             }
  //             return map;
  //           }));
  // }
}

class Takes extends Table {
  TextColumn get id =>
      text().map(const UuidConverter()).map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get shotId =>
      text().map(const UuidConverter()).references(Shots, #id)();
  DateTimeColumn get started => dateTime().nullable()();
  DateTimeColumn get stopped => dateTime().nullable()();
}

@DriftDatabase(
    tables: [Projects, Locations, Scenes, Shots],
    daos: [ProjectsDao, LocationsDao, ScenesDao, ShotsDao])
class SkaiDb extends _$SkaiDb {
  SkaiDb() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 5) {
          await m.drop(projects);
          await m.drop(locations);
          await m.drop(scenes);
          await m.createAll();
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
