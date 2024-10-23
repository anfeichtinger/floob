// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: (json['id'] as num).toInt(),
      addressableType: json['addressable_type'] as String?,
      addressableId: (json['addressable_id'] as num?)?.toInt(),
      addressable: json['addressable'] == null
          ? null
          : BaseModel.fromJson(json['addressable'] as Map<String, dynamic>),
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      postCode: json['post_code'] as String?,
      additionalInfo: json['additional_info'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'addressable_type': instance.addressableType,
      'addressable_id': instance.addressableId,
      'addressable': instance.addressable,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'post_code': instance.postCode,
      'additional_info': instance.additionalInfo,
    };
