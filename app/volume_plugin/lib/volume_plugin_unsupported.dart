import 'package:volume_plugin/volume_plugin.dart';

class VolumePlugin {
  final bool supported = false;

  Future<List<Volume>> getVolumes() async {
    return [];
  }

  Stream<List<Volume>> get uptodateVolumes {
    return Stream.value([]);
  }

  // does not work
  Future<void> eject(Volume volume) async {
    throw UnsupportedError('This platform is not supported.');
  }
}
