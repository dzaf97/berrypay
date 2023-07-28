import 'package:json_annotation/json_annotation.dart';
part 'locale_model.g.dart';

@JsonSerializable()
class LocaleModel {
  String language;
  String countryCode;

  LocaleModel({
    required this.language,
    required this.countryCode,
  });

  factory LocaleModel.fromJson(Map<String, dynamic> json) =>
      _$LocaleModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleModelToJson(this);
}
