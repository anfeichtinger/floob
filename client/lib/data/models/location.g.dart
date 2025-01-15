// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: (json['id'] as num?)?.toInt(),
      latitude: Location._doubleFromJson(json['latitude']),
      longitude: Location._doubleFromJson(json['longitude']),
      name: json['name'] as String?,
      website: json['website'] as String?,
      imageUrl: json['image_url'] as String?,
      openingTimes: (json['opening_times'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      overpassData: json['overpass_data'] as Map<String, dynamic>?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      reviewScore: (json['review_score'] as num?)?.toDouble() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'website': instance.website,
      'image_url': instance.imageUrl,
      'opening_times': instance.openingTimes,
      'overpass_data': instance.overpassData,
      'reviews': instance.reviews,
      'review_count': instance.reviewCount,
      'review_score': instance.reviewScore,
    };
