import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/id.dart';

import '../data/query/scenes.dart';
import '../data/tables.dart';

final projectScenesProvider =
    StreamProvider.autoDispose.family<List<Scene>, Id>(
  (ref, projectId) {
    final scenesDao = ref.watch(scenesDaoProvider);
    return scenesDao.getScenesForProject(projectId);
  },
);

class ProjectSceneList extends StatelessWidget {
  final Id projectId;

  const ProjectSceneList({super.key, required this.projectId});

  static const routeName = '/project_scene_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
