import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glob/glob.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/copy/copy_progress.dart';
import 'package:robokru/src/copy/model.dart';
import 'package:robokru/src/data/id.dart';
import 'package:volume_plugin/volume_plugin.dart';

import '../skeleton/top_level_navigation_drawer.dart';
import 'cancellation_token.dart';

final volumesPluginProvider = Provider<VolumePlugin>((ref) {
  return VolumePlugin();
});

final volumesProvider = StreamProvider<List<Volume>>((ref) {
  final plugin = ref.watch(volumesPluginProvider);
  return plugin.uptodateVolumes;
});

class CopyFilesView extends HookConsumerWidget {
  static const routeName = '/project/copyFiles';

  final Id projectId;

  const CopyFilesView({required this.projectId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allVolumes = ref.watch(volumesProvider).asData?.value ?? [];
    final volumes = allVolumes.where((element) => element.isRemovable).toList();
    final rule = useState(CopyRule(
      srcGlob: Glob('**/*'),
      dstSubPath: null,
      flatten: false,
      byDate: false,
    ));

    final volumeList = ListView.builder(
      itemCount: volumes.length,
      itemBuilder: (context, index) {
        final volume = volumes[index];
        final mediaUUID = volume.mediaUUID ?? volume.volumeUUID;
        final job = mediaUUID == null
            ? null
            : ref.watch(copyJobsNotifierProvider)[Id.fromString(mediaUUID)];
        return ListTile(
          title: Text(volume.mediaName ?? "No name"),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // allow editing the rule
              Row(
                children: [
                  const Text('Rule: '),
                  Text(rule.value.srcGlob.pattern),
                  const Text(' -> '),
                  Text(rule.value.dstSubPath ?? '[root]'),
                ],
              ),
              // add theme appropriate padding
              SizedBox(height: Theme.of(context).dividerTheme.space ?? 8),
              if (job != null)
                CopyProgressWidget(ruleId: Id.fromString(mediaUUID!)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // add info icon which deplays a dialog with volume.toString()
              IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Volume Info'),
                        // volume.prettyJson in a scrollable text widget monospace
                        content: SingleChildScrollView(
                          child: Text(
                            volume.prettyJson,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  }),
              if (volume.mediaEjectable == true)
                IconButton(
                    icon: const Icon(Icons.eject),
                    onPressed: () async {
                      await ref
                          .read(volumesPluginProvider)
                          .eject(volume.volumeUUID!);
                      print(
                          "(NOT WORKING PROPERLY) ejected ${volume.volumeUUID}");
                    }),
              IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: mediaUUID != null
                      ? () {
                          final Directory sourceDir = const LocalFileSystem()
                              .directory(volume.volumeDirectory);
                          ref
                              .watch(copyJobsNotifierProvider.notifier)
                              .upsertJob(
                                  Id.fromString(mediaUUID),
                                  CopyFiles(
                                      srcVolume: sourceDir,
                                      dstVolume: const LocalFileSystem().directory(
                                          '/Users/peterkolloch/projects/files'),
                                      rule: CopyRule(
                                        srcGlob: Glob('**'),
                                        dstSubPath: null,
                                        flatten: false,
                                        byDate: false,
                                      ),
                                      token: CancellationToken()));
                        }
                      : null),
            ],
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('External Volumes'),
      ),
      body: volumeList,
      drawer: TopLevelNavigationDrawer(selectedProjectId: projectId),
    );
  }
}
