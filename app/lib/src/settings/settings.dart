import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/id.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const Settings._();

  const factory Settings({
    required ThemeMode themeMode,
    required List<Id> lastProjectIds,
  }) = _Settings;

  Id? get lastProjectId {
    if (lastProjectIds.isEmpty) {
      return null;
    }
    return lastProjectIds.first;
  }
}
