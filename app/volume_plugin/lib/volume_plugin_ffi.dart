import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/services.dart';

import 'volume_plugin.dart';

class VolumePlugin {
  final bool supported = Platform.isMacOS;

  static const MethodChannel _methodChannel = MethodChannel('volume_plugin');
  static const EventChannel _eventChannel = EventChannel('volumesEventChannel');

  Stream<bool>? _events;

  Future<List<Volume>> getVolumes() async {
    if (!supported) {
      return [];
    }

    final volumes = await _methodChannel.invokeMethod('getVolumes');
    final List<Volume> list =
        volumes.map((v) => Volume.fromJson(Map<String, Object?>.from(v)));
    return list.toList();
  }

  Stream<bool> get _currentEvents {
    _events ??= _eventChannel.receiveBroadcastStream().map((event) => true);

    return _events!;
  }

  Stream<List<Volume>> get uptodateVolumes async* {
    if (!supported) {
      return;
    }

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
    if (!supported) {
      throw UnsupportedError('This platform is not supported.');
    }

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
