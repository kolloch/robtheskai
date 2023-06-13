import 'package:collection/collection.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/id.dart';
import 'package:robokru/src/data/query/locations.dart';
import 'package:robokru/src/data/tables.dart';

import '../data/query/scenes.dart';
import '../data/query/shots.dart';
import '../skeleton/consumer_async_value_widget.dart';
import '../skeleton/top_level_navigation_drawer.dart';

final projectScenesProvider =
    StreamProvider.autoDispose.family<List<SceneWithLocation>, Id>(
  (ref, projectId) {
    final scenesDao = ref.watch(scenesDaoProvider);
    return scenesDao.getScenesForProject(projectId);
  },
);

// enum for for the edit mode
enum EditMode {
  view,
  // reorder,
  edit,
  delete,
}

/// Displays a list of scenes for the project with the given id.
class ProjectSceneList extends HookConsumerWidget {
  static const routeName = '/projects/:projectId/scenes';

  final Id projectId;

  const ProjectSceneList({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editMode = useState(EditMode.view);

    final scenes = ref.watch(projectScenesProvider(projectId));
    final shotsBySceneId = ref.watch(shotsBySceneIdProvider(projectId));

    TextStyle? titleLarge2 = Theme.of(context).textTheme.titleLarge;
    final sceneNumberWidth =
        _maximumSceneNumberWidth(context, titleLarge2, scenes.asData?.value);

    final project = ref.watch(selectedProjectProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Scenes of ${project?.name}'),
      ),
      drawer: TopLevelNavigationDrawer(selectedProjectId: projectId),

      // multiple actions: edit and add
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final ScenesCompanion? scene = await showDialog<ScenesCompanion>(
            context: context,
            builder: (BuildContext context) {
              return AddOrEditSceneForm(
                projectId: projectId,
              );
            },
          );

          if (scene == null) return;

          final scenesDao = ref.read(scenesDaoProvider);
          await scenesDao.upsertScene(scene);
        },
      ),
      body: ConsumerAsyncValueWidget(
        asyncValue: scenes,
        buildWithData: (context, ref, List<SceneWithLocation> scenes) {
          final Widget body;
          if (scenes.isNotEmpty) {
            body = Column(
              children: [
                // Segmented button to switch between view and edit modes
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SegmentedButton(
                    showSelectedIcon: false,
                    segments: const <ButtonSegment<EditMode>>[
                      ButtonSegment(
                          value: EditMode.view,
                          label: Text('View'),
                          icon: Icon(Icons.visibility)),
                      // ButtonSegment(
                      //     value: EditMode.reorder,
                      //     label: Text('Reorder'),
                      //     icon: Icon(Icons.reorder)),
                      ButtonSegment(
                          value: EditMode.edit,
                          label: Text('Edit'),
                          icon: Icon(Icons.edit)),
                      ButtonSegment(
                          value: EditMode.delete,
                          label: Text('Delete'),
                          icon: Icon(Icons.delete)),
                    ],
                    selected: <EditMode>{editMode.value},
                    onSelectionChanged: (value) {
                      editMode.value = value.first;
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    // Providing a restorationId allows the ListView to restore the
                    // scroll position when a user leaves and returns to the app after it
                    // has been killed while running in the background.
                    restorationId: 'sceneList',
                    itemCount: scenes.length,

                    itemBuilder: (BuildContext context, int index) {
                      final sceneWithLocation = scenes[index];
                      final scene = sceneWithLocation.scene;
                      final shots =
                          shotsBySceneId.asData?.value[scene.id] ?? [];

                      return SceneWithShotList(
                          scene: scene,
                          sceneNumberWidth: sceneNumberWidth,
                          titleLarge2: titleLarge2,
                          sceneWithLocation: sceneWithLocation,
                          editMode: editMode,
                          shots: shots);
                    },
                  ),
                ),
              ],
            );
          } else {
            body = const Center(
              child: Text('No scenes found'),
            );
          }

          return body;
        },
      ),
    );
  }
}

class SceneWithShotList extends HookConsumerWidget {
  const SceneWithShotList({
    super.key,
    required this.scene,
    required this.sceneNumberWidth,
    required this.titleLarge2,
    required this.sceneWithLocation,
    required this.editMode,
    required this.shots,
  });

  final Scene scene;
  final double sceneNumberWidth;
  final TextStyle? titleLarge2;
  final SceneWithLocation sceneWithLocation;
  final ValueNotifier<EditMode> editMode;
  final List<Shot> shots;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = useState(false);

