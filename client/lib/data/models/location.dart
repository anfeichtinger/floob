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

  Map<String, String> toMap() {
    return <String, String>{
      'id': id?.toString() ?? '',
      'latitude': latitude?.toString() ?? '',
      'longitude': longitude?.toString() ?? '',
      'name': name ?? '',
      'website': website ?? '',
      'image_url': imageUrl ?? '',
      'address': address,
      if (openingTimes != null)
        for (MapEntry<String, String> entry in openingTimes!.entries)
          'opening_times_${entry.key}': entry.value,
      if (overpassData != null)
        for (MapEntry<String, dynamic> entry in overpassData!.entries)
          'overpass_data_${entry.key}': entry.value.toString(),
      if (reviews != null)
        for (MapEntry<String, double> entry in reviews!.entries)
          'review_${entry.key}': entry.value.toString(),
      if (accessibility != null)
        for (MapEntry<String, Map<String, bool?>?> outer
            in accessibility!.entries)
          for (MapEntry<String, bool?> inner in outer.value!.entries)
            'accessibility_${outer.key}_${inner.key}': inner.value.toString(),
    };
  }
}
