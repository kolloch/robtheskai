import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/id.dart';

class SelectedProjectNotifier extends Notifier<Id?> {
  @override
  Id? build() => null;

  void select(Id id) {
    state = id;
  }
}

final selectedProjectProvider =
    NotifierProvider<SelectedProjectNotifier, Id?>(() {
  return SelectedProjectNotifier();
});
