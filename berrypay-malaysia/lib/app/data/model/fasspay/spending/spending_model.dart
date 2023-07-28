import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'spending_model.g.dart';

@JsonSerializable()
class SpendingRequest {
  SpendingRequest({
    required this.walletId,
    required this.cardId,
    required this.barcodeData,
    this.amount,
  });

  String walletId;
  String cardId;
  String barcodeData;
  String? amount;

  factory SpendingRequest.fromJson(Map<String, dynamic> json) => _$SpendingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingRequestToJson(this);
}

@JsonSerializable()
class SSSpendingModelVO {
  SSSpendingModelVO(
      {this.selectedWalletCard, this.spendingDetail, this.walletId, this.transactionId, this.transactionDateTimeInMilis, this.transactionRequestId});

  SSWalletCardVO? selectedWalletCard;
  SSSpendingDetailVO? spendingDetail;
  String? walletId;
  String? transactionId;
  int? transactionDateTimeInMilis;
  String? transactionRequestId;

  factory SSSpendingModelVO.fromJson(Map<String, dynamic> json) => _$SSSpendingModelVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSSpendingModelVOToJson(this);
}

@JsonSerializable()
class SSWalletCardVO {
  SSWalletCardVO({
    this.cardId,
  });
  String? cardId;
  String? cardBalance;
  String? transactionId;
  String? amount;

  factory SSWalletCardVO.fromJson(Map<String, dynamic> json) => _$SSWalletCardVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSWalletCardVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSSpendingDetailVO {
  SSSpendingDetailVO({
    this.geoLocationInfo,
    this.billPaymentDetail,
    this.merchantName,
    this.approvalCode,
    this.mid,
    this.tid,
    this.traceNo,
    this.barcodeData,
    this.productDesc,
    this.amount,
    this.channelType,
  });

  final String? barcodeData;
  final GeoLocationInfoVO? geoLocationInfo;
  final SSBillPaymentDetailVO? billPaymentDetail;
  final String? merchantName;
  final String? approvalCode;
  final String? mid;
  final String? tid;
  final String? traceNo;
  final String? productDesc;
  final String? amount;
  final ChannelType? channelType;

  factory SSSpendingDetailVO.fromJson(Map<String, dynamic> json) => _$SSSpendingDetailVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSSpendingDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GeoLocationInfoVO {
  GeoLocationInfoVO({this.latitude, this.longitude, this.altitude});

  final String? latitude;
  final String? longitude;
  final String? altitude;

  factory GeoLocationInfoVO.fromJson(Map<String, dynamic> json) => _$GeoLocationInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationInfoVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSBillPaymentDetailVO {
  SSBillPaymentDetailVO({
    this.billerPlatformType,
    this.billerName,
    this.billAmountType,
    this.requiredAmount,
    this.productCode,
    this.billTransactionType,
    this.billPaymentRemark,
    this.billerSubCategory,
    this.isFavouriteBiller,
    this.logoURL,
    this.billPaymentInputFieldList,
  });

  final BillerPlatformType? billerPlatformType;
  final String? billerName;
  final BillPaymentAmountType? billAmountType;
  final String? requiredAmount;
  final String? productCode;
  final BillPaymentTransactionType? billTransactionType;
  final String? billPaymentRemark;
  final String? billerSubCategory;
  final bool? isFavouriteBiller;
  final String? logoURL;
  final List<SSBillPaymentInputFieldVO>? billPaymentInputFieldList;

  factory SSBillPaymentDetailVO.fromJson(Map<String, dynamic> json) => _$SSBillPaymentDetailVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSBillPaymentDetailVOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SSBillPaymentInputFieldVO {
  SSBillPaymentInputFieldVO({
    this.billPaymentFieldInputType,
    this.billPaymentFieldName,
    this.billPaymentFieldLength,
    this.billPaymentFieldValue,
    this.billPaymentDefaultPrefix,
  });
  final BillPaymentFieldInputType? billPaymentFieldInputType;
  final String? billPaymentFieldName;
  final int? billPaymentFieldLength;
  final String? billPaymentFieldValue;
  final String? billPaymentDefaultPrefix;

  factory SSBillPaymentInputFieldVO.fromJson(Map<String, dynamic> json) => _$SSBillPaymentInputFieldVOFromJson(json);

  Map<String, dynamic> toJson() => _$SSBillPaymentInputFieldVOToJson(this);
}

@JsonSerializable()
class SpendingQrRequest {
  SpendingQrRequest({
    required this.walletId,
    required this.cardId,
    this.transactionRequestId,
  });

  String walletId;
  String cardId;
  String? transactionRequestId;

  factory SpendingQrRequest.fromJson(Map<String, dynamic> json) => _$SpendingQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingQrRequestToJson(this);
}

@JsonSerializable()
class VerifyP2PBarcodeRequest {
  VerifyP2PBarcodeRequest({
    required this.walletId,
    required this.barcodeData,
  });

  String walletId;
  String barcodeData;

  factory VerifyP2PBarcodeRequest.fromJson(Map<String, dynamic> json) => _$VerifyP2PBarcodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyP2PBarcodeRequestToJson(this);
}

@JsonSerializable()
class InAppPurchaseRequest {
  InAppPurchaseRequest({
    required this.walletId,
    required this.cardId,
    required this.amount,
    required this.mid,
    this.productDesc,
  });

  String walletId;
  String cardId;
  String amount;
  String mid;
  String? productDesc;

  factory InAppPurchaseRequest.fromJson(Map<String, dynamic> json) => _$InAppPurchaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InAppPurchaseRequestToJson(this);
}
