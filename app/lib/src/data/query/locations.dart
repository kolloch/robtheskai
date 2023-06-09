import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../tables.dart';
import '../id.dart';

part 'locations.g.dart';

@DriftAccessor(tables: [Locations])
class LocationsDao extends DatabaseAccessor<SkaiDb> with _$LocationsDaoMixin {
  LocationsDao(super.attachedDatabase);

  Stream<List<Location>> getAllLocations() => select(locations).watch();

  Stream<List<Location>> getProjectLocations(Id projectId) => (select(locations)
        ..where((location) => location.projectId.equals(projectId.toString())))
      .watch();

  Future<Location> insertSampleBeachHouse(Id projectId) async {
    return await into(locations).insertReturning(LocationsCompanion(
        id: Value(Id.random()),
        projectId: Value(projectId),
        name: const Value('Sunny Beach House, Front Bench')));
  }

  Future<Location> insertSampleVilla(Id projectId) async {
    return await into(locations).insertReturning(LocationsCompanion(
        id: Value(Id.random()),
        projectId: Value(projectId),
        name: const Value('Villa in the Woods, Office')));
  }
}

final locationsDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.locationsDao;
});

final projectLocationsProvider =
    StreamProvider.autoDispose.family<List<Location>, Id>(
  (ref, projectId) {
    final locationsDao = ref.watch(locationsDaoProvider);
    return locationsDao.getProjectLocations(projectId);
  },
);
