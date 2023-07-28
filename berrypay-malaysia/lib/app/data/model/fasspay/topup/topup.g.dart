// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUpCheckStatusRequest _$TopUpCheckStatusRequestFromJson(
        Map<String, dynamic> json) =>
    TopUpCheckStatusRequest(
      walletId: json['walletId'] as String?,
      cardId: json['cardId'] as String?,
      profileId: json['profileId'] as String?,
      amount: json['amount'] as String?,
      topUpMethod: json['topUpMethod'] as String?,
      creditDebitCard: json['creditDebitCard'] as String?,
    );

Map<String, dynamic> _$TopUpCheckStatusRequestToJson(
        TopUpCheckStatusRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'cardId': instance.cardId,
      'profileId': instance.profileId,
      'amount': instance.amount,
      'topUpMethod': instance.topUpMethod,
      'creditDebitCard': instance.creditDebitCard,
    };

TopUpRequest _$TopUpRequestFromJson(Map<String, dynamic> json) => TopUpRequest(
      walletId: json['walletId'] as String?,
      topUpMethodType: $enumDecodeNullable(
          _$TopUpMethodTypeEnumMap, json['topUpMethodType']),
      cardId: json['cardId'] as String?,
      amount: json['amount'] as String?,
      profileId: json['profileId'] as String?,
    );

Map<String, dynamic> _$TopUpRequestToJson(TopUpRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'topUpMethodType': _$TopUpMethodTypeEnumMap[instance.topUpMethodType],
      'cardId': instance.cardId,
      'amount': instance.amount,
      'profileId': instance.profileId,
    };

const _$TopUpMethodTypeEnumMap = {
  TopUpMethodType.TopUpMethodTypeUnknown: -1,
  TopUpMethodType.TopUpMethodTypeOnlineBanking: 0,
  TopUpMethodType.TopUpMethodTypeVisa: 1,
  TopUpMethodType.TopUpMethodTypeMastercard: 2,
  TopUpMethodType.TopUpMethodTypeAmex: 3,
  TopUpMethodType.TopUpMethodTypeCreditDebitCard: 5,
  TopUpMethodType.TopUpMethodTypePayNow: 6,
};

SSTopupModelVO _$SSTopupModelVOFromJson(Map<String, dynamic> json) =>
    SSTopupModelVO(
      amount: json['amount'] as String?,
      selectedWalletCard: json['selectedWalletCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['selectedWalletCard'] as Map<String, dynamic>),
      topUpDetail: json['topUpDetail'] == null
          ? null
          : SSTopUpDetailVO.fromJson(
              json['topUpDetail'] as Map<String, dynamic>),
      transactionRequestId: json['transactionRequestId'] as String?,
      isAsyncCheck: json['isAsyncCheck'] as bool?,
      gatewayRequestUrl: json['gatewayRequestUrl'] as String?,
      gatewayBaseUrl: json['gatewayBaseUrl'] as String?,
      transactionId: json['transactionId'] as String?,
      status: json['status'] == null
          ? null
          : SSStatusVO.fromJson(json['status'] as Map<String, dynamic>),
      topUpMethodList: (json['topUpMethodList'] as List<dynamic>?)
          ?.map((e) => SSParameterVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      topUpFavouriteCardList: (json['topUpFavouriteCardList'] as List<dynamic>?)
          ?.map((e) => SSWalletCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxTopUpAmount: json['maxTopUpAmount'] as String?,
      minTopUpAmount: json['minTopUpAmount'] as String?,
      payNowQR: json['payNowQR'] as String?,
      isOtpValidationRequied: json['isOtpValidationRequied'] as bool?,
      topUpMethod: json['topUpMethod'] as String?,
    );

Map<String, dynamic> _$SSTopupModelVOToJson(SSTopupModelVO instance) =>
    <String, dynamic>{
      'selectedWalletCard': instance.selectedWalletCard,
      'topUpDetail': instance.topUpDetail,
      'transactionRequestId': instance.transactionRequestId,
      'isAsyncCheck': instance.isAsyncCheck,
      'gatewayRequestUrl': instance.gatewayRequestUrl,
      'gatewayBaseUrl': instance.gatewayBaseUrl,
      'transactionId': instance.transactionId,
      'status': instance.status,
      'topUpMethodList': instance.topUpMethodList,
      'topUpFavouriteCardList': instance.topUpFavouriteCardList,
      'maxTopUpAmount': instance.maxTopUpAmount,
      'minTopUpAmount': instance.minTopUpAmount,
      'payNowQR': instance.payNowQR,
      'isOtpValidationRequied': instance.isOtpValidationRequied,
      'topUpMethod': instance.topUpMethod,
      'amount': instance.amount,
    };

SSParameterVO _$SSParameterVOFromJson(Map<String, dynamic> json) =>
    SSParameterVO(
      paramId: json['paramId'] as int?,
      paramName: json['paramName'] as String?,
      paramValue: json['paramValue'] as String?,
    );

Map<String, dynamic> _$SSParameterVOToJson(SSParameterVO instance) =>
    <String, dynamic>{
      'paramId': instance.paramId,
      'paramName': instance.paramName,
      'paramValue': instance.paramValue,
    };

SSStatusVO _$SSStatusVOFromJson(Map<String, dynamic> json) => SSStatusVO(
      code: json['code'] as int?,
      message: json['message'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$SSStatusVOToJson(SSStatusVO instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'reason': instance.reason,
    };
