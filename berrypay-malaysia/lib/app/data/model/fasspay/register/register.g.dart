// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      mobileNumber: json['mobileNumber'] as String,
      mobileNumberCountryCode: json['mobileNumberCountryCode'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'mobileNumberCountryCode': instance.mobileNumberCountryCode,
    };
