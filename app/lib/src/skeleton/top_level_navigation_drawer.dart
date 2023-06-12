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
import '../supabase/account_page.dart';
import '../supabase/splash_page.dart';
import '../supabase/supabase.dart';

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
                    context.pushReplacementNamed(CopyFilesView.routeName,
                        pathParameters: {
                          'projectId': selectedProjectId!.toString(),
                        });
                  },
                )),
          ]
        : [];

    final authState = ref.watch(authStateProvider).asData?.value;
    final session = authState?.session;
    final user = session?.user;
    final email = user?.email;

    return NavigationDrawer(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            children: [
              Text(
                'Rob the Skai',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (email != null) const SizedBox(height: 8),
              if (email == null)
                TextButton.icon(
                    onPressed: () {
                      context.pushReplacementNamed(AccountSplashPage.routeName);
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login'))
              else
                // current logged in email, on tap go to account page
                TextButton.icon(
                    onPressed: () {
                      context.pushReplacementNamed(AccountPage.routeName);
                    },
                    icon: const Icon(Icons.account_circle),
                    label: Text(email)),
              if (project != null) const SizedBox(height: 8),
              if (project != null)
                Text(
                  project.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
            ],
          ),
        ),
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
