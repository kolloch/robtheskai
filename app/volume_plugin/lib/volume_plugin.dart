import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_plugin.freezed.dart';
part 'volume_plugin.g.dart';

class VolumePlugin {
  static const MethodChannel _methodChannel = MethodChannel('volume_plugin');
  static const EventChannel _eventChannel = EventChannel('volumesEventChannel');

  Stream<void>? _events;

  Future<List<Volume>> getVolumes() async {
    final List volumes = await _methodChannel.invokeMethod('getVolumes');
    return volumes
        .map((v) => Volume.fromJson(Map<String, dynamic>.from(v)))
        .toList();
  }

  Stream<void> get events {
    _events ??= _eventChannel.receiveBroadcastStream();
    return _events!;
  }

  Stream<List<Volume>> get uptodateVolumes async* {
    yield await getVolumes();
    await for (final _ in events) {
      yield await getVolumes();
    }
  }
}

@freezed
class Volume with _$Volume {
  factory Volume({
    String? volumePath,
    String? volumeKind,
    String? volumeName,
    String? volumeUUID,
    String? mediaName,
    String? mediaIcon,
    String? mediaKind,
    int? mediaBlockSize,
    int? mediaSize,
    String? mediaUUID,
    String? devicePath,
    String? deviceProtocol,
    bool? deviceInternal,
    String? deviceModel,
    String? deviceRevision,
    String? deviceVendor,
    bool? mediaEjectable,
    bool? mediaRemovable,
    bool? mediaWhole,
    bool? mediaWritable,
  }) = _Volume;

  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
}

extension VolumeExtension on Volume {
  String? get volumeDirectory =>
      volumePath == null ? null : Uri.parse(volumePath!).toFilePath();

  bool get isRemovable => mediaEjectable == true || mediaRemovable == true;
}
