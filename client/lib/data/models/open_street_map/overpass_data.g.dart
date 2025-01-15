// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overpass_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverpassData _$OverpassDataFromJson(Map<String, dynamic> json) => OverpassData(
      id: (json['id'] as num?)?.toInt(),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      tags: json['tags'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OverpassDataToJson(OverpassData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lon': instance.lon,
      'tags': instance.tags,
    };
