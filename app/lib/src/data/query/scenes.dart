import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../id.dart';
import '../tables.dart';

part 'scenes.g.dart';
part 'scenes.freezed.dart';

@freezed
class SceneWithLocation with _$SceneWithLocation {
  const SceneWithLocation._();

  const factory SceneWithLocation({
    required Scene scene,
    required Location location,
  }) = _SceneWithLocation;
}

@DriftAccessor(tables: [Scenes])
class ScenesDao extends DatabaseAccessor<SkaiDb> with _$ScenesDaoMixin {
  ScenesDao(super.attachedDatabase);

  Stream<List<SceneWithLocation>> getScenesForProject(Id projectId) {
    final query = select(scenes)
        .join([innerJoin(locations, locations.id.equalsExp(scenes.locationId))])
      ..where(scenes.projectId.equals(projectId.toString()));
    final mapped = query.map((rows) {
      return SceneWithLocation(
        scene: rows.readTable(scenes),
        location: rows.readTable(locations),
      );
    });
    return mapped.watch();
  }

  Future<void> deleteScene(Id id) async {
    await (delete(scenes)..where((scene) => scene.id.equals(id.toString())))
        .go();
  }

  Future<void> upsertScene(ScenesCompanion scene) async {
    print("scenesCompanion: $scene");
    await into(scenes).insert(scene, mode: InsertMode.insertOrReplace);
  }
}

final scenesDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.scenesDao;
});
