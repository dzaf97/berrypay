// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSLoginModelVO _$SSLoginModelVOFromJson(Map<String, dynamic> json) =>
    SSLoginModelVO(
      loginId: json['loginId'] as String?,
      loginType: $enumDecodeNullable(_$LoginTypeEnumMap, json['loginType']),
      loginPassword: json['loginPassword'] as String?,
      isBiometricEnabled: json['isBiometricEnabled'] as bool?,
      cdcvmPinHash: json['cdcvmPinHash'] as String?,
      isCdcvmUpdated: json['isCdcvmUpdated'] as bool?,
      isCDCVMSetupRequired: json['isCDCVMSetupRequired'] as bool?,
      loginMode: $enumDecodeNullable(_$LoginModeEnumMap, json['loginMode']),
      otp: json['otp'] == null
          ? null
          : SSOtpVO.fromJson(json['otp'] as Map<String, dynamic>),
      mobileNoCountryCode: json['mobileNoCountryCode'] as String?,
    );

Map<String, dynamic> _$SSLoginModelVOToJson(SSLoginModelVO instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'loginType': _$LoginTypeEnumMap[instance.loginType],
      'loginPassword': instance.loginPassword,
      'isBiometricEnabled': instance.isBiometricEnabled,
      'cdcvmPinHash': instance.cdcvmPinHash,
      'isCdcvmUpdated': instance.isCdcvmUpdated,
      'isCDCVMSetupRequired': instance.isCDCVMSetupRequired,
      'loginMode': _$LoginModeEnumMap[instance.loginMode],
      'otp': instance.otp?.toJson(),
      'mobileNoCountryCode': instance.mobileNoCountryCode,
    };

const _$LoginTypeEnumMap = {
  LoginType.Unknown: -1,
  LoginType.WalletId: 0,
  LoginType.MobileNo: 1,
  LoginType.Email: 2,
};

const _$LoginModeEnumMap = {
  LoginMode.Unknown: -1,
  LoginMode.Normal: 10,
  LoginMode.ChangePassword: 40,
  LoginMode.Otp: 20,
};
