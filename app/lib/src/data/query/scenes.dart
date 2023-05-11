import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../tables.dart';

part 'scenes.g.dart';

@DriftAccessor(tables: [Scenes])
class ScenesDao extends DatabaseAccessor<SkaiDb> with _$ScenesDaoMixin {
  ScenesDao(super.attachedDatabase);

  Stream<List<Scene>> getAllScenes() => select(scenes).watch();
}

final scenesDaoProvider = Provider((ref) {
  final db = ref.watch(skaiDbProvider);
  return db.scenesDao;
});
