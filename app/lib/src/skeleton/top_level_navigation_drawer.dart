import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/copy/copy_volumes_view.dart';
import 'package:robokru/src/data/id.dart';
import 'package:robokru/src/data/query/projects.dart';
import 'package:robokru/src/data/tables.dart';
import 'package:robokru/src/projects/project_list.dart';
import 'package:robokru/src/projects/project_scene_list.dart';
import 'package:robokru/src/settings/settings_view.dart';

import '../projects/selected_project.dart';

final selectedProjectProvider = StreamProvider<Project?>((ref) {
  final ProjectsDao projectsDao = ref.watch(projectsDaoProvider);
  final selectedProjectId = ref.watch(selectedProjectNotifier).valueOrNull;
  if (selectedProjectId == null) return Stream.value(null);
  return projectsDao
      .getProjectsById([selectedProjectId]).map((event) => event.values.first);
});

class TopLevelNavigationDrawer extends ConsumerWidget {
  final Id? selectedProjectId;

  const TopLevelNavigationDrawer({Key? key, this.selectedProjectId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const edgeInsets = EdgeInsets.fromLTRB(28, 16, 16, 10);
    final project = ref.watch(selectedProjectProvider).valueOrNull;
    final projectActions = project != null
        ? [
            const Divider(),
            Padding(
                padding: edgeInsets,
                child: ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Scenes'),
                  onTap: () {
                    context.pushReplacementNamed(ProjectSceneList.routeName,
                        pathParameters: {
                          'projectId': selectedProjectId!.toString(),
                        });
                  },
                )),
            Padding(
                padding: edgeInsets,
                child: ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Copy Files'),
                  onTap: () {
                    context.pushReplacementNamed(CopyVolumesView.routeName,
                        pathParameters: {
                          'projectId': selectedProjectId!.toString(),
                        });
                  },
                )),
          ]
        : [];

    return NavigationDrawer(
      children: [
        Padding(
            padding: edgeInsets,
            child: Column(
              children: [
                Text(
                  'Rob the Skai',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (project != null) const SizedBox(height: 8),
                if (project != null)
                  Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
              ],
            )),
        Padding(
            padding: edgeInsets,
            child: ListTile(
              leading: Icon(selectedProjectId == null
                  ? Icons.folder_off
                  : Icons.folder_open),
              title: Text(selectedProjectId == null
                  ? 'Select Project'
                  : 'Change Project'),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.replaceNamed(ProjectListView.routeName);
              },
            )),
        ...projectActions,
        const Divider(),
        Padding(
            padding: edgeInsets,
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                context.replaceNamed(SettingsView.routeName);
              },
            )),
      ],
    );
  }
}
