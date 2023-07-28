import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/status_model.dart';
import 'package:get/state_manager.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TransferP2PRequest {
  FasspayBaseEnum fasspayBaseEnum;
  String senderWalletId;
  String senderCardId;
  String receiverWalletId;
  String amount;
  String? transferDescription;
  SSWalletTransferRequestDetailVO? ssWalletTransferRequestDetailVO;

  TransferP2PRequest({
    required this.fasspayBaseEnum,
    required this.senderWalletId,
    required this.senderCardId,
    required this.receiverWalletId,
    required this.amount,
    this.transferDescription,
    this.ssWalletTransferRequestDetailVO,
  });

  factory TransferP2PRequest.fromJson(Map<String, dynamic> json) => _$TransferP2PRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TransferP2PRequestToJson(this);
}

@JsonSerializable()
class SSTransactionHistoryModelVO {
  final int? itemsPerPage;
  final int? pagingNo;
  final String? searchWalletCardId;
  final TransactionType? transactionType;
  final List<SSTransactionCardVO>? transactionCardList;

  SSTransactionHistoryModelVO({
    this.itemsPerPage,
    this.pagingNo,
    this.searchWalletCardId,
    this.transactionType,
    this.transactionCardList,
  });

  factory SSTransactionHistoryModelVO.fromJson(Map<String, dynamic> json) => _$SSTransactionHistoryModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSTransactionHistoryModelVOToJson(this);
}

@JsonSerializable()
class SSTransactionCardVO {
  final String? walletCardId;
  final bool? isLoadMoreAvailable;
  final List<SSTransactionVO>? transactionList;

  SSTransactionCardVO(this.walletCardId, this.isLoadMoreAvailable, this.transactionList);

