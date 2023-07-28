import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'change_mobile.g.dart';

@JsonSerializable()
class ChangeMobileNoRequest {
  final String walletId;
  final String newMobileNoCountryCode;
  final String loginId;
  final LoginType loginType;
  final LoginMode loginMode;
  final String newMobileNo;

  ChangeMobileNoRequest({
    required this.walletId,
    required this.newMobileNo,
    required this.newMobileNoCountryCode,
    required this.loginId,
    required this.loginType,
    required this.loginMode,
  });

  factory ChangeMobileNoRequest.fromJson(Map<String, dynamic> json) => _$ChangeMobileNoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeMobileNoRequestToJson(this);
}
