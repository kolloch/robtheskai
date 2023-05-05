import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/tables.dart';

import '../settings/settings_view.dart';
import 'project_scene_list.dart';

final projectsProvider = StreamProvider((ref) {
  final skaidb = ref.watch(skaiDbProvider);
  return skaidb.getAllProjects();
});

/// Displays a list of SampleItems.
class ProjectListView extends ConsumerWidget {
  const ProjectListView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);

    // spinner if projects still loading or show error
    if (projects.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (projects.error != null) {
      return const Scaffold(
        body: Center(
          child: Text('Error loading projects.'),
        ),
      );
    }

    final items = projects.asData?.value;
    final Widget body;
    if (items != null && items.isNotEmpty) {
      body = ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final Project item = items[index];

          return ListTile(
              key: Key('project-${item.id}'),
              title: Text(item.name),
              subtitle: Text(item.description),
              // trailing delete button
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final skaidb = ref.read(skaiDbProvider);
                  await skaidb.deleteProject(item.id);
                },
              ),
              onTap: () {
                context.pushNamed(ProjectSceneList.routeName, pathParameters: {
                  'id': item.id.toString(),
                });
              });
        },
      );
    } else {
      // assign centered button to create sample projects to body
      body = Center(
        child: ElevatedButton(
          child: const Text('Create Sample Projects'),
          onPressed: () async {
            final skaidb = ref.read(skaiDbProvider);
            await skaidb.createSampleProjects();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed(SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: body,
    );
  }
}
