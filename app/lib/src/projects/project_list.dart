import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/tables.dart';
import 'package:robokru/src/projects/selected_project.dart';
import 'package:robokru/src/skeleton/consumer_async_value_widget.dart';

import '../data/query/projects.dart';
import '../data/id.dart';
import '../skeleton/top_level_navigation_drawer.dart';

final projectsProvider = StreamProvider.autoDispose((ref) {
  final skaidb = ref.watch(projectsDaoProvider);
  return skaidb.getAllProjects();
});

/// Displays a list of SampleItems.
class ProjectListView extends ConsumerWidget {
  const ProjectListView({
    super.key,
  });

  static const routeName = '/projects';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final Id? selectedProjectId =
        ref.watch(selectedProjectNotifier).valueOrNull;

    return ConsumerAsyncValueWidget(
      asyncValue: projects,
      buildWithData: (context, ref, List<Project> items) {
        final Widget body;
        if (items.isNotEmpty) {
          body = ListView.builder(
            // Providing a restorationId allows the ListView to restore the
            // scroll position when a user leaves and returns to the app after it
            // has been killed while running in the background.
            restorationId: 'projectList',
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
                      // ask for confirmation
                      final bool? delete = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Project?'),
                            content: Text(
                                'Are you sure you want to delete ${item.name}?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );

                      if (delete == true) {
                        final skaidb = ref.read(projectsDaoProvider);
                        await skaidb.deleteProject(item.id);
                      }
                    },
                  ),
                  onTap: () {
                    ref.read(selectedProjectNotifier.notifier).select(item.id);
                    Scaffold.of(context).openDrawer();
                  });
            },
          );
        } else {
          // assign centered button to create sample projects to body
          body = Center(
            child: ElevatedButton(
              child: const Text('Create Sample Projects'),
              onPressed: () async {
                final skaidb = ref.read(projectsDaoProvider);
                await skaidb.createSampleProjects();
              },
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Projects'),
          ),

          // To work with lists that may contain a large number of items, it’s best
          // to use the ListView.builder constructor.
          //
          // In contrast to the default ListView constructor, which requires
          // building all Widgets up front, the ListView.builder constructor lazily
          // builds Widgets as they’re scrolled into view.
          body: body,

          drawer:
              TopLevelNavigationDrawer(selectedProjectId: selectedProjectId),
        );
      },
    );
  }
}
