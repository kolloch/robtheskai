import 'package:drift/drift.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/connection/connection.dart';
import 'package:robokru/src/data/query/locations.dart';
import 'package:robokru/src/data/query/projects.dart';
import 'package:robokru/src/data/query/scenes.dart';
import 'package:robokru/src/data/query/shots.dart';

import 'id.dart';

part 'tables.g.dart';

class Projects extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get name => text()();
  TextColumn get description => text()();
}

class Locations extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get projectId =>
      text().map(const UuidConverter()).references(Projects, #id)();
  TextColumn get name => text()();
}

class Scenes extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get projectId =>
      text().map(const UuidConverter()).references(Projects, #id)();
  TextColumn get locationId =>
      text().map(const UuidConverter()).references(Locations, #id)();
  TextColumn get number => text()();
  TextColumn get name => text()();
}

class Shots extends Table {
  TextColumn get id => text().map(const UuidConverter())();
  @override
  Set<Column<Object>> get primaryKey => {id};
  TextColumn get sceneId =>
      text().map(const UuidConverter()).references(Scenes, #id)();
  IntColumn get number => integer()();
  TextColumn get name => text()();
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
  daos: [ProjectsDao, LocationsDao, ScenesDao, ShotsDao],
)
class SkaiDb extends _$SkaiDb {
  SkaiDb() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      return connect();
    });
  }

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

class UuidConverter extends TypeConverter<Id, String> {
  const UuidConverter();

  @override
  Id fromSql(String fromDb) {
    return Id.fromString(fromDb);
  }

  @override
  String toSql(Id value) {
    return value.toString();
  }
}
