// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessibility_data_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessibilityDataReport _$AccessibilityDataReportFromJson(
        Map<String, dynamic> json) =>
    AccessibilityDataReport(
      id: (json['id'] as num).toInt(),
      accessibilityDataId: (json['accessibility_data_id'] as num?)?.toInt(),
      accessibilityData: json['accessibility_data'] == null
          ? null
          : AccessibilityData.fromJson(
              json['accessibility_data'] as Map<String, dynamic>),
      userId: (json['user_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AccessibilityDataReportToJson(
        AccessibilityDataReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'accessibility_data_id': instance.accessibilityDataId,
      'accessibility_data': instance.accessibilityData,
      'user_id': instance.userId,
      'user': instance.user,
    };
