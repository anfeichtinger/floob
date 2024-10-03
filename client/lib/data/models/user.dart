import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name, email;

  @JsonKey(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;

  User(
      {required this.id,
      required this.name,
      required this.email,
      this.emailVerifiedAt});

  /// Connect the generated [_$UserFromJson] function to the `fromJson` factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
