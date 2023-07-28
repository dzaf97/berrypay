// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSOtpModelVO _$SSOtpModelVOFromJson(Map<String, dynamic> json) => SSOtpModelVO(
      loginId: json['loginId'] as String?,
      walletId: json['walletId'] as String?,
      loginType: $enumDecodeNullable(_$LoginTypeEnumMap, json['loginType']),
      otp: json['otp'] == null
          ? null
          : SSOtpVO.fromJson(json['otp'] as Map<String, dynamic>),
      isCDCVMSetupRequired: json['isCDCVMSetupRequired'] as bool?,
      isCdcvmUpdated: json['isCdcvmUpdated'] as bool?,
      isExistingUser: json['isExistingUser'] as bool?,
    );

Map<String, dynamic> _$SSOtpModelVOToJson(SSOtpModelVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('loginId', instance.loginId);
  writeNotNull('walletId', instance.walletId);
  writeNotNull('loginType', _$LoginTypeEnumMap[instance.loginType]);
  writeNotNull('otp', instance.otp?.toJson());
  writeNotNull('isCDCVMSetupRequired', instance.isCDCVMSetupRequired);
  writeNotNull('isCdcvmUpdated', instance.isCdcvmUpdated);
  writeNotNull('isExistingUser', instance.isExistingUser);
  return val;
}

const _$LoginTypeEnumMap = {
  LoginType.Unknown: -1,
  LoginType.WalletId: 0,
  LoginType.MobileNo: 1,
  LoginType.Email: 2,
};

SSOtpVO _$SSOtpVOFromJson(Map<String, dynamic> json) => SSOtpVO(
      otpValue: json['otpValue'] as String?,
      otpPacNo: json['otpPacNo'] as String?,
      otpMobileNoCountryCode: json['otpMobileNoCountryCode'] as String?,
      otpType: $enumDecodeNullable(_$OtpTypeEnumMap, json['otpType']),
      otpMobileNo: json['otpMobileNo'] as String?,
      allowResendTimerMilliseconds:
          json['allowResendTimerMilliseconds'] as int?,
    );

Map<String, dynamic> _$SSOtpVOToJson(SSOtpVO instance) => <String, dynamic>{
      'otpValue': instance.otpValue,
      'otpPacNo': instance.otpPacNo,
      'otpMobileNoCountryCode': instance.otpMobileNoCountryCode,
      'otpType': _$OtpTypeEnumMap[instance.otpType],
      'otpMobileNo': instance.otpMobileNo,
      'allowResendTimerMilliseconds': instance.allowResendTimerMilliseconds,
    };

const _$OtpTypeEnumMap = {
  OtpType.Unknown: -1,
  OtpType.Registration: 10,
  OtpType.Login: 20,
  OtpType.LoginSwitchDevice: 21,
  OtpType.ForgotPassword: 30,
  OtpType.ForgotCdcvmPin: 40,
  OtpType.ChangeMobileNo: 50,
  OtpType.ResetCardPin: 60,
  OtpType.UnbindCard: 70,
  OtpType.Withdrawal: 80,
};
