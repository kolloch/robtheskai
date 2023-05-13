import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  final SharedPreferences _preferences;

  SettingsService(this._preferences);

  static Future<SettingsService> create() async {
    return SettingsService(await SharedPreferences.getInstance());
  }

  Future<ThemeMode> themeMode() async {
    final themeText = _preferences.getString('theme') ?? 'system';
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == themeText,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    await _preferences.setString('theme', theme.toString());
  }
}
