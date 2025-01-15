// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      id: (json['id'] as num?)?.toInt(),
      fileableType: json['fileable_type'] as String?,
      fileableId: (json['fileable_id'] as num?)?.toInt(),
      fileable: json['fileable'] == null
          ? null
          : BaseModel.fromJson(json['fileable'] as Map<String, dynamic>),
      type: json['type'] as String?,
      name: json['name'] as String?,
      path: json['path'] as String?,
      extension: json['extension'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'fileable_type': instance.fileableType,
      'fileable_id': instance.fileableId,
      'fileable': instance.fileable,
      'type': instance.type,
      'name': instance.name,
      'path': instance.path,
      'extension': instance.extension,
    };
