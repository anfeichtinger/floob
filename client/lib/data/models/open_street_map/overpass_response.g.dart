// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overpass_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverpassResponse _$OverpassResponseFromJson(Map<String, dynamic> json) =>
    OverpassResponse(
      elements: (json['elements'] as List<dynamic>)
          .map((dynamic e) => OverpassData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OverpassResponseToJson(OverpassResponse instance) =>
    <String, dynamic>{
      'elements': instance.elements,
    };
