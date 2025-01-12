import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'overpass_data.g.dart';

@JsonSerializable()
class OverpassData {
  final int? id;
  final double? lat, lon;
  final Map<String, dynamic>? tags;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get name => tags?['name'] as String?;
  LatLng? get point => LatLng(lat ?? 0, lon ?? 0);

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
  // ignore: override_on_non_overriding_member
  Map<String, dynamic> toJson() => _$OverpassDataToJson(this);
}
