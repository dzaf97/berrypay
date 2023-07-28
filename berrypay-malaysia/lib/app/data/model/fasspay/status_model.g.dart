// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSStatus _$SSStatusFromJson(Map<String, dynamic> json) => SSStatus(
      json['code'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$SSStatusToJson(SSStatus instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
