import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/projects/project_scene_list.dart';
import 'package:robokru/src/settings/settings_notifier.dart';
import 'package:robokru/src/settings/settings_view.dart';
import 'package:robokru/src/supabase/account_page.dart';
import 'package:robokru/src/supabase/login_page.dart';
import 'package:robokru/src/supabase/splash_page.dart';

import 'copy/copy_volumes_view.dart';
import 'data/id.dart';
import 'projects/project_list.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maybeSettingsController = ref.watch(settingsNotifier).asData;

    if (maybeSettingsController?.isLoading ?? true) {
      // While the SettingsController is loading, display a loading screen.
      return minimalCentered(const CircularProgressIndicator());
    } else if (maybeSettingsController?.error != null) {
      // If the SettingsController has an error, display an error screen.
      return minimalCentered(const Text('Error loading settings'));
    }

    final settings = maybeSettingsController!.value;

    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: AccountSplashPage.routeName,
          path: "/account",
          builder: (context, state) => const AccountSplashPage(),
        ),
        GoRoute(
          name: LoginPage.routeName,
          path: "/account/login",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: AccountPage.routeName,
          path: "/account/signup",
          builder: (context, state) => const AccountPage(),
        ),
        GoRoute(
          name: ProjectListView.routeName,
          path: '/projects',
          builder: (context, state) => const ProjectListView(),
        ),
        GoRoute(
          name: ProjectSceneList.routeName,
          path: '/projects/:projectId/scenes',
          builder: (context, state) => ProjectSceneList(
            projectId: Id.fromString(state.pathParameters['projectId']!),
          ),
        ),
        GoRoute(
          name: CopyFilesView.routeName,
          path: '/projects/:projectId/copyVolumes',
          builder: (context, state) => CopyFilesView(
            projectId: Id.fromString(state.pathParameters['projectId']!),
          ),
        ),
        GoRoute(
          name: SettingsView.routeName,
          path: '/settings',
          builder: (context, state) => const SettingsView(),
        ),
      ],
      initialLocation: '/',
      redirect: (context, state) => switch (state.location) {
        '/' => settings.lastProjectId != null
            ? '/projects/${settings.lastProjectId}/scenes'
            : '/projects',
        _ => null,
      },
    );

    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp.router(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'robtheskai',

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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: settings.themeMode,

      routerConfig: router,
    );
  }

  MaterialApp minimalCentered(Widget circularProgressIndicator) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: circularProgressIndicator,
        ),
      ),
    );
  }
}
