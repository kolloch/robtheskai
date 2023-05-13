import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/data/query/projects.dart';
import 'package:robokru/src/settings/settings_view.dart';
import 'package:collection/collection.dart';

import '../data/tables.dart';
import '../data/uuid.dart';
import '../projects/project_list.dart';
import 'consumer_async_value_widget.dart';

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
    final projects = ref.watch(projectsProvider);
    final selectedProjectId = ref.watch(selectedProjectIdProvider);

    print('ProjectDropDown.build: selectedProjectId: $selectedProjectId');

    return ConsumerAsyncValueWidget(
        asyncValue: projects,
        buildWithData: (context, ref, List<Project> items) {
          final Widget body;
          if (items.isNotEmpty) {
            body = DropdownButton<Project>(
                value: selectedProjectId == null
                    ? null
                    : items.firstWhereOrNull((element) {
                        var bool = element.id.toShortString() ==
                            selectedProjectId.toShortString();
                        // print compared values and result
                        print(
                            'ProjectDropDown.build: element.id: ${element.id}, selectedProjectId: $selectedProjectId, bool: $bool');
                        return bool;
                      }),
                onChanged: (Project? newValue) {
                  if (newValue != null) {
                    final selectedProjectId =
                        ref.read(selectedProjectIdProvider.notifier);
                    selectedProjectId.state = newValue.id;
                    // context
                    //     .pushNamed(ProjectSceneList.routeName, pathParameters: {
                    //   'projectId': newValue.id.toString(),
                    // });
                  }
                },
                hint: const Text('No project selected.'),
                items: items
                    .map<DropdownMenuItem<Project>>(
                        (Project value) => DropdownMenuItem<Project>(
                              value: value,
                              child: Text(value.name),
                            ))
                    .toList());
          } else {
            body = const Text('No projects found.');
          }

          return body;
        });
  }
}
