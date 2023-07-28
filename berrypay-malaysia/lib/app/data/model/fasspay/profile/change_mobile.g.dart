// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_mobile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeMobileNoRequest _$ChangeMobileNoRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeMobileNoRequest(
      walletId: json['walletId'] as String,
      newMobileNo: json['newMobileNo'] as String,
      newMobileNoCountryCode: json['newMobileNoCountryCode'] as String,
      loginId: json['loginId'] as String,
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
      loginMode: $enumDecode(_$LoginModeEnumMap, json['loginMode']),
    );

Map<String, dynamic> _$ChangeMobileNoRequestToJson(
        ChangeMobileNoRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'newMobileNoCountryCode': instance.newMobileNoCountryCode,
      'loginId': instance.loginId,
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'loginMode': _$LoginModeEnumMap[instance.loginMode]!,
      'newMobileNo': instance.newMobileNo,
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
