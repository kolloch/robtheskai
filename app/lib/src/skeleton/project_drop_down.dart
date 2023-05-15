import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/query/projects.dart';
import 'package:robokru/src/projects/selected_project.dart';
import 'package:robokru/src/settings/settings_notifier.dart';
import 'package:collection/collection.dart';

import '../data/id.dart';
import '../data/tables.dart';
import '../projects/project_list.dart';
import '../projects/project_scene_list.dart';
import 'consumer_async_value_widget.dart';

sealed class _DropDownItem {
  const _DropDownItem();
}

class _ProjectItem extends _DropDownItem {
  final Project project;
  const _ProjectItem(this.project);
}

class _ManageProjectsItem extends _DropDownItem {
  const _ManageProjectsItem();
}

class _CreateSampleProjectsItem extends _DropDownItem {
  const _CreateSampleProjectsItem();
}

final projectsByIdStreamProvider = StreamProvider.autoDispose.family(
  (ref, List<Id> projectIds) {
    final projectsDao = ref.watch(projectsDaoProvider);
    return projectsDao.getProjectsById(projectIds);
  },
);

/// Drop down for selecting a project.
///
/// This is a [ConsumerWidget] that listens to the [projectsDaoProvider] and
/// the [SettingsController] for the most recently opened projects.
///
/// It takes the currently [selectedProjectId] as an optional parameter.
class ProjectDropDown extends ConsumerWidget {
  const ProjectDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProjectId = ref.watch(selectedProjectNotifier).valueOrNull;
    final lastProjects =
        ref.watch(settingsNotifier).valueOrNull?.lastProjectIds ?? [];
    final projects = ref.watch(projectsByIdStreamProvider(lastProjects));

    print('ProjectDropDown.build: selectedProjectId: $selectedProjectId');

    return ConsumerAsyncValueWidget(
      asyncValue: projects,
      buildWithData: (context, ref, Map<Id, Project> projects) {
        final items = <_DropDownItem>[
          for (final id in lastProjects)
            if (projects[id] case Project project) _ProjectItem(project),
          const _CreateSampleProjectsItem(),
          const _ManageProjectsItem(),
        ];

        return DropdownButton<_DropDownItem>(
            value: selectedProjectId == null
                ? null
                : items.firstWhereOrNull((item) {
                    if (item is _ProjectItem) {
                      return item.project.id == selectedProjectId;
                    } else {
                      return false;
                    }
                  }),
            onChanged: (_DropDownItem? newValue) {
              switch (newValue) {
                case _ProjectItem item:
                  ref
                      .read(selectedProjectNotifier.notifier)
                      .select(item.project.id);
                  context
                      .pushNamed(ProjectSceneList.routeName, pathParameters: {
                    'projectId': item.project.id.toString(),
                  });
                  break;
                case _CreateSampleProjectsItem _:
                  ref.read(projectsDaoProvider).createSampleProjects();
                  break;
                case _ManageProjectsItem _:
                  context.goNamed(ProjectListView.routeName);
                  break;
                default:
                  break;
              }
            },
            hint: const Text('No project selected.'),
            items: items
                .map<DropdownMenuItem<_DropDownItem>>(
                    (item) => DropdownMenuItem<_DropDownItem>(
                        value: item,
                        child: switch (item) {
                          _ProjectItem item => Text(item.project.name),
                          _CreateSampleProjectsItem _ =>
                            const Text('Create sample projects'),
                          _ManageProjectsItem _ =>
                            const Text('Manage projects'),
                        }))
                .toList());
      },
    );
  }
}
