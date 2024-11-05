import 'package:floob/data/models/accessibility_data.dart';
import 'package:floob/data/models/base_model.dart';
import 'package:floob/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accessibility_data_report.g.dart';

@JsonSerializable()
class AccessibilityDataReport extends BaseModel {
  @JsonKey(name: 'accessibility_data_id')
  final int? accessibilityDataId;
  @JsonKey(name: 'accessibility_data')
  final AccessibilityData? accessibilityData;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'user')
  final User? user;

  AccessibilityDataReport({
    required super.id,
    this.accessibilityDataId,
    this.accessibilityData,
    this.userId,
    this.user,
    super.createdAt,
    super.updatedAt,
  });

  /// Connect the generated [_$AccessibilityDataReportFromJson] function to the `fromJson` factory.
  factory AccessibilityDataReport.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityDataReportFromJson(json);

  /// Connect the generated [_$AccessibilityDataReportToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$AccessibilityDataReportToJson(this);
}