    return ExpansionTile(
      key: Key('scene-${scene.id}'),
      controller: ExpansionTileController(),
      leading: ConstrainedBox(
          constraints: BoxConstraints.expand(width: sceneNumberWidth),
          child: Text(
            scene.number,
            style: titleLarge2,
          )),
      title: Text(sceneWithLocation.location.name),
      subtitle: Text(scene.name),
      onExpansionChanged: (value) => expanded.value = value,
      trailing: switch (editMode.value) {
        EditMode.view => null,
        EditMode.edit => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _createSceneEditButton(context, scene, ref),
              _createShotAddButton(context, scene, ref),
              // expand button
              ToggleExpandableWidget(expanded: expanded),
            ],
          ),
        EditMode.delete => _createSceneDeleteButton(context, scene, ref),
      },
      initiallyExpanded: editMode.value != EditMode.view,
      children: [
        ListView.builder(
          key: Key('shotList-${scene.id}'),
          restorationId: "shotList-${scene.id}",
          shrinkWrap: true,
          itemCount: shots.length,
          // indent shots
          padding: EdgeInsets.only(left: 24 + sceneNumberWidth),
          itemBuilder: (BuildContext context, int index) {
            final shot = shots[index];

            return ListTile(
              key: Key('shot-${shot.id}'),
              title: Text("${shot.number} ${shot.name}"),
              trailing: switch (editMode.value) {
                EditMode.view => null,
                EditMode.edit => _createShotEditButton(context, shot, ref),
                EditMode.delete => _createShotDeleteButton(context, shot, ref),
              },
            );
          },
        ),
      ],
    );
  }
}

class ToggleExpandableWidget extends StatelessWidget {
  const ToggleExpandableWidget({
    super.key,
    required this.expanded,
  });

  final ValueNotifier<bool> expanded;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: expanded.value
          ? const Icon(Icons.expand_less)
          : const Icon(Icons.expand_more),
      onPressed: () {
        var controller = ExpansionTileController.of(context);
        if (expanded.value) {
          controller.collapse();
        } else {
          controller.expand();
        }
      },
    );
  }
}

IconButton _createSceneDeleteButton(
    BuildContext context, Scene scene, WidgetRef ref) {
  return IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      // ask for confirmation
      final bool? delete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Scene?'),
            content: Text(
                'Are you sure you want to delete ${scene.number} ${scene.name}?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (delete != true) return;

      final skaidb = ref.read(scenesDaoProvider);
      await skaidb.deleteScene(scene.id);
    },
  );
}

IconButton _createShotDeleteButton(
    BuildContext context, Shot shot, WidgetRef ref) {
  return IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      // ask for confirmation
      final bool? delete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Shot?'),
            content: Text('Are you sure you want to delete ${shot.name}?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (delete != true) return;

      final skaidb = ref.read(shotsDaoProvider);
      await skaidb.deleteShot(shot.id);
    },
  );
}

double _maximumSceneNumberWidth(
    BuildContext context, TextStyle? style, List<SceneWithLocation>? value) {
  if (value == null || value.isEmpty) return 0;
  final sceneNumbers = value.map((e) => e.scene.number);
  final sceneNumberWidths = sceneNumbers.map(
      (e) => calculateTextSize(text: e, style: style, context: context).width);
  return sceneNumberWidths
      .reduce((value, element) => value > element ? value : element);
}

Size calculateTextSize({
  required String text,
  required TextStyle? style,
  required BuildContext context,
}) {
  final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

  final TextDirection textDirection = Directionality.of(context);

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaleFactor: textScaleFactor,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size;
}

Widget _createSceneEditButton(
    BuildContext context, Scene scene, WidgetRef ref) {
  return IconButton(
    icon: const Icon(Icons.edit),
    onPressed: () async {
      final ScenesCompanion? sceneCompanion = await showDialog<ScenesCompanion>(
        context: context,
        builder: (BuildContext context) {
          return AddOrEditSceneForm(
            projectId: scene.projectId,
            scene: scene,
          );
        },
      );

      if (sceneCompanion == null) return;

      final scenesDao = ref.read(scenesDaoProvider);
      await scenesDao.upsertScene(sceneCompanion);
    },
  );
}

Widget _createShotEditButton(BuildContext context, Shot shot, WidgetRef ref) {
  return IconButton(
    icon: const Icon(Icons.edit),
    onPressed: () async {
      final ShotsCompanion? shotCompanion = await showDialog<ShotsCompanion>(
        context: context,
        builder: (BuildContext context) {
          return AddOrEditShotForm(
            sceneId: shot.sceneId,
            shot: shot,
          );
        },
      );

      if (shotCompanion == null) return;

      final shotsDao = ref.read(shotsDaoProvider);
      await shotsDao.upsertShot(shotCompanion);
    },
  );
}

