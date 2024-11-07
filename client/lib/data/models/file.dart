import 'package:floob/data/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class File extends BaseModel {
  @JsonKey(name: 'fileable_type')
  final String? fileableType;
  @JsonKey(name: 'fileable_id')
  final int? fileableId;
  final BaseModel? fileable;
  final String? type, name, path, extension;

  File({
    required super.id,
    this.fileableType,
    this.fileableId,
    this.fileable,
    this.type,
    this.name,
    this.path,
    this.extension,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$FileFromJson] function to the `fromJson` factory.
  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  /// Connect the generated [_$FileToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$FileToJson(this);
}
