import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/settings/settings_service.dart';

import 'projects/project_scene_list.dart';
import 'projects/project_list.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

final FutureProvider<SettingsController> settingsControllerFutureProvider =
    FutureProvider((ref) async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  return settingsController;
});

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      name: ProjectListView.routeName,
      path: '/',
      builder: (context, state) => const ProjectListView(),
    ),
    GoRoute(
      name: ProjectSceneList.routeName,
      path: '/sampleItemDetails/:id',
      builder: (context, state) => const ProjectSceneList(),
    ),
    GoRoute(
      name: SettingsView.routeName,
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
  ],
);

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maybeSettingsController =
        ref.watch(settingsControllerFutureProvider).asData;

    if (maybeSettingsController?.isLoading ?? true) {
      // While the SettingsController is loading, display a loading screen.
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else if (maybeSettingsController?.error != null) {
      // If the SettingsController has an error, display an error screen.
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error loading settings'),
          ),
        ),
      );
    }

    final settingsController = maybeSettingsController!.value;

    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          routerConfig: _router,
        );
      },
    );
  }
}
