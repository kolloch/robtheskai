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

enum VolumeFilter { ejectable, internal }

class CopyFilesView extends HookConsumerWidget {
  static const routeName = '/project/copyFiles';

  final Id projectId;

  const CopyFilesView({required this.projectId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectDestinationFolder = useState<Directory?>(null);
    final volumePlugin = ref.watch(volumesPluginProvider);

    final allVolumes = ref.watch(volumesProvider).asData?.value ?? [];

    // Volume filters. Show volume if any of these match.
    final showEjectable = useState(true);
    final showInternal = useState(false);

    final volumes = allVolumes
        .where((element) =>
            (element.uuidString) != null &&
            ((showEjectable.value && element.isEjectable != false) ||
                (showInternal.value && element.isInternal != false)))
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
        final mediaUUID = volume.uuidString!;
        final job =
            ref.watch(copyJobsNotifierProvider)[Id.fromString(mediaUUID)];
        var name = volume.localizedName ??
            volume.name ??
            volume.localizedFormatDescription ??
            "No name";
        final prettySize = volume.totalCapacity != null
            ? prettyBytes(volume.totalCapacity?.toDouble() ?? 0)
            : '';
        return ListTile(
          title: Text("${name} ($prettySize)"),
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
                CopyProgressWidget(ruleId: Id.fromString(mediaUUID)),
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
              if (volume.isEjectable == true)
                IconButton(
                    icon: const Icon(Icons.eject),
                    onPressed: () {
                      print("Ejecting ${volume.uuidString} initiated");
                      ref.read(volumesPluginProvider).eject(volume).then(
                          (value) => print("Ejected ${volume.uuidString}"),
                          onError: (e, s) => print(
                              "(NOT WORKING PROPERLY) ejected ${e} ${volume.uuidString}"));
                    }),
              IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: projectDestinationFolder.value != null
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
              child: !volumePlugin.supported
                  ? const Text(
                      'Volume plugin is NOT supported on this platform.')
                  : SegmentedButton(
                      multiSelectionEnabled: true,
                      emptySelectionAllowed: true,
                      showSelectedIcon: false,
                      selected: <VolumeFilter>{
                        if (showEjectable.value) VolumeFilter.ejectable,
                        if (showInternal.value) VolumeFilter.internal,
                      },
                      segments: const <ButtonSegment<VolumeFilter>>[
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
                        showEjectable.value =
                            selected.contains(VolumeFilter.ejectable);
                        showInternal.value =
                            selected.contains(VolumeFilter.internal);
                      },
                    )),
          Expanded(child: volumeList)
        ],
      ),
      drawer: TopLevelNavigationDrawer(selectedProjectId: projectId),
    );
  }
}
