import 'package:floob/data/models/base_model.dart';
import 'package:floob/data/models/review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends BaseModel {
  final String? latitude, longitude, name, website;
  @JsonKey(name: 'opening_times')
  final Map<String, String>? openingTimes;
  final List<Review>? reviews;

  Location({
    required super.id,
    this.latitude,
    this.longitude,
    this.name,
    this.website,
    this.openingTimes,
    this.reviews,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$LocationFromJson] function to the `fromJson` factory.
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Connect the generated [_$LocationToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
