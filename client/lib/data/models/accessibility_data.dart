import 'package:floob/data/models/base_model.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accessibility_data.g.dart';

@JsonSerializable()
class AccessibilityData extends BaseModel {
  @JsonKey(name: 'location_id')
  final int? locationId;
  @JsonKey(name: 'location')
  final Location? location;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'user')
  final User? user;
  final String? category, entry;
  final bool? value;

  AccessibilityData({
    required super.id,
    this.locationId,
    this.location,
    this.userId,
    this.user,
    this.category,
    this.entry,
    this.value,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$AccessibilityDataFromJson] function to the `fromJson` factory.
  factory AccessibilityData.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityDataFromJson(json);

  /// Connect the generated [_$AccessibilityDataToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$AccessibilityDataToJson(this);
}
