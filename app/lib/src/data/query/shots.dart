import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../id.dart';
import '../tables.dart';

part 'shots.g.dart';

final shotsDaoProvider = Provider<ShotsDao>((ref) {
  final db = ref.watch(skaiDbProvider);
  return ShotsDao(db);
});

final shotsBySceneIdProvider = StreamProvider.family<Map<Id, List<Shot>>, Id>(
  (ref, projectId) {
    final shotsDao = ref.watch(shotsDaoProvider);
    return shotsDao.getShotsForProjectIdBySceneId(projectId);
  },
);

@DriftAccessor(tables: [Shots, Scenes])
class ShotsDao extends DatabaseAccessor<SkaiDb> with _$ShotsDaoMixin {
  ShotsDao(super.attachedDatabase);

  Stream<Map<Id, List<Shot>>> getShotsForProjectIdBySceneId(Id projectId) {
    final query = select(shots).join([
      innerJoin(scenes, scenes.id.equalsExp(shots.sceneId)),
    ])
      ..where(scenes.projectId.equals(projectId.toString()))
      ..orderBy([OrderingTerm(expression: shots.number)]);

    return query.watch().map((rows) {
      final shotsBySceneId = groupBy<Shot, Id>(
        rows.map((row) => row.readTable(shots)),
        (shot) => shot.sceneId,
      );
      return shotsBySceneId;
    });
  }

  Future<void> deleteShot(Id id) {
    return (delete(shots)..where((t) => t.id.equals(id.toString()))).go();
  }

  Future<void> upsertShot(ShotsCompanion shotCompanion) {
    return into(shots).insertOnConflictUpdate(shotCompanion);
  }
}
