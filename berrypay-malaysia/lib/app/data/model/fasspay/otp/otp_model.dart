import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'otp_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSOtpModelVO {
  SSOtpModelVO({
    this.loginId,
    this.walletId,
    this.loginType,
    this.otp,
    this.isCDCVMSetupRequired,
    this.isCdcvmUpdated,
    this.isExistingUser,
  });

  String? loginId;
  String? walletId;
  LoginType? loginType;
  SSOtpVO? otp;
  bool? isCDCVMSetupRequired;
  bool? isCdcvmUpdated;
  bool? isExistingUser;

  factory SSOtpModelVO.fromJson(Map<String, dynamic> json) => _$SSOtpModelVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSOtpModelVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSOtpVO {
  SSOtpVO({
    this.otpValue,
    this.otpPacNo,
    this.otpMobileNoCountryCode,
    this.otpType,
    this.otpMobileNo,
    this.allowResendTimerMilliseconds,
  });

  String? otpValue;
  String? otpPacNo;
  String? otpMobileNoCountryCode;
  OtpType? otpType;
  String? otpMobileNo;
  int? allowResendTimerMilliseconds;

  factory SSOtpVO.fromJson(Map<String, dynamic> json) => _$SSOtpVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSOtpVOToJson(this);
}
