import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/settings/settings_notifier.dart';

import '../data/id.dart';

class SelectedProjectNotifier extends AsyncNotifier<Id?> {
  @override
  Future<Id?> build() async =>
      (await ref.read(settingsNotifier.future)).lastProjectId;

  Future<void> select(Id id) async {
    state = await AsyncValue.guard(() async {
      await ref.read(settingsNotifier.notifier).addSelectedProject(id);
      return id;
    });
  }
}

final selectedProjectNotifier =
    AsyncNotifierProvider<SelectedProjectNotifier, Id?>(() {
  return SelectedProjectNotifier();
});
