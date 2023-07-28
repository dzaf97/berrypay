import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SSLoginModelVO {
  String? loginId;
  LoginType? loginType;
  String? loginPassword;
  bool? isBiometricEnabled;
  String? cdcvmPinHash;
  bool? isCdcvmUpdated;
  bool? isCDCVMSetupRequired;
  LoginMode? loginMode;
  SSOtpVO? otp;
  String? mobileNoCountryCode;

  SSLoginModelVO({
    this.loginId,
    this.loginType,
    this.loginPassword,
    this.isBiometricEnabled,
    this.cdcvmPinHash,
    this.isCdcvmUpdated,
    this.isCDCVMSetupRequired,
    this.loginMode,
    this.otp,
    this.mobileNoCountryCode,
  });

  factory SSLoginModelVO.fromJson(Map<String, dynamic> json) => _$SSLoginModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSLoginModelVOToJson(this);
}
