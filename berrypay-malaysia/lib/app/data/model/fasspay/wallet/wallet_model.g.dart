// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSWalletCardModelVO _$SSWalletCardModelVOFromJson(Map<String, dynamic> json) =>
    SSWalletCardModelVO(
      json['isRefreshAll'] as bool?,
      json['allowIssueCard'] as bool?,
      (json['selectedWalletCardIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['isWebCdcvmBlocked'] as bool?,
      $enumDecodeNullable(_$CdcvmPinStatusTypeEnumMap, json['cdcvmPinStatus']),
      json['totalWalletCardCount'] as int?,
      (json['walletCardList'] as List<dynamic>?)
          ?.map((e) => SSWalletCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['topUpFavouriteCardList'] as List<dynamic>?)
          ?.map((e) => SSWalletCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['billPaymentFavouriteList'] as List<dynamic>?)
          ?.map(
              (e) => SSBillPaymentDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['billPaymentList'] as List<dynamic>?)
          ?.map(
              (e) => SSBillPaymentDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['supplementaryProfileList'] as List<dynamic>?)
          ?.map((e) => SSUserProfileVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['userProfileVO'] == null
          ? null
          : SSUserProfileVO.fromJson(
              json['userProfileVO'] as Map<String, dynamic>),
      json['emoneyMaxAmount'] as String?,
      json['refereeRewardAmount'] as String?,
      json['referrerRewardAmount'] as String?,
      json['partnerCode'] as String?,
      json['deliveryAddress'] == null
          ? null
          : SSAddressVO.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>),
      json['supplementWalletId'] as String?,
      json['selectedWalletCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['selectedWalletCard'] as Map<String, dynamic>),
      (json['issueNewCardList'] as List<dynamic>?)
          ?.map((e) => SSWalletCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSWalletCardModelVOToJson(
        SSWalletCardModelVO instance) =>
    <String, dynamic>{
      'isRefreshAll': instance.isRefreshAll,
      'allowIssueCard': instance.allowIssueCard,
      'selectedWalletCardIdList': instance.selectedWalletCardIdList,
      'isWebCdcvmBlocked': instance.isWebCdcvmBlocked,
      'cdcvmPinStatus': _$CdcvmPinStatusTypeEnumMap[instance.cdcvmPinStatus],
      'totalWalletCardCount': instance.totalWalletCardCount,
      'walletCardList':
          instance.walletCardList?.map((e) => e.toJson()).toList(),
      'topUpFavouriteCardList':
          instance.topUpFavouriteCardList?.map((e) => e.toJson()).toList(),
      'billPaymentFavouriteList':
          instance.billPaymentFavouriteList?.map((e) => e.toJson()).toList(),
      'billPaymentList':
          instance.billPaymentList?.map((e) => e.toJson()).toList(),
      'supplementaryProfileList':
          instance.supplementaryProfileList?.map((e) => e.toJson()).toList(),
      'userProfileVO': instance.userProfileVO?.toJson(),
      'emoneyMaxAmount': instance.emoneyMaxAmount,
      'refereeRewardAmount': instance.refereeRewardAmount,
      'referrerRewardAmount': instance.referrerRewardAmount,
      'partnerCode': instance.partnerCode,
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'supplementWalletId': instance.supplementWalletId,
      'selectedWalletCard': instance.selectedWalletCard?.toJson(),
      'issueNewCardList':
          instance.issueNewCardList?.map((e) => e.toJson()).toList(),
    };

const _$CdcvmPinStatusTypeEnumMap = {
  CdcvmPinStatusType.NotDetermined: 'NotDetermined',
  CdcvmPinStatusType.Blocked: 'Blocked',
  CdcvmPinStatusType.Active: 'Active',
};

SSWalletCardVO _$SSWalletCardVOFromJson(Map<String, dynamic> json) =>
    SSWalletCardVO(
      json['cardId'] as String?,
      json['cardHolderName'] as String?,
      json['expiryDate'] as String?,
      json['cvv'] as String?,
      json['isSaveAsFavourite'] as bool?,
      json['creditLimit'] as String?,
      json['bankId'] as int?,
      json['cardName'] as String?,
      json['cardNumber'] as String?,
      json['walletAccountNo'] as String?,
      json['cardBalance'] as String?,
      json['frozenBalance'] as String?,
      $enumDecodeNullable(_$CardAccountTypeEnumMap, json['cardAccountType']),
      json['cardImage'] as String?,
      json['isDefaultCard'] as bool?,
      json['profileId'] as String?,
      $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']),
      json['cardOrderId'] as int?,
      json['companyName'] as String?,
      json['isPreIssueCard'] as bool?,
      json['issueCardId'] as int?,
      json['lastEditedDateTime'] as int?,
      $enumDecodeNullable(_$CardStatusTypeEnumMap, json['cardStatusType']),
      json['isCardUpdating'] as bool?,
      json['issuingBankName'] as String?,
      json['cardSerialNo'] as String?,
      json['isSharedBalance'] as bool?,
      json['issuedDate'] as String?,
      json['isBindCardCharge'] as bool?,
      json['isFavouriteCardTopUp'] as bool?,
      json['linkedDateTimeFormatted'] as String?,
    );

Map<String, dynamic> _$SSWalletCardVOToJson(SSWalletCardVO instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardHolderName': instance.cardHolderName,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'isSaveAsFavourite': instance.isSaveAsFavourite,
      'creditLimit': instance.creditLimit,
      'bankId': instance.bankId,
      'cardName': instance.cardName,
      'cardNumber': instance.cardNumber,
      'walletAccountNo': instance.walletAccountNo,
      'cardBalance': instance.cardBalance,
      'frozenBalance': instance.frozenBalance,
      'cardAccountType': _$CardAccountTypeEnumMap[instance.cardAccountType],
      'cardImage': instance.cardImage,
      'isDefaultCard': instance.isDefaultCard,
      'profileId': instance.profileId,
      'cardType': _$CardTypeEnumMap[instance.cardType],
      'cardOrderId': instance.cardOrderId,
      'companyName': instance.companyName,
      'isPreIssueCard': instance.isPreIssueCard,
      'issueCardId': instance.issueCardId,
      'lastEditedDateTime': instance.lastEditedDateTime,
      'cardStatusType': _$CardStatusTypeEnumMap[instance.cardStatusType],
      'isCardUpdating': instance.isCardUpdating,
      'issuingBankName': instance.issuingBankName,
      'cardSerialNo': instance.cardSerialNo,
      'isSharedBalance': instance.isSharedBalance,
      'issuedDate': instance.issuedDate,
      'isBindCardCharge': instance.isBindCardCharge,
      'isFavouriteCardTopUp': instance.isFavouriteCardTopUp,
      'linkedDateTimeFormatted': instance.linkedDateTimeFormatted,
    };

const _$CardAccountTypeEnumMap = {
  CardAccountType.Unknown: -1,
  CardAccountType.EMoney: 0,
  CardAccountType.CreditDebit: 1,
  CardAccountType.CASA: 2,
  CardAccountType.Frozen: -2,
};

const _$CardTypeEnumMap = {
  CardType.CardTypeVisa: 0,
  CardType.CardTypeMaster: 1,
  CardType.CardTypeAmex: 2,
  CardType.CardTypeJcb: 3,
  CardType.CardTypeMaestro: 4,
  CardType.CardTypeCIMBNiagaDebit: 5,
  CardType.CardTypeCIMBNiagaBizcard: 6,
  CardType.CardTypeUnionPay: 7,
  CardType.CardTypeMccs: 8,
  CardType.CardTypeEwallet: 9,
};

const _$CardStatusTypeEnumMap = {
  CardStatusType.CardStatusTypeUnknown: -1,
  CardStatusType.CardStatusTypeInactive: 0,
  CardStatusType.CardStatusTypePendingActivation: 2,
  CardStatusType.CardStatusTypeActive: 3,
  CardStatusType.CardStatusTypeSuspended: 4,
  CardStatusType.CardStatusTypeTerminated: 5,
  CardStatusType.CardStatusTypePendingIssue: 6,
};

SSWalletTransferModelVO _$SSWalletTransferModelVOFromJson(
        Map<String, dynamic> json) =>
    SSWalletTransferModelVO(
      totalP2PCount: json['totalP2PCount'] as int?,
      totalVerifiedP2PCount: json['totalVerifiedP2PCount'] as int?,
      beneficiaryRequestID: json['beneficiaryRequestID'] as String?,
      selectedWalletCard: json['selectedWalletCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['selectedWalletCard'] as Map<String, dynamic>),
      p2pList: (json['p2pList'] as List<dynamic>?)
          ?.map((e) =>
              SSWalletTransferDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventList: (json['eventList'] as List<dynamic>?)
          ?.map((e) =>
              SSWalletTransferEventDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSWalletTransferModelVOToJson(
        SSWalletTransferModelVO instance) =>
    <String, dynamic>{
      'totalP2PCount': instance.totalP2PCount,
      'totalVerifiedP2PCount': instance.totalVerifiedP2PCount,
      'beneficiaryRequestID': instance.beneficiaryRequestID,
      'selectedWalletCard': instance.selectedWalletCard?.toJson(),
      'p2pList': instance.p2pList?.map((e) => e.toJson()).toList(),
      'eventList': instance.eventList?.map((e) => e.toJson()).toList(),
    };

SSWalletTransferEventDetailVO _$SSWalletTransferEventDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSWalletTransferEventDetailVO(
      eventId: json['eventId'] as String?,
      eventName: json['eventName'] as String?,
      eventAmount: json['eventAmount'] as String?,
      p2pList: (json['p2pList'] as List<dynamic>?)
          ?.map((e) =>
              SSWalletTransferDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSWalletTransferEventDetailVOToJson(
        SSWalletTransferEventDetailVO instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'eventName': instance.eventName,
      'eventAmount': instance.eventAmount,
      'p2pList': instance.p2pList?.map((e) => e.toJson()).toList(),
    };
