// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleModel _$LocaleModelFromJson(Map<String, dynamic> json) => LocaleModel(
      language: json['language'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$LocaleModelToJson(LocaleModel instance) =>
    <String, dynamic>{
      'language': instance.language,
      'countryCode': instance.countryCode,
    };
