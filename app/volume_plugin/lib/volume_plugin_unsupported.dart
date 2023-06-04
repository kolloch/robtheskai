import 'package:volume_plugin/volume_plugin.dart';

class VolumePlugin {
  Future<List<Volume>> getVolumes() async {
    throw UnsupportedError('This platform is not supported.');
  }

  Stream<List<Volume>> get uptodateVolumes async* {
    throw UnsupportedError('This platform is not supported.');
  }

  // does not work
  Future<void> eject(Volume volume) async {
    throw UnsupportedError('This platform is not supported.');
  }
}
