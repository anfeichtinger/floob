// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessibility_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessibilityData _$AccessibilityDataFromJson(Map<String, dynamic> json) =>
    AccessibilityData(
      id: (json['id'] as num?)?.toInt(),
      locationId: (json['location_id'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      userId: (json['user_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      category: json['category'] as String?,
      entry: json['entry'] as String?,
      value: json['value'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AccessibilityDataToJson(AccessibilityData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'location_id': instance.locationId,
      'location': instance.location,
      'user_id': instance.userId,
      'user': instance.user,
      'category': instance.category,
      'entry': instance.entry,
      'value': instance.value,
    };
