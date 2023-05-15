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
  @override
  FutureOr<Settings> build() async {
    final sharedPreferences = await ref.read(sharedPreferencesProvider.future);
    final theme = sharedPreferences.getString('theme') ?? 'system';
    final themeMode = ThemeMode.values.firstWhere(
      (e) => e.toString() == theme,
      orElse: () => ThemeMode.system,
    );
    return Settings(themeMode: themeMode, lastProjectIds: []);
  }

  Future<void> updateThemeMode(ThemeMode? theme) async {
    final value = await future;
    final sharedPreferences = await ref.read(sharedPreferencesProvider.future);

    state = await AsyncValue.guard(() async {
      await sharedPreferences.setString('theme', theme.toString());
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
        'lastProjectIds',
        lastProjectIds.map((id) => id.toString()).toList(),
      );

      return value.copyWith(lastProjectIds: lastProjectIds);
    });
  }
}

final settingsNotifier =
    AsyncNotifierProvider<SettingsNotifier, Settings>(() => SettingsNotifier());
