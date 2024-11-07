import 'package:floob/data/models/base_model.dart';
import 'package:floob/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'badge.g.dart';

@JsonSerializable()
class Badge extends BaseModel {
  final String? identifier;
  final List<User>? users;

  Badge({
    required super.id,
    this.identifier,
    this.users,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$BadgeFromJson] function to the `fromJson` factory.
  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  /// Connect the generated [_$BadgeToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}
