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

class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();
  TextColumn get name => text()();
}

class Scenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id)();
  IntColumn get locationId => integer().references(Locations, #id)();
  IntColumn get number => integer()();
  TextColumn get name => text()();
}

@DriftDatabase(tables: [Projects, Locations, Scenes])
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

  Stream<List<Project>> getAllProjects() => select(projects).watch();

  Future<void> createSampleProjects() async {
    for (int i = 0; i < 10; i++) {
      await insertSampleProject(i);
    }
  }

  Future<void> insertSampleProject(int i) async {
    await into(projects).insert(ProjectsCompanion(
        name: Value('Project $i'),
        description: const Value('This is a sample project description.')));

    final villa = await into(locations).insertReturning(LocationsCompanion(
        projectId: Value(i), name: const Value('Villa in the Woods, Office')));
    final sunnyBeachHouse = await into(locations).insertReturning(
        LocationsCompanion(
            projectId: Value(i),
            name: const Value('Sunny Beach House, Front Bench')));

    await into(scenes).insert(ScenesCompanion(
        projectId: Value(i),
        locationId: Value(villa.id),
        number: const Value(1),
        name: const Value('A normal day at work')));
    await into(scenes).insert(ScenesCompanion(
        projectId: Value(i),
        locationId: Value(sunnyBeachHouse.id),
        number: const Value(2),
        name: const Value('Epethany at the beach')));
  }

  Future<void> deleteProject(int id) async {
    await delete(projects).delete(ProjectsCompanion(id: Value(id)));
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
