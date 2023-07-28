import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/topup/topup.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'withdrawal_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SSWithdrawalModelVO {
  SSWalletCardVO? selectedWalletCard;
  SSWithdrawalDetailVO? withdrawalDetail;
  String? transactionRequestId;
  String? transactionId;
  SSStatusVO? status;
  SSOtpVO? otp;
  List<SSParameterVO>? withdrawalBankList;

  SSWithdrawalModelVO({
    this.selectedWalletCard,
    this.withdrawalDetail,
    this.transactionRequestId,
    this.transactionId,
    this.status,
    this.otp,
    this.withdrawalBankList,
  });

  factory SSWithdrawalModelVO.fromJson(Map<String, dynamic> json) => _$SSWithdrawalModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWithdrawalModelVOToJson(this);
}