  factory SSTransactionCardVO.fromJson(Map<String, dynamic> json) => _$SSTransactionCardVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSTransactionCardVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SSTransactionVO {
  final TransactionStatusType? transactionStatus;
  final TransactionType? transactionType;
  final String? transactionId;
  final String? transactionDateTime;
  final SSSpendingDetailVO? spendingDetail;
  final SSWithdrawalDetailVO? withdrawalDetail;
  final SSTopUpDetailVO? topUpDetail;
  final SSTransferDetailVO? transferDetail;
  final SSSpendingPassthroughDetailVO? spendingPassthroughDetail;
  final SSWalletTransferDetailVO? p2pDetail;

  SSTransactionVO({
    this.transactionStatus,
    this.transactionType,
    this.transactionId,
    this.transactionDateTime,
    this.spendingDetail,
    this.withdrawalDetail,
    this.topUpDetail,
    this.transferDetail,
    this.spendingPassthroughDetail,
    this.p2pDetail,
  });

  factory SSTransactionVO.fromJson(Map<String, dynamic> json) => _$SSTransactionVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSTransactionVOToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSSpendingDetailVO extends SSTransactionDetailVO {
  final String? barcodeData;
  final String? merchantName;
  final String? approvalCode;
  final String? mid;
  final String? tid;
  final String? productDesc;
  final SSBillPaymentDetailVO? billPaymentDetail;

  SSSpendingDetailVO({
    this.barcodeData,
    this.merchantName,
    this.approvalCode,
    this.mid,
    this.tid,
    this.productDesc,
    this.billPaymentDetail,
  }) : super();

  factory SSSpendingDetailVO.fromJson(Map<String, dynamic> json) => _$SSSpendingDetailVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SSSpendingDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSWithdrawalDetailVO extends SSTransactionDetailVO {
  final int? bankId;
  final String? accountNo;
  final String? accountName;
  final SSWalletCardVO? creditDebitCard;
  final String? identificationImage;
  final String? withdrawalCharges;
  final String? withdrawalNetAmount;
  final String? withdrawalMaxAmount;
  final String? bankName;
  final SSGeoLocationInfoVO? geoLocationInfo;

  SSWithdrawalDetailVO({
    this.bankId,
    this.accountNo,
    this.accountName,
    this.creditDebitCard,
    this.identificationImage,
    this.withdrawalCharges,
    this.withdrawalNetAmount,
    this.withdrawalMaxAmount,
    this.bankName,
    this.geoLocationInfo,
  }) : super();

  factory SSWithdrawalDetailVO.fromJson(Map<String, dynamic> json) => _$SSWithdrawalDetailVOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SSWithdrawalDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSGeoLocationInfoVO {
  String? latitude;
  String? longitude;
  String? altitude;

  SSGeoLocationInfoVO({
    this.latitude,
    this.longitude,
    this.altitude,
  });

  factory SSGeoLocationInfoVO.fromJson(Map<String, dynamic> json) => _$SSGeoLocationInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSGeoLocationInfoVOToJson(this);
}

@JsonSerializable()
class SSTransactionDetailVO {
  ChannelType? channelType;
  GatewayType? gatewayType;
  String? amount;
  String? amountAuthorized;
  String? currencyCode;
  String? foreignAmountAuthorized;
  String? foreignCurrencyCode;
  String? processingFee;

  SSTransactionDetailVO({
    this.channelType,
    this.amount,
    this.amountAuthorized,
    this.currencyCode,
    this.foreignAmountAuthorized,
    this.foreignCurrencyCode,
    this.processingFee,
  });

  factory SSTransactionDetailVO.fromJson(Map<String, dynamic> json) => _$SSTransactionDetailVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSTransactionDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSTopUpDetailVO extends SSTransactionDetailVO {
  final TopUpMethodType? topUpMethod;
  final CardType? cardType;
  final SSWalletCardVO? creditDebitCard;

  SSTopUpDetailVO({
    this.topUpMethod,
    this.cardType,
    this.creditDebitCard,
  }) : super();

  factory SSTopUpDetailVO.fromJson(Map<String, dynamic> json) => _$SSTopUpDetailVOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SSTopUpDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSTransferDetailVO extends SSTransactionDetailVO {
  final String? transferName;
  final TransferInputType? transferInputType;

  SSTransferDetailVO({
    this.transferName,
    this.transferInputType,
  }) : super();

  factory SSTransferDetailVO.fromJson(Map<String, dynamic> json) => _$SSTransferDetailVOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SSTransferDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSSpendingPassthroughDetailVO extends SSTransactionDetailVO {
  final String? merchantName;
  final String? approvalCode;
  final String? mid;
  final SpendingPassthroughMethodType? paymentGatewayChannelId;
  final CardType? cardType;
  final SSWalletCardVO? creditDebitCard;
  final String? productDesc;
  final SSBillPaymentDetailVO? billPaymentDetail;

  SSSpendingPassthroughDetailVO({
    this.merchantName,
    this.approvalCode,
    this.mid,
    this.paymentGatewayChannelId,
    this.cardType,
    this.creditDebitCard,
    this.productDesc,
    this.billPaymentDetail,
  }) : super();

  factory SSSpendingPassthroughDetailVO.fromJson(Map<String, dynamic> json) => _$SSSpendingPassthroughDetailVOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SSSpendingPassthroughDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SSWalletTransferDetailVO extends SSTransactionDetailVO {
  final bool? isAddContacts;
  final bool? isChangedAmount;
  final bool? isFixAmount;
  final String? transferDesc;
  final SSUserProfileVO? userProfile;
  final SSWalletTransferRequestDetailVO? transferRequestDetail;
  final SSStatus? status;
  final String? transactionId;

  @JsonKey(ignore: true)
  RxBool? isCheck;

  SSWalletTransferDetailVO({
    this.isAddContacts,
    this.isChangedAmount,
    this.isFixAmount,
    this.transferDesc,
    this.userProfile,
    this.transferRequestDetail,
    this.status,
    this.transactionId,
    this.isCheck,
  }) : super();

  factory SSWalletTransferDetailVO.fromJson(Map<String, dynamic> json) => _$SSWalletTransferDetailVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SSWalletTransferDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSBillPaymentDetailVO {
  final String? billerName;
  final String? productCode;
  final String? requiredAmount;
  final BillerPlatformType? billerPlatformType;
  final BillPaymentAmountType? billAmountType;
  final BillPaymentTransactionType? billTransactionType;
  final String? billPaymentRemark;
  final String? billerSubCategory;
  final bool? isFavouriteBiller;
  final List<SSBillPaymentInputFieldVO>? billPaymentInputFieldList;

  SSBillPaymentDetailVO(this.billerName, this.productCode, this.requiredAmount, this.billerPlatformType, this.billAmountType,
      this.billTransactionType, this.billPaymentRemark, this.billerSubCategory, this.isFavouriteBiller, this.billPaymentInputFieldList);

  factory SSBillPaymentDetailVO.fromJson(Map<String, dynamic> json) => _$SSBillPaymentDetailVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSBillPaymentDetailVOToJson(this);
}

@JsonSerializable()
class SSWalletCardVO {
  final String? cardId;
  final String? cardName;
  final String? cardNumber;
  final String? cardBalance;
  final CardAccountType? cardAccountType;
  final String? cardImage;
  final bool? isDefaultCard;
  final String? profileId;
  final CardType? cardType;
  final int? lastEditedDateTime;
  final CardStatusType? cardStatusType;
  final String? issuingBankName;
  final String? expiryDate;
  final String? cardSerialNo;
  final bool? isSharedBalance;
  final String? creditLimit;
  final int? issueCardId;

  SSWalletCardVO(
      this.cardId,
      this.cardName,
      this.cardNumber,
      this.cardBalance,
      this.cardAccountType,
      this.cardImage,
      this.isDefaultCard,
      this.profileId,
      this.cardType,
      this.lastEditedDateTime,
      this.cardStatusType,
      this.issuingBankName,
      this.expiryDate,
      this.cardSerialNo,
      this.isSharedBalance,
      this.creditLimit,
      this.issueCardId);

  factory SSWalletCardVO.fromJson(Map<String, dynamic> json) => _$SSWalletCardVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletCardVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSWalletTransferRequestDetailVO {
  final String? transferRequestDateTime;
  final String? transferRequestId;
  TransferRequestStatus? transferRequestStatus;
  TransferRequestStatus? transferRequestStatusId;
  TransferRequestType? transferRequestTypeId;
  TransferRequestType? transferRequestType;

  SSWalletTransferRequestDetailVO(
    this.transferRequestId,
    this.transferRequestStatus,
    this.transferRequestType,
    this.transferRequestDateTime,
    this.transferRequestTypeId,
    this.transferRequestStatusId,
  );

  factory SSWalletTransferRequestDetailVO.fromJson(Map<String, dynamic> json) => _$SSWalletTransferRequestDetailVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSWalletTransferRequestDetailVOToJson(this);
}

@JsonSerializable()
class SSBillPaymentInputFieldVO {
  final String? billPaymentFieldName;
  final String? billPaymentFieldValue;
  final int? billPaymentFieldLength;
  final BillPaymentFieldInputType? billPaymentFieldInputType;

  SSBillPaymentInputFieldVO(this.billPaymentFieldName, this.billPaymentFieldValue, this.billPaymentFieldLength, this.billPaymentFieldInputType);

  factory SSBillPaymentInputFieldVO.fromJson(Map<String, dynamic> json) => _$SSBillPaymentInputFieldVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSBillPaymentInputFieldVOToJson(this);
}
