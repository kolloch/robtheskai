import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:volume_plugin/volume_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _volumePlugin = VolumePlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: StreamBuilder(
            stream: _volumePlugin.uptodateVolumes,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final volumes = snapshot.data!
                  .where((element) =>
                      element.mediaEjectable == true ||
                      element.mediaRemovable == true)
                  .toList();

              return ListView.builder(
                itemCount: volumes.length,
                itemBuilder: (context, index) {
                  final volume = volumes[index];
                  return ListTile(
                    title: Text(volume.mediaName ?? "No name"),
                    subtitle: Text(volume.toString()),
                  );
                },
              );
            }),
      ),
    );
  }
}