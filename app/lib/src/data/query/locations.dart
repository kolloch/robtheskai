import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../tables.dart';
import '../uuid.dart';

part 'locations.g.dart';

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
