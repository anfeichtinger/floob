import 'package:floob/data/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends BaseModel {
  @JsonKey(name: 'addressable_type')
  final String? addressableType;
  @JsonKey(name: 'addressable_id')
  final int? addressableId;
  final BaseModel? addressable;
  final String? country, state, city, street;
  @JsonKey(name: 'post_code')
  final String? postCode;
  @JsonKey(name: 'additional_info')
  final String? additionalInfo;

  Address({
    required super.id,
    this.addressableType,
    this.addressableId,
    this.addressable,
    this.country,
    this.state,
    this.city,
    this.street,
    this.postCode,
    this.additionalInfo,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$AddressFromJson] function to the `fromJson` factory.
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// Connect the generated [_$AddressToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