IconButton _createShotAddButton(
    BuildContext context, Scene scene, WidgetRef ref) {
  return IconButton(
    icon: const Icon(Icons.add),
    onPressed: () async {
      final ShotsCompanion? shotCompanion = await showDialog<ShotsCompanion>(
        context: context,
        builder: (BuildContext context) {
          return AddOrEditShotForm(
            sceneId: scene.id,
          );
        },
      );

      if (shotCompanion == null) return;

      final shotsDao = ref.read(shotsDaoProvider);
      await shotsDao.upsertShot(shotCompanion);
    },
  );
}

class AddOrEditShotForm extends HookConsumerWidget {
  final Id sceneId;
  final Shot? shot;

  const AddOrEditShotForm({
    Key? key,
    required this.sceneId,
    this.shot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shotId = useState(shot?.id ?? Id.random());
    final shotNumber = useState(shot?.number ?? 1);
    final shotName = useState(shot?.name ?? '');

    final informationIncomplete = shotName.value.isEmpty;

    void submit() {
      if (informationIncomplete) return;

      Navigator.of(context).pop(ShotsCompanion(
        id: Value(shotId.value),
        sceneId: Value(sceneId),
        number: Value(shotNumber.value),
        name: Value(shotName.value),
      ));
    }

    const paddingBetweenFormFields = SizedBox(height: 24);

    return AlertDialog(
      title: Text(shot != null ? 'Edit Shot?' : 'Add Shot?'),
      // add padding between form fields
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actions: <Widget>[
        // field for scene number
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Shot Number',
          ),
          autofocus: true,
          onFieldSubmitted: (_) => submit(),
          initialValue: shot?.number.toString(),
          onChanged: (value) {
            shotNumber.value = int.tryParse(value) ?? 0;
          },
        ),
        paddingBetweenFormFields,
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Shot Name',
          ),
          onFieldSubmitted: (_) => submit(),
          initialValue: shot?.name,
          onChanged: (value) {
            shotName.value = value;
          },
        ),
        paddingBetweenFormFields,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: informationIncomplete ? null : submit,
              child: Text(shot != null ? 'Edit' : 'Add'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        )
      ],
    );
  }
}

/// An add scene form using hooks and riverpod.
class AddOrEditSceneForm extends HookConsumerWidget {
  final Id projectId;
  final Scene? scene;

  const AddOrEditSceneForm({
    Key? key,
    required this.projectId,
    this.scene,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sceneId = useState(scene?.id ?? Id.random());
    final sceneNumber = useState(scene?.number ?? "1");
    final sceneName = useState(scene?.name ?? '');
    final locationId = useState<Id?>(scene?.locationId);

    final informationIncomplete = locationId.value == null ||
        sceneNumber.value.isEmpty ||
        sceneName.value.isEmpty;

    void submit() {
      if (informationIncomplete) return;

      Navigator.of(context).pop(ScenesCompanion(
        id: Value(sceneId.value),
        projectId: Value(projectId),
        locationId: Value(locationId.value!),
        number: Value(sceneNumber.value),
        name: Value(sceneName.value),
      ));
    }

    final locations =
        ref.watch(projectLocationsProvider(projectId)).asData?.value ?? [];

    const paddingBetweenFormFields = SizedBox(height: 24);

    return AlertDialog(
      title: Text(scene != null ? 'Edit Scene?' : 'Add Scene?'),
      // add padding between form fields
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actions: <Widget>[
        // field for scene number
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Scene Number',
          ),
          autofocus: true,
          onFieldSubmitted: (_) => submit(),
          initialValue: scene?.number,
          onChanged: (value) {
            sceneNumber.value = value;
          },
        ),
        paddingBetweenFormFields,
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Scene Name',
          ),
          onFieldSubmitted: (_) => submit(),
          initialValue: scene?.name,
          onChanged: (value) {
            sceneName.value = value;
          },
        ),
        paddingBetweenFormFields,
        // drop down to choose location
        DropdownButtonFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Location',
          ),
          items: locations
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
              .toList(),
          value: locations.firstWhereOrNull((e) => e.id == locationId.value),
          onChanged: (l) {
            locationId.value = l?.id;
          },
        ),
        paddingBetweenFormFields,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: informationIncomplete ? null : submit,
              child: Text(scene != null ? 'Edit' : 'Add'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        )
      ],
    );
  }
}
