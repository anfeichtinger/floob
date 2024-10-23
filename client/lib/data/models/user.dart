import 'package:flutter_production_boilerplate_riverpod/data/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseModel {
  final String name, email;

  @JsonKey(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;

  User({
    required super.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$UserFromJson] function to the `fromJson` factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
