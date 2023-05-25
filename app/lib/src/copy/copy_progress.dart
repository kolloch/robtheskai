import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_bytes/pretty_bytes.dart';
import 'package:robokru/src/copy/model.dart';

import '../data/id.dart';
import 'copy_service.dart';

final copyServiceProvider = Provider<CopyService>((ref) {
  return CopyService();
});

class CopyJobsNotifier extends Notifier<PersistentHashMap<Id, CopyFiles>> {
  @override
  PersistentHashMap<Id, CopyFiles> build() {
    return const PersistentHashMap.empty();
  }

  void cancelJob(Id id) {
    print("cancelJob($id)");
    final job = state[id];
    if (job != null) {
      job.token.cancel();
      state = state.put(id, job.copyWith(followUp: null));
    }
  }

  CopyFiles upsertJob(Id id, CopyFiles job) {
    print("upsertJob($id, $job)");

    // when the job already exists, we need to cancel it first.
    final existingJob = state[id];
    if (existingJob != null &&
        (existingJob.lastEvent.isLoading ||
            existingJob.lastEvent.asData?.value.isFinished == false)) {
      cancelJob(id);
    } else {
      print("upsertJob($id, $job) - start copy");
      final progressStream = ref.read(copyServiceProvider).copyDirectory(
          job.srcVolume, job.dstVolume,
          glob: job.rule.srcGlob, token: job.token);
      progressStream.listen((event) {
        state = state.put(id, job.copyWith(lastEvent: AsyncData(event)));
      }, onDone: () {
        final job2 = state[id]!;
        final lastEvent2 = job2.lastEvent.asData;
        if (job2.followUp != null) {
          upsertJob(id, job.followUp!);
        } else if (lastEvent2?.value.isFinished == false &&
            lastEvent2?.value is CopyProgress) {
          state = state.put(
              id,
              job2.copyWith(
                  lastEvent: AsyncValue.data(CopyEvent.copyCancelled(
                      lastEvent2!.value as CopyProgress))));
        }
      }, onError: (error, stacktrace) {
        final job2 = state[id]!;
        state = state.put(
            id, job2.copyWith(lastEvent: AsyncValue.error(error, stacktrace)));
        if (job2.followUp != null) {
          upsertJob(id, job2.followUp!);
        }
      });

      state = state.put(id, job);
    }

    return job;
  }

  CopyFiles? getJob(String mediaUUID) {
    return state[Id.fromString(mediaUUID)];
  }
}

final copyJobsNotifierProvider =
    NotifierProvider<CopyJobsNotifier, PersistentHashMap<Id, CopyFiles>>(() {
  return CopyJobsNotifier();
});

class CopyProgressWidget extends ConsumerWidget {
  final Id ruleId;

  const CopyProgressWidget({
    super.key,
    required this.ruleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copyEventAsyncValue = ref.watch(copyJobsNotifierProvider.select(
      (state) =>
          state[ruleId]?.lastEvent ??
          const AsyncValue.error("Not found", StackTrace.empty),
    ));
    return copyEventAsyncValue.when(
      data: (copyEvent) {
        if (copyEvent.isFinished && copyEvent is CopyProgress) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                'Finished copying ${prettyBytes(copyEvent.totalBytes.toDouble())} bytes of added files.',
              ),
            ],
          );
        } else if (copyEvent is CopyProgress) {
          return Column(
            children: [
              LinearProgressIndicator(
                value: copyEvent.bytesCopied / copyEvent.totalBytes,
              ),
              Text(
                '${prettyBytes(copyEvent.bytesCopied.toDouble())} out of ${prettyBytes(copyEvent.totalBytes.toDouble())} bytes copied',
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  ref.read(copyJobsNotifierProvider.notifier).cancelJob(ruleId);
                },
              ),
            ],
          );
        } else if (copyEvent is CopyCancelled) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.cancel,
                color: Theme.of(context).colorScheme.error,
              ),
              Text(
                'Cancelled after copying ${prettyBytes(copyEvent.lastEvent.bytesCopied.toDouble())} bytes',
              ),
            ],
          );
        } else {
          // For other event types, you may want to handle them separately.
          return const CircularProgressIndicator();
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => Icon(
        Icons.error,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
