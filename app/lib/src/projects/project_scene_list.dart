import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/id.dart';

import '../data/query/scenes.dart';
import '../skeleton/consumer_async_value_widget.dart';
import '../skeleton/top_level_navigation_drawer.dart';

final projectScenesProvider =
    StreamProvider.autoDispose.family<List<SceneWithLocation>, Id>(
  (ref, projectId) {
    final scenesDao = ref.watch(scenesDaoProvider);
    return scenesDao.getScenesForProject(projectId);
  },
);

/// Displays a list of scenes for the project with the given id.
class ProjectSceneList extends ConsumerWidget {
  static const routeName = '/projects/:projectId/scenes';

  final Id projectId;

  const ProjectSceneList({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenes = ref.watch(projectScenesProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scenes'),
      ),
      drawer: TopLevelNavigationDrawer(selectedProjectId: projectId),
      body: ConsumerAsyncValueWidget(
        asyncValue: scenes,
        buildWithData: (context, ref, List<SceneWithLocation> scenes) {
          final Widget body;
          if (scenes.isNotEmpty) {
            body = ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sceneList',
              itemCount: scenes.length,
              itemBuilder: (BuildContext context, int index) {
                final sceneWithLocation = scenes[index];
                final scene = sceneWithLocation.scene;

                return ListTile(
                  key: Key('scene-${scene.id}'),
                  title: Text(sceneWithLocation.location.name),
                  subtitle: Text(scene.name),
                  // trailing delete button
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final skaidb = ref.read(scenesDaoProvider);
                      await skaidb.deleteScene(scene.id);
                    },
                  ),
                  onTap: () {},
                );
              },
            );
          } else {
            body = const Center(
              child: Text('No scenes found'),
            );
          }

          return body;
        },
      ),
    );
  }
}
