import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/uuid.dart';
import 'package:robokru/src/settings/settings_view.dart';
import 'package:robokru/src/skeleton/project_drop_down.dart';

class TopLevelNavigationDrawer extends ConsumerWidget {
  final UuidV? selectedProjectId;

  const TopLevelNavigationDrawer({Key? key, this.selectedProjectId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const edgeInsets = EdgeInsets.fromLTRB(28, 16, 16, 10);
    return NavigationDrawer(
      children: [
        Padding(
          padding: edgeInsets,
          child: Text(
            'Rob the Skai',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Padding(
          padding: edgeInsets,
          child: ProjectDropDown(),
        ),
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
