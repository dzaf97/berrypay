import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wallet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SSWalletCardModelVO {
  final bool? isRefreshAll;
  final bool? allowIssueCard;
  final List<String>? selectedWalletCardIdList;
  final bool? isWebCdcvmBlocked;
  final CdcvmPinStatusType? cdcvmPinStatus;
  final int? totalWalletCardCount;
  final List<SSWalletCardVO>? walletCardList;
  final List<SSWalletCardVO>? topUpFavouriteCardList;
  final List<SSBillPaymentDetailVO>? billPaymentFavouriteList;
  final List<SSBillPaymentDetailVO>? billPaymentList;
  final List<SSUserProfileVO>? supplementaryProfileList;
  final SSUserProfileVO? userProfileVO;
  final String? emoneyMaxAmount;
  final String? refereeRewardAmount;
  final String? referrerRewardAmount;
  final String? partnerCode;
  final SSAddressVO? deliveryAddress;
  final String? supplementWalletId;
  final SSWalletCardVO? selectedWalletCard;
  final List<SSWalletCardVO>? issueNewCardList;

  SSWalletCardModelVO(
      this.isRefreshAll,
      this.allowIssueCard,
      this.selectedWalletCardIdList,
      this.isWebCdcvmBlocked,
      this.cdcvmPinStatus,
      this.totalWalletCardCount,
      this.walletCardList,
      this.topUpFavouriteCardList,
      this.billPaymentFavouriteList,
      this.billPaymentList,
      this.supplementaryProfileList,
      this.userProfileVO,
      this.emoneyMaxAmount,
      this.refereeRewardAmount,
      this.referrerRewardAmount,
      this.partnerCode,
      this.deliveryAddress,
      this.supplementWalletId,
      this.selectedWalletCard,
      this.issueNewCardList);

  factory SSWalletCardModelVO.fromJson(Map<String, dynamic> json) => _$SSWalletCardModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletCardModelVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSWalletCardVO {
  final String? cardId;
  final String? cardHolderName;
  final String? expiryDate;
  final String? cvv;
  final bool? isSaveAsFavourite;
  final String? creditLimit;
  final int? bankId;
  final String? cardName;
  final String? cardNumber;
  final String? walletAccountNo;
  final String? cardBalance;
  final String? frozenBalance;
  final CardAccountType? cardAccountType;
  final String? cardImage;
  final bool? isDefaultCard;
  final String? profileId;
  final CardType? cardType;
  final int? cardOrderId;
  final String? companyName;
  final bool? isPreIssueCard;
  final int? issueCardId;
  final int? lastEditedDateTime;
  final CardStatusType? cardStatusType;
  final bool? isCardUpdating;
  final String? issuingBankName;
  final String? cardSerialNo;
  final bool? isSharedBalance;
  final String? issuedDate;
  final bool? isBindCardCharge;
  final bool? isFavouriteCardTopUp;
  final String? linkedDateTimeFormatted;

  SSWalletCardVO(
      this.cardId,
      this.cardHolderName,
      this.expiryDate,
      this.cvv,
      this.isSaveAsFavourite,
      this.creditLimit,
      this.bankId,
      this.cardName,
      this.cardNumber,
      this.walletAccountNo,
      this.cardBalance,
      this.frozenBalance,
      this.cardAccountType,
      this.cardImage,
      this.isDefaultCard,
      this.profileId,
      this.cardType,
      this.cardOrderId,
      this.companyName,
      this.isPreIssueCard,
      this.issueCardId,
      this.lastEditedDateTime,
      this.cardStatusType,
      this.isCardUpdating,
      this.issuingBankName,
      this.cardSerialNo,
      this.isSharedBalance,
      this.issuedDate,
      this.isBindCardCharge,
      this.isFavouriteCardTopUp,
      this.linkedDateTimeFormatted);

  factory SSWalletCardVO.fromJson(Map<String, dynamic> json) => _$SSWalletCardVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletCardVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSWalletTransferModelVO {
  int? totalP2PCount;
  int? totalVerifiedP2PCount;
  String? beneficiaryRequestID;
  SSWalletCardVO? selectedWalletCard;
  List<SSWalletTransferDetailVO>? p2pList;
  List<SSWalletTransferEventDetailVO>? eventList;

  SSWalletTransferModelVO({
    this.totalP2PCount,
    this.totalVerifiedP2PCount,
    this.beneficiaryRequestID,
    this.selectedWalletCard,
    this.p2pList,
    this.eventList,
  });

  factory SSWalletTransferModelVO.fromJson(Map<String, dynamic> json) => _$SSWalletTransferModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletTransferModelVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSWalletTransferEventDetailVO {
  String? eventId;
  String? eventName;
  String? eventAmount;
  List<SSWalletTransferDetailVO>? p2pList;

  SSWalletTransferEventDetailVO({
    this.eventId,
    this.eventName,
    this.eventAmount,
    this.p2pList,
  });

  factory SSWalletTransferEventDetailVO.fromJson(Map<String, dynamic> json) => _$SSWalletTransferEventDetailVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletTransferEventDetailVOToJson(this);
}
