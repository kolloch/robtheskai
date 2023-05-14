import 'package:flutter/material.dart';
import 'package:robokru/src/data/id.dart';

class ProjectSceneList extends StatelessWidget {
  final Id projectId;

  const ProjectSceneList({super.key, required this.projectId});

  static const routeName = '/project_scene_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
