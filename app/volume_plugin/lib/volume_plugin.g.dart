// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Volume _$$_VolumeFromJson(Map<String, dynamic> json) => _$_Volume(
      path: json['path'] as String?,
      kind: json['kind'] as String?,
      name: json['name'] as String?,
      uuid: json['uuid'] as String?,
      icon: json['icon'] as String?,
      mediaName: json['mediaName'] as String?,
      mediaIcon: json['mediaIcon'] as String?,
      mediaKind: json['mediaKind'] as String?,
      mediaBlockSize: json['mediaBlockSize'] as int?,
      mediaSize: json['mediaSize'] as int?,
      mediaUUID: json['mediaUUID'] as String?,
      devicePath: json['devicePath'] as String?,
      deviceProtocol: json['deviceProtocol'] as String?,
      deviceInternal: json['deviceInternal'] as bool?,
      deviceModel: json['deviceModel'] as String?,
      deviceRevision: json['deviceRevision'] as String?,
      deviceVendor: json['deviceVendor'] as String?,
      mediaEjectable: json['mediaEjectable'] as bool?,
      mediaRemovable: json['mediaRemovable'] as bool?,
      mediaWhole: json['mediaWhole'] as bool?,
      mediaWritable: json['mediaWritable'] as bool?,
    );

Map<String, dynamic> _$$_VolumeToJson(_$_Volume instance) => <String, dynamic>{
      'path': instance.path,
      'kind': instance.kind,
      'name': instance.name,
      'uuid': instance.uuid,
      'icon': instance.icon,
      'mediaName': instance.mediaName,
      'mediaIcon': instance.mediaIcon,
      'mediaKind': instance.mediaKind,
      'mediaBlockSize': instance.mediaBlockSize,
      'mediaSize': instance.mediaSize,
      'mediaUUID': instance.mediaUUID,
      'devicePath': instance.devicePath,
      'deviceProtocol': instance.deviceProtocol,
      'deviceInternal': instance.deviceInternal,
      'deviceModel': instance.deviceModel,
      'deviceRevision': instance.deviceRevision,
      'deviceVendor': instance.deviceVendor,
      'mediaEjectable': instance.mediaEjectable,
      'mediaRemovable': instance.mediaRemovable,
      'mediaWhole': instance.mediaWhole,
      'mediaWritable': instance.mediaWritable,
    };
