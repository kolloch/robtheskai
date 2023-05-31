// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Volume _$$_VolumeFromJson(Map<String, dynamic> json) => _$_Volume(
      name: json['name'] as String?,
      isBrowsable: json['isBrowsable'] as bool?,
      isEjectable: json['isEjectable'] as bool?,
      isRemovable: json['isRemovable'] as bool?,
      isInternal: json['isInternal'] as bool?,
      isAutomounted: json['isAutomounted'] as bool?,
      isLocal: json['isLocal'] as bool?,
      isReadOnly: json['isReadOnly'] as bool?,
      isRootFileSystem: json['isRootFileSystem'] as bool?,
      supportsPersistentIDs: json['supportsPersistentIDs'] as bool?,
      supportsCasePreservedNames: json['supportsCasePreservedNames'] as bool?,
      supportsRenaming: json['supportsRenaming'] as bool?,
      creationDate: json['creationDate'] as String?,
      modificationDate: json['modificationDate'] as String?,
      identifier: json['identifier'] as String?,
      localizedFormatDescription: json['localizedFormatDescription'] as String?,
      localizedName: json['localizedName'] as String?,
      url: json['url'] as String?,
      uuidString: json['uuidString'] as String?,
      type: json['type'] as String?,
      subtype: json['subtype'] as String?,
      availableCapacityForImportantUsage:
          json['availableCapacityForImportantUsage'] as int?,
      totalCapacity: json['totalCapacity'] as int?,
    );

Map<String, dynamic> _$$_VolumeToJson(_$_Volume instance) => <String, dynamic>{
      'name': instance.name,
      'isBrowsable': instance.isBrowsable,
      'isEjectable': instance.isEjectable,
      'isRemovable': instance.isRemovable,
      'isInternal': instance.isInternal,
      'isAutomounted': instance.isAutomounted,
      'isLocal': instance.isLocal,
      'isReadOnly': instance.isReadOnly,
      'isRootFileSystem': instance.isRootFileSystem,
      'supportsPersistentIDs': instance.supportsPersistentIDs,
      'supportsCasePreservedNames': instance.supportsCasePreservedNames,
      'supportsRenaming': instance.supportsRenaming,
      'creationDate': instance.creationDate,
      'modificationDate': instance.modificationDate,
      'identifier': instance.identifier,
      'localizedFormatDescription': instance.localizedFormatDescription,
      'localizedName': instance.localizedName,
      'url': instance.url,
      'uuidString': instance.uuidString,
      'type': instance.type,
      'subtype': instance.subtype,
      'availableCapacityForImportantUsage':
          instance.availableCapacityForImportantUsage,
      'totalCapacity': instance.totalCapacity,
    };
