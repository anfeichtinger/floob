import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  BaseModel({required this.id, this.createdAt, this.updatedAt});

  /// Connect the generated [_$BaseModelFromJson] function to the `fromJson` factory.
  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  /// Connect the generated [_$BaseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
