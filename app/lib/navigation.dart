import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/navigation_app.dart';

void main() async {
  runApp(const ProviderScope(
    child: NavigationApp(),
  ));
}
