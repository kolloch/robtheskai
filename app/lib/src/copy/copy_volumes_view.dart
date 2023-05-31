import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glob/glob.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_bytes/pretty_bytes.dart';
import 'package:robokru/src/copy/copy_progress.dart';
import 'package:robokru/src/copy/model.dart';
import 'package:robokru/src/data/id.dart';
import 'package:volume_plugin/volume_plugin.dart';

import '../skeleton/top_level_navigation_drawer.dart';
import 'cancellation_token.dart';

final volumesPluginProvider = Provider<VolumePlugin>((ref) {
  return VolumePlugin();
});

final volumesProvider = StreamProvider.autoDispose<List<Volume>>((ref) {
  final plugin = ref.watch(volumesPluginProvider);
  return plugin.uptodateVolumes;
});

enum VolumeFilter { external, ejectable, internal }

class CopyFilesView extends HookConsumerWidget {
  static const routeName = '/project/copyFiles';

  final Id projectId;

  const CopyFilesView({required this.projectId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectDestinationFolder = useState<Directory?>(null);

    final allVolumes = ref.watch(volumesProvider).asData?.value ?? [];

    // Volume filters. Show volume if any of these match.
    final showExternal = useState(true);
    final showEjectable = useState(true);
    final showInternal = useState(false);

    final volumes = allVolumes
        .where((element) =>
            (element.volumeDirectory != "autofs" ||
                element.deviceInternal == false) &&
            element.volumeDirectory != null &&
            (element.volumeUUID ?? element.mediaUUID) != null &&
            ((showExternal.value &&
                    (element.isRemovable ||
                        element.deviceProtocol == "USB" ||
                        element.deviceInternal == false)) ||
                (showEjectable.value && element.mediaEjectable != false) ||
                (showInternal.value && element.deviceInternal != false)))
        .toList();
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
        var name = volume.volumeName ?? volume.mediaName ?? "No name";
        final prettySize = volume.mediaSize != null
            ? "${prettyBytes(volume.mediaSize?.toDouble() ?? 0)} "
            : '';
        return ListTile(
          title: Text("${name} ($prettySize${volume.volumeKind})"),
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
                          child: SelectableText(
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
              // does not work
              if (volume.mediaEjectable == true)
                IconButton(
                    icon: const Icon(Icons.eject),
                    onPressed: () {
                      print("Ejecting ${volume.volumeUUID} initiated");
                      ref.read(volumesPluginProvider).eject(volume!).then(
                          (value) => print("Ejected ${volume.volumeUUID}"),
                          onError: (e, s) => print(
                              "(NOT WORKING PROPERLY) ejected ${e} ${volume.volumeUUID}"));
                    }),
              IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: mediaUUID != null &&
                          projectDestinationFolder.value != null
                      ? () {
                          final Directory sourceDir = const LocalFileSystem()
                              .directory(volume.volumeDirectory);
                          ref.read(copyJobsNotifierProvider.notifier).upsertJob(
                              Id.fromString(mediaUUID),
                              CopyFiles(
                                  srcVolume: sourceDir,
                                  dstVolume: projectDestinationFolder.value!,
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show and allow to select the project destination folder
          // using the file picker.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Project destination folder: '),
              Text(
                projectDestinationFolder.value?.path ?? 'None',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: () async {
                  final result = await FilePicker.platform.getDirectoryPath(
                      initialDirectory: projectDestinationFolder.value?.path);
                  if (result != null) {
                    projectDestinationFolder.value =
                        const LocalFileSystem().directory(result);
                  }
                },
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton(
                multiSelectionEnabled: true,
                emptySelectionAllowed: true,
                showSelectedIcon: false,
                selected: <VolumeFilter>{
                  if (showExternal.value) VolumeFilter.external,
                  if (showEjectable.value) VolumeFilter.ejectable,
                  if (showInternal.value) VolumeFilter.internal,
                },
                segments: const <ButtonSegment<VolumeFilter>>[
                  ButtonSegment(
                    value: VolumeFilter.external,
                    label: Text('External'),
                    icon: Icon(Icons.sd_card),
                  ),
                  ButtonSegment(
                    value: VolumeFilter.ejectable,
                    label: Text('Ejectable'),
                    icon: Icon(Icons.eject),
                  ),
                  ButtonSegment(
                    value: VolumeFilter.internal,
                    label: Text('Internal'),
                    icon: Icon(Icons.storage),
                  ),
                ],
                onSelectionChanged: (Set<VolumeFilter> selected) {
                  showExternal.value = selected.contains(VolumeFilter.external);
                  showEjectable.value =
                      selected.contains(VolumeFilter.ejectable);
                  showInternal.value = selected.contains(VolumeFilter.internal);
                },
              )),
          Expanded(child: volumeList)
        ],
      ),
      drawer: TopLevelNavigationDrawer(selectedProjectId: projectId),
    );
  }
}
