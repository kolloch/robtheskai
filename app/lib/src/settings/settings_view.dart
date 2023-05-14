import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/id.dart';
import 'package:robokru/src/projects/selected_project.dart';
import 'package:robokru/src/skeleton/top_level_navigation_drawer.dart';

import '../app.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the SettingsController provided by the SettingsControllerProvider
    // above to listen to changes to the selected theme.
    final controller =
        ref.watch(settingsControllerFutureProvider).asData!.value;

    final Id? selectedProjectId =
        ref.watch(selectedProjectNotifier).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: TopLevelNavigationDrawer(selectedProjectId: selectedProjectId),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: DropdownButton<ThemeMode>(
          // Read the selected themeMode from the controller
          value: controller.themeMode,
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: controller.updateThemeMode,
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ),
    );
  }
}
