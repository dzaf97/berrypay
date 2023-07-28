// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpendingRequest _$SpendingRequestFromJson(Map<String, dynamic> json) =>
    SpendingRequest(
      walletId: json['walletId'] as String,
      cardId: json['cardId'] as String,
      barcodeData: json['barcodeData'] as String,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$SpendingRequestToJson(SpendingRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'cardId': instance.cardId,
      'barcodeData': instance.barcodeData,
      'amount': instance.amount,
    };

SSSpendingModelVO _$SSSpendingModelVOFromJson(Map<String, dynamic> json) =>
    SSSpendingModelVO(
      selectedWalletCard: json['selectedWalletCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['selectedWalletCard'] as Map<String, dynamic>),
      spendingDetail: json['spendingDetail'] == null
          ? null
          : SSSpendingDetailVO.fromJson(
              json['spendingDetail'] as Map<String, dynamic>),
      walletId: json['walletId'] as String?,
      transactionId: json['transactionId'] as String?,
      transactionDateTimeInMilis: json['transactionDateTimeInMilis'] as int?,
      transactionRequestId: json['transactionRequestId'] as String?,
    );

Map<String, dynamic> _$SSSpendingModelVOToJson(SSSpendingModelVO instance) =>
    <String, dynamic>{
      'selectedWalletCard': instance.selectedWalletCard,
      'spendingDetail': instance.spendingDetail,
      'walletId': instance.walletId,
      'transactionId': instance.transactionId,
      'transactionDateTimeInMilis': instance.transactionDateTimeInMilis,
      'transactionRequestId': instance.transactionRequestId,
    };

SSWalletCardVO _$SSWalletCardVOFromJson(Map<String, dynamic> json) =>
    SSWalletCardVO(
      cardId: json['cardId'] as String?,
    )
      ..cardBalance = json['cardBalance'] as String?
      ..transactionId = json['transactionId'] as String?
      ..amount = json['amount'] as String?;

Map<String, dynamic> _$SSWalletCardVOToJson(SSWalletCardVO instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardBalance': instance.cardBalance,
      'transactionId': instance.transactionId,
      'amount': instance.amount,
    };

SSSpendingDetailVO _$SSSpendingDetailVOFromJson(Map<String, dynamic> json) =>
    SSSpendingDetailVO(
      geoLocationInfo: json['geoLocationInfo'] == null
          ? null
          : GeoLocationInfoVO.fromJson(
              json['geoLocationInfo'] as Map<String, dynamic>),
      billPaymentDetail: json['billPaymentDetail'] == null
          ? null
          : SSBillPaymentDetailVO.fromJson(
              json['billPaymentDetail'] as Map<String, dynamic>),
      merchantName: json['merchantName'] as String?,
      approvalCode: json['approvalCode'] as String?,
      mid: json['mid'] as String?,
      tid: json['tid'] as String?,
      traceNo: json['traceNo'] as String?,
      barcodeData: json['barcodeData'] as String?,
      productDesc: json['productDesc'] as String?,
      amount: json['amount'] as String?,
      channelType:
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType']),
    );

Map<String, dynamic> _$SSSpendingDetailVOToJson(SSSpendingDetailVO instance) =>
    <String, dynamic>{
      'barcodeData': instance.barcodeData,
      'geoLocationInfo': instance.geoLocationInfo?.toJson(),
      'billPaymentDetail': instance.billPaymentDetail?.toJson(),
      'merchantName': instance.merchantName,
      'approvalCode': instance.approvalCode,
      'mid': instance.mid,
      'tid': instance.tid,
      'traceNo': instance.traceNo,
      'productDesc': instance.productDesc,
      'amount': instance.amount,
      'channelType': _$ChannelTypeEnumMap[instance.channelType],
    };

const _$ChannelTypeEnumMap = {
  ChannelType.Unknown: 0,
  ChannelType.SpendingMerchantPresentedStatic: 100,
  ChannelType.SpendingMerchantPresentedDynamic: 101,
  ChannelType.SpendingCustomerPresentedStatic: 102,
  ChannelType.SpendingCustomerPresentedDynamic: 103,
  ChannelType.SpendingInAppPurchase: 104,
  ChannelType.SpendingPaymentGateway: 105,
  ChannelType.SpendingEcommerceLogin: 106,
  ChannelType.SpendingEcommerceQrDynamic: 107,
  ChannelType.SpendingCreditDebitCard: 108,
  ChannelType.SpendingCASA: 109,
  ChannelType.SpendingPhysicalCard: 110,
  ChannelType.TopUpCreditDebitCard: 200,
  ChannelType.TopUpCASA: 201,
  ChannelType.TopUpMPOS: 202,
  ChannelType.TopUpCredit: 205,
  ChannelType.TopUpDebit: 206,
  ChannelType.TopUpPayNow: 209,
  ChannelType.WithdrawalOwnCasa: 300,
  ChannelType.WithdrawalOtherCasa: 301,
  ChannelType.FundTransfer: 400,
  ChannelType.FundTransferP2p: 401,
  ChannelType.PreAuthCreditCard: -1,
};

GeoLocationInfoVO _$GeoLocationInfoVOFromJson(Map<String, dynamic> json) =>
    GeoLocationInfoVO(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      altitude: json['altitude'] as String?,
    );

Map<String, dynamic> _$GeoLocationInfoVOToJson(GeoLocationInfoVO instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
    };

SSBillPaymentDetailVO _$SSBillPaymentDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSBillPaymentDetailVO(
      billerPlatformType: $enumDecodeNullable(
          _$BillerPlatformTypeEnumMap, json['billerPlatformType']),
      billerName: json['billerName'] as String?,
      billAmountType: $enumDecodeNullable(
          _$BillPaymentAmountTypeEnumMap, json['billAmountType']),
      requiredAmount: json['requiredAmount'] as String?,
      productCode: json['productCode'] as String?,
      billTransactionType: $enumDecodeNullable(
          _$BillPaymentTransactionTypeEnumMap, json['billTransactionType']),
      billPaymentRemark: json['billPaymentRemark'] as String?,
      billerSubCategory: json['billerSubCategory'] as String?,
      isFavouriteBiller: json['isFavouriteBiller'] as bool?,
      logoURL: json['logoURL'] as String?,
      billPaymentInputFieldList:
          (json['billPaymentInputFieldList'] as List<dynamic>?)
              ?.map((e) =>
                  SSBillPaymentInputFieldVO.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SSBillPaymentDetailVOToJson(
        SSBillPaymentDetailVO instance) =>
    <String, dynamic>{
      'billerPlatformType':
          _$BillerPlatformTypeEnumMap[instance.billerPlatformType],
      'billerName': instance.billerName,
      'billAmountType': _$BillPaymentAmountTypeEnumMap[instance.billAmountType],
      'requiredAmount': instance.requiredAmount,
      'productCode': instance.productCode,
      'billTransactionType':
          _$BillPaymentTransactionTypeEnumMap[instance.billTransactionType],
      'billPaymentRemark': instance.billPaymentRemark,
      'billerSubCategory': instance.billerSubCategory,
      'isFavouriteBiller': instance.isFavouriteBiller,
      'logoURL': instance.logoURL,
      'billPaymentInputFieldList':
          instance.billPaymentInputFieldList?.map((e) => e.toJson()).toList(),
    };

const _$BillerPlatformTypeEnumMap = {
  BillerPlatformType.BillerPlatformTypeUnknown: 100,
  BillerPlatformType.BillerPlatformTypeMobilePrepaid: 101,
  BillerPlatformType.BillerPlatformTypeBillPayment: 103,
};

const _$BillPaymentAmountTypeEnumMap = {
  BillPaymentAmountType.BillPaymentAmountTypeUnknown: 0,
  BillPaymentAmountType.BillPaymentAmountTypeStatic: 1,
  BillPaymentAmountType.BillPaymentAmountTypeDynamic: 2,
};

const _$BillPaymentTransactionTypeEnumMap = {
  BillPaymentTransactionType.BillPaymentTransactionTypeUnknown: 0,
  BillPaymentTransactionType.BillPaymentTransactionTypePIN: 1,
  BillPaymentTransactionType.BillPaymentTransactionTypeETU: 2,
};

SSBillPaymentInputFieldVO _$SSBillPaymentInputFieldVOFromJson(
        Map<String, dynamic> json) =>
    SSBillPaymentInputFieldVO(
      billPaymentFieldInputType: $enumDecodeNullable(
          _$BillPaymentFieldInputTypeEnumMap,
          json['billPaymentFieldInputType']),
      billPaymentFieldName: json['billPaymentFieldName'] as String?,
      billPaymentFieldLength: json['billPaymentFieldLength'] as int?,
      billPaymentFieldValue: json['billPaymentFieldValue'] as String?,
      billPaymentDefaultPrefix: json['billPaymentDefaultPrefix'] as String?,
    );

Map<String, dynamic> _$SSBillPaymentInputFieldVOToJson(
        SSBillPaymentInputFieldVO instance) =>
    <String, dynamic>{
      'billPaymentFieldInputType': _$BillPaymentFieldInputTypeEnumMap[
          instance.billPaymentFieldInputType],
      'billPaymentFieldName': instance.billPaymentFieldName,
      'billPaymentFieldLength': instance.billPaymentFieldLength,
      'billPaymentFieldValue': instance.billPaymentFieldValue,
      'billPaymentDefaultPrefix': instance.billPaymentDefaultPrefix,
    };

const _$BillPaymentFieldInputTypeEnumMap = {
  BillPaymentFieldInputType.BillPaymentFieldInputTypeUnknown: -1,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeAlphaNumeric: 0,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeNumeric: 1,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeMobileNumeric: 2,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeNRIC: 3,
};

SpendingQrRequest _$SpendingQrRequestFromJson(Map<String, dynamic> json) =>
    SpendingQrRequest(
      walletId: json['walletId'] as String,
      cardId: json['cardId'] as String,
      transactionRequestId: json['transactionRequestId'] as String?,
    );

Map<String, dynamic> _$SpendingQrRequestToJson(SpendingQrRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'cardId': instance.cardId,
      'transactionRequestId': instance.transactionRequestId,
    };

VerifyP2PBarcodeRequest _$VerifyP2PBarcodeRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyP2PBarcodeRequest(
      walletId: json['walletId'] as String,
      barcodeData: json['barcodeData'] as String,
    );

Map<String, dynamic> _$VerifyP2PBarcodeRequestToJson(
        VerifyP2PBarcodeRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'barcodeData': instance.barcodeData,
    };

InAppPurchaseRequest _$InAppPurchaseRequestFromJson(
        Map<String, dynamic> json) =>
    InAppPurchaseRequest(
      walletId: json['walletId'] as String,
      cardId: json['cardId'] as String,
      amount: json['amount'] as String,
      mid: json['mid'] as String,
      productDesc: json['productDesc'] as String?,
    );

Map<String, dynamic> _$InAppPurchaseRequestToJson(
        InAppPurchaseRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'cardId': instance.cardId,
      'amount': instance.amount,
      'mid': instance.mid,
      'productDesc': instance.productDesc,
    };
