import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overpass_response.g.dart';

@JsonSerializable()
class OverpassResponse {
  final List<OverpassData> elements;

  List<OverpassData> get nodes => elements
      .where((OverpassData element) =>
          element.name != null && element.name!.isNotEmpty)
      .toList();

  OverpassResponse({
    required this.elements,
  });

  factory OverpassResponse.fromJson(Map<String, dynamic> json) =>
      _$OverpassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OverpassResponseToJson(this);
}
