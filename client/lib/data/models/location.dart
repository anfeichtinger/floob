import 'package:floob/data/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends BaseModel {
  @JsonKey(
    fromJson: _doubleFromJson,
  )
  final double? latitude, longitude;
  final String? name, website;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'opening_times')
  final Map<String, String>? openingTimes;
  @JsonKey(name: 'overpass_data')
  final Map<String, dynamic>? overpassData;
  final Map<String, double>? reviews;
  final Map<String, Map<String, bool?>?>? accessibility;

  String get address {
    if (overpassData?['address'] == null) {
      return 'Keine Adresse gefunden...';
    }

    String result = '';

    // Street
    if (overpassData?['address']['street'] != null) {
      result += overpassData!['address']['street'] as String;
    }

    // Post Code
    if (overpassData?['address']['post_code'] != null) {
      result += (result.isEmpty ? '' : ', ') +
          (overpassData!['address']['post_code'] as String);
    }

    // City
    if (overpassData?['address']['city'] != null) {
      result += (result.isEmpty ? '' : ' ') +
          (overpassData!['address']['city'] as String);
    }

    return result;
  }

  Location({
    super.id,
    this.latitude,
    this.longitude,
    this.name,
    this.website,
    this.imageUrl,
    this.openingTimes,
    this.overpassData,
    this.reviews,
    this.accessibility,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$LocationFromJson] function to the `fromJson` factory.
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Connect the generated [_$LocationToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  static double _doubleFromJson(dynamic value) =>
      double.parse(value?.toString() ?? '0');

  @override
  String toString() {
    return '''Location {
      id: $id,
      latitude: $latitude,
      longitude: $longitude,
      name: $name,
      website: $website,
      imageUrl: $imageUrl,
      openingTimes: $openingTimes,
      overpassData: $overpassData,
      reviews: $reviews,
      accessibility: $accessibility,
    }''';
  }
}
