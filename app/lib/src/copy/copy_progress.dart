import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'copy_event.dart';
import 'copy_service.dart';

part 'copy_progress.freezed.dart';

@freezed
class CopyDirectory with _$CopyDirectory {
  const factory CopyDirectory({
    required Directory sourceDir,
    required Directory destDir,
    Glob? glob,
  }) = _CopyDirectories;
}

final copyServiceProvider = Provider<CopyService>((ref) {
  return CopyService();
});

final copyEventStreamProviderFamily = StreamProvider.autoDispose
    .family<CopyEvent, CopyDirectory>((ref, directories) {
  final copyService = ref.watch(copyServiceProvider);
  final sourceDir = directories.sourceDir;
  final destDir = directories.destDir;
  return copyService.copyDirectory(sourceDir, destDir, glob: directories.glob);
});

class CopyJobsNotifier extends Notifier<List<CopyDirectory>> {
  @override
  List<CopyDirectory> build() {
    return [];
  }

  void add(CopyDirectory directory) {
    state = [...state, directory];
  }
}

final copyJobsNotifierProvider =
    NotifierProvider<CopyJobsNotifier, List<CopyDirectory>>(() {
  return CopyJobsNotifier();
});

class CopyProgressWidget extends ConsumerWidget {
  final CopyDirectory directories;

  const CopyProgressWidget({
    required this.directories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copyEventAsyncValue =
        ref.watch(copyEventStreamProviderFamily(directories));
    return copyEventAsyncValue.when(
      data: (copyEvent) {
        if (copyEvent.isFinished) {
          return const Icon(
            Icons.check_circle,
            color: Colors.green,
          );
        } else if (copyEvent is CopyProgress) {
          return Column(
            children: [
              LinearProgressIndicator(
                value: copyEvent.bytesCopied / copyEvent.totalBytes,
              ),
              Text(
                '${copyEvent.bytesCopied} out of ${copyEvent.totalBytes} bytes copied',
              ),
            ],
          );
        } else {
          // For other event types, you may want to handle them separately.
          return const CircularProgressIndicator();
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}
