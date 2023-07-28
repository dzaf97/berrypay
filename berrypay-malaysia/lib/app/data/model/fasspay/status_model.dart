import 'package:json_annotation/json_annotation.dart';
part 'status_model.g.dart';

@JsonSerializable()
class SSStatus {
  final int? code;
  final String? message;

  SSStatus(this.code, this.message);

  factory SSStatus.fromJson(Map<String, dynamic> json) => _$SSStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SSStatusToJson(this);
}