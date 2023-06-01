import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_plugin.freezed.dart';
part 'volume_plugin.g.dart';

class VolumePlugin {
  static const MethodChannel _methodChannel = MethodChannel('volume_plugin');
  static const EventChannel _eventChannel = EventChannel('volumesEventChannel');

  Stream<bool>? _events;

  Future<List<Volume>> getVolumes() async {
    final List volumes = await _methodChannel.invokeMethod('getVolumes');
    return volumes
        .map((v) => Volume.fromJson(Map<String, dynamic>.from(v)))
        .toList();
  }

  Stream<bool> get _currentEvents {
    _events ??= _eventChannel.receiveBroadcastStream().map((event) => true);

    return _events!;
  }

  Stream<List<Volume>> get uptodateVolumes async* {
    final timer = _IrregularTimingStream(
      excitedInterval: const Duration(seconds: 1),
      excitedEvents: 10,
      idleInterval: const Duration(seconds: 60),
    );

    final merged = StreamGroup.merge(
            <Stream<bool>>[_currentEvents, timer.stream.map((event) => false)])
        // already listen so we don't miss anything.
        .listenAndBuffer();

    yield await getVolumes();

    await for (final realEvent in merged) {
      if (realEvent) {
        timer.excited();
      }
      yield await getVolumes();
    }
  }

  // does not work
  Future<void> eject(Volume volume) async {
    await _methodChannel.invokeMethod('eject', {'url': volume.url});
  }
}

// Fires an event every excitedInterval for excitedEvents times after being excited().
// Then goes back to firing at idleInterval.
class _IrregularTimingStream {
  final Duration excitedInterval;
  final int excitedEvents;
  final Duration idleInterval;

  var _completeOnExcite = Completer<void>();
  var _excitedEventsLeft = 0;

  _IrregularTimingStream({
    required this.excitedInterval,
    required this.excitedEvents,
    required this.idleInterval,
  });

  void excited() {
    _excitedEventsLeft = excitedEvents;
    _completeOnExcite.complete();
    _completeOnExcite = Completer();
  }

  Stream<void> get stream async* {
    while (true) {
      if (_excitedEventsLeft > 0) {
        _excitedEventsLeft--;
        await Future.any([
          Future.delayed(excitedInterval),
          _completeOnExcite.future,
        ]);
        yield ();
      } else {
        await Future.any([
          Future.delayed(idleInterval),
          _completeOnExcite.future,
        ]);
        yield ();
      }
    }
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
