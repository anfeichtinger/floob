import 'package:floob/data/models/base_model.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review extends BaseModel {
  @JsonKey(name: 'location_id')
  final int? locationId;
  final Location? location;
  @JsonKey(name: 'user_id')
  final int? userId;
  final User? user;
  final int? score;
  final String? text;

  Review({
    required super.id,
    this.locationId,
    this.location,
    this.userId,
    this.user,
    this.score,
    this.text,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$ReviewFromJson] function to the `fromJson` factory.
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// Connect the generated [_$ReviewToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
