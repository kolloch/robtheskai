import 'dart:convert';

import 'package:async/async.dart';
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
    final merged = StreamGroup.merge(
            <Stream<void>>[events, Stream.periodic(const Duration(seconds: 5))])
        // already listen so we don't miss anything.
        .listenAndBuffer();

    yield await getVolumes();

    await for (final _ in merged) {
      yield await getVolumes();
    }
  }

  // does not work
  Future<void> eject(Volume volume) async {
    await _methodChannel.invokeMethod('eject', {'url': volume.url});
  }
}

@freezed
class Volume with _$Volume {
  factory Volume({
    String? name,
    bool? isBrowsable,
    bool? isEjectable,
    bool? isRemovable,
    bool? isInternal,
    bool? isAutomounted,
    bool? isLocal,
    bool? isReadOnly,
    bool? isRootFileSystem,
    bool? supportsPersistentIDs,
    bool? supportsCasePreservedNames,
    bool? supportsRenaming,
    String? creationDate,
    String? modificationDate,
    String? identifier,
    String? localizedFormatDescription,
    String? localizedName,
    String? url,
    String? uuidString,
    String? type,
    String? subtype,
    int? availableCapacityForImportantUsage,
    int? totalCapacity,
  }) = _Volume;

  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
}

extension VolumeExtension on Volume {
  String? get volumeDirectory =>
      url == null ? null : Uri.parse(url!).toFilePath();

  String get prettyJson {
    const encoder = JsonEncoder.withIndent("     ");
    return encoder.convert(toJson());
  }
}
