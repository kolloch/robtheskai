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
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Rob the Skai'),
          ),
          const ProjectDropDown(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context.replaceNamed(SettingsView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
