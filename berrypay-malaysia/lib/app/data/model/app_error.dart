import 'package:json_annotation/json_annotation.dart';
part 'app_error.g.dart';

@JsonSerializable()
class AppError {
  String message;

  AppError({required this.message});

  factory AppError.fromJson(Map<String, dynamic> json) => _$AppErrorFromJson(json);

  Map<String, dynamic> toJson() => _$AppErrorToJson(this);
}
