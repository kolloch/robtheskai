import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/id.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

class SettingsNotifier extends AsyncNotifier<Settings> {
  static const LAST_PROJECT_IDS_KEY = 'lastProjectIds';
  static const THEME_KEY = 'theme';

  @override
  FutureOr<Settings> build() async {
    final sharedPreferences = await ref.read(sharedPreferencesProvider.future);
    final theme =
        sharedPreferences.getString(THEME_KEY) ?? ThemeMode.system.toString();
    final themeMode = ThemeMode.values.firstWhere(
      (e) => e.toString() == theme,
      orElse: () => ThemeMode.system,
    );
    final lastProjectIds = sharedPreferences
            .getStringList(LAST_PROJECT_IDS_KEY)
            ?.map((id) => Id.fromString(id))
            .toList() ??
        [];
    return Settings(themeMode: themeMode, lastProjectIds: lastProjectIds);
  }

  Future<void> updateThemeMode(ThemeMode? theme) async {
    final value = await future;
    final sharedPreferences = await ref.read(sharedPreferencesProvider.future);

    state = await AsyncValue.guard(() async {
      await sharedPreferences.setString(THEME_KEY, theme.toString());
      return value.copyWith(themeMode: theme ?? ThemeMode.system);
    });
  }

  Future<void> addSelectedProject(Id projectId) async {
    final value = await future;
    final sharedPreferences = await ref.read(sharedPreferencesProvider.future);

    state = await AsyncValue.guard(() async {
      final lastProjectIds = [
        projectId,
        ...value.lastProjectIds.where((id) => id != projectId),
      ].take(3).toList();

      await sharedPreferences.setStringList(
        LAST_PROJECT_IDS_KEY,
        lastProjectIds.map((id) => id.toString()).toList(),
      );

      return value.copyWith(lastProjectIds: lastProjectIds);
    });
  }
}

final settingsNotifier =
    AsyncNotifierProvider<SettingsNotifier, Settings>(() => SettingsNotifier());
