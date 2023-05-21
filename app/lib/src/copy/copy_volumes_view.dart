import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/copy/copy_progress.dart';
import 'package:robokru/src/data/id.dart';
import 'package:volume_plugin/volume_plugin.dart';

import '../projects/selected_project.dart';
import '../skeleton/top_level_navigation_drawer.dart';
import 'cancellation_token.dart';

final volumesPluginProvider = Provider<VolumePlugin>((ref) {
  return VolumePlugin();
});

final volumesProvider = StreamProvider<List<Volume>>((ref) {
  final plugin = ref.watch(volumesPluginProvider);
  return plugin.uptodateVolumes;
});

class CopyVolumesView extends ConsumerWidget {
  static const routeName = '/project/copyVolumes';

  final Id projectId;

  const CopyVolumesView({required this.projectId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allVolumes = ref.watch(volumesProvider).asData?.value ?? [];
    final volumes = allVolumes.where((element) => element.isRemovable).toList();

    final volumeList = ListView.builder(
      itemCount: volumes.length,
      itemBuilder: (context, index) {
        final volume = volumes[index];
        return ListTile(
          title: Text(volume.mediaName ?? "No name"),
          subtitle: Text(volume.toString()),
          trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                final Directory sourceDir =
                    const LocalFileSystem().directory(volume.volumeDirectory);
                ref.watch(copyJobsNotifierProvider.notifier).add(CopyDirectory(
                    sourceDir: sourceDir,
                    destDir: const LocalFileSystem()
                        .directory('/Users/peterkolloch/projects/files'),
                    token: CancellationToken()));
              }),
        );
      },
    );

    final CopyJobsNotifier copyJobsNotifier =
        ref.watch(copyJobsNotifierProvider.notifier);
    final copyJobs = ref.watch(copyJobsNotifierProvider);
    final copyJobsProgressList = ListView.builder(
      itemCount: copyJobs.length,
      itemBuilder: (context, index) {
        final copyJob = copyJobs[index];
        return ListTile(
          title: Text(copyJob.sourceDir.path),
          subtitle: CopyProgressWidget(directories: copyJob),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('External Volumes'),
      ),
      body: Column(children: [
        Expanded(child: volumeList),
        Expanded(child: copyJobsProgressList),
      ]),
      drawer: TopLevelNavigationDrawer(selectedProjectId: projectId),
    );
  }
}
