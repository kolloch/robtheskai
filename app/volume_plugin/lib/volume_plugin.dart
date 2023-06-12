import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'volume_plugin_unsupported.dart'
    if (dart.library.ffi) 'volume_plugin_ffi.dart';

part 'volume_plugin.freezed.dart';
part 'volume_plugin.g.dart';

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

  factory Volume.fromJson(Map<String, Object?> json) => _$VolumeFromJson(json);
}

extension VolumeExtension on Volume {
  String? get volumeDirectory =>
      url == null ? null : Uri.parse(url!).toFilePath();

  String get prettyJson {
    const encoder = JsonEncoder.withIndent("     ");
    return encoder.convert(toJson());
  }
}
