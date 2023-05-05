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
  IntColumn get number => integer()();
  TextColumn get name => text()();
}

@DriftDatabase(tables: [Projects, Locations, Scenes])
class SkaiDb extends _$SkaiDb {
  SkaiDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Project>> getAllProjects() => select(projects).watch();

  Future<void> createSampleProjects() async {
    await into(projects).insert(const Project(
        id: 1,
        name: 'Project 1',
        description: 'This is a sample project description.'));
    await into(projects).insert(const Project(
        id: 2,
        name: 'Project 2',
        description: 'This is a sample project description.'));
    await into(projects).insert(const Project(
        id: 3,
        name: 'Project 3',
        description: 'This is a sample project description.'));
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
