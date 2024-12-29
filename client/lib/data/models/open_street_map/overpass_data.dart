import 'package:json_annotation/json_annotation.dart';

part 'overpass_data.g.dart';

@JsonSerializable()
class OverpassData {
  final int? id;
  final double? lat, lon;
  final Map<String, dynamic>? tags;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get name => tags?['name'] as String?;

  OverpassData({
    this.id,
    this.lat,
    this.lon,
    this.tags,
  });

  /// Connect the generated [_$OverpassDataFromJson] function to the `fromJson` factory.
  factory OverpassData.fromJson(Map<String, dynamic> json) =>
      _$OverpassDataFromJson(json);

  /// Connect the generated [_$OverpassDataToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$OverpassDataToJson(this);
}
