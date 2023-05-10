import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../tables.dart';
import '../uuid.dart';

part 'shots.g.dart';

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
