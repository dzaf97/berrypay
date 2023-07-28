// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferP2PRequest _$TransferP2PRequestFromJson(Map<String, dynamic> json) =>
    TransferP2PRequest(
      fasspayBaseEnum:
          $enumDecode(_$FasspayBaseEnumEnumMap, json['fasspayBaseEnum']),
      senderWalletId: json['senderWalletId'] as String,
      senderCardId: json['senderCardId'] as String,
      receiverWalletId: json['receiverWalletId'] as String,
      amount: json['amount'] as String,
      transferDescription: json['transferDescription'] as String?,
      ssWalletTransferRequestDetailVO:
          json['ssWalletTransferRequestDetailVO'] == null
              ? null
              : SSWalletTransferRequestDetailVO.fromJson(
                  json['ssWalletTransferRequestDetailVO']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransferP2PRequestToJson(TransferP2PRequest instance) =>
    <String, dynamic>{
      'fasspayBaseEnum': _$FasspayBaseEnumEnumMap[instance.fasspayBaseEnum]!,
      'senderWalletId': instance.senderWalletId,
      'senderCardId': instance.senderCardId,
      'receiverWalletId': instance.receiverWalletId,
      'amount': instance.amount,
      'transferDescription': instance.transferDescription,
      'ssWalletTransferRequestDetailVO':
          instance.ssWalletTransferRequestDetailVO?.toJson(),
    };

const _$FasspayBaseEnumEnumMap = {
  FasspayBaseEnum.Default: 'Default',
  FasspayBaseEnum.Otp: 'Otp',
  FasspayBaseEnum.Withdrawal: 'Withdrawal',
  FasspayBaseEnum.TopupCancel: 'TopupCancel',
  FasspayBaseEnum.TransferP2P: 'TransferP2P',
  FasspayBaseEnum.RequestP2P: 'RequestP2P',
};

SSTransactionHistoryModelVO _$SSTransactionHistoryModelVOFromJson(
        Map<String, dynamic> json) =>
    SSTransactionHistoryModelVO(
      itemsPerPage: json['itemsPerPage'] as int?,
      pagingNo: json['pagingNo'] as int?,
      searchWalletCardId: json['searchWalletCardId'] as String?,
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
      transactionCardList: (json['transactionCardList'] as List<dynamic>?)
          ?.map((e) => SSTransactionCardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSTransactionHistoryModelVOToJson(
        SSTransactionHistoryModelVO instance) =>
    <String, dynamic>{
      'itemsPerPage': instance.itemsPerPage,
      'pagingNo': instance.pagingNo,
      'searchWalletCardId': instance.searchWalletCardId,
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
      'transactionCardList': instance.transactionCardList,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.Unknown: 0,
  TransactionType.Spending: 10,
  TransactionType.TopUp: 20,
  TransactionType.Withdrawal: 30,
  TransactionType.WithdrawalCharges: 31,
  TransactionType.FundTransfer: 40,
  TransactionType.Cashback: 80,
  TransactionType.Refund: 90,
  TransactionType.AuthCapture: -1,
};

SSTransactionCardVO _$SSTransactionCardVOFromJson(Map<String, dynamic> json) =>
    SSTransactionCardVO(
      json['walletCardId'] as String?,
      json['isLoadMoreAvailable'] as bool?,
      (json['transactionList'] as List<dynamic>?)
          ?.map((e) => SSTransactionVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSTransactionCardVOToJson(
        SSTransactionCardVO instance) =>
    <String, dynamic>{
      'walletCardId': instance.walletCardId,
      'isLoadMoreAvailable': instance.isLoadMoreAvailable,
      'transactionList': instance.transactionList,
    };

SSTransactionVO _$SSTransactionVOFromJson(Map<String, dynamic> json) =>
    SSTransactionVO(
      transactionStatus: $enumDecodeNullable(
          _$TransactionStatusTypeEnumMap, json['transactionStatus']),
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
      transactionId: json['transactionId'] as String?,
      transactionDateTime: json['transactionDateTime'] as String?,
      spendingDetail: json['spendingDetail'] == null
          ? null
          : SSSpendingDetailVO.fromJson(
              json['spendingDetail'] as Map<String, dynamic>),
      withdrawalDetail: json['withdrawalDetail'] == null
          ? null
          : SSWithdrawalDetailVO.fromJson(
              json['withdrawalDetail'] as Map<String, dynamic>),
      topUpDetail: json['topUpDetail'] == null
          ? null
          : SSTopUpDetailVO.fromJson(
              json['topUpDetail'] as Map<String, dynamic>),
      transferDetail: json['transferDetail'] == null
          ? null
          : SSTransferDetailVO.fromJson(
              json['transferDetail'] as Map<String, dynamic>),
      spendingPassthroughDetail: json['spendingPassthroughDetail'] == null
          ? null
          : SSSpendingPassthroughDetailVO.fromJson(
              json['spendingPassthroughDetail'] as Map<String, dynamic>),
      p2pDetail: json['p2pDetail'] == null
          ? null
          : SSWalletTransferDetailVO.fromJson(
              json['p2pDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SSTransactionVOToJson(SSTransactionVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transactionStatus',
      _$TransactionStatusTypeEnumMap[instance.transactionStatus]);
  writeNotNull(
      'transactionType', _$TransactionTypeEnumMap[instance.transactionType]);
  writeNotNull('transactionId', instance.transactionId);
  writeNotNull('transactionDateTime', instance.transactionDateTime);
  writeNotNull('spendingDetail', instance.spendingDetail);
  writeNotNull('withdrawalDetail', instance.withdrawalDetail);
  writeNotNull('topUpDetail', instance.topUpDetail);
  writeNotNull('transferDetail', instance.transferDetail);
  writeNotNull('spendingPassthroughDetail', instance.spendingPassthroughDetail);
  writeNotNull('p2pDetail', instance.p2pDetail);
  return val;
}

const _$TransactionStatusTypeEnumMap = {
  TransactionStatusType.Unknown: 0,
  TransactionStatusType.Approved: 100,
  TransactionStatusType.Processing: 101,
  TransactionStatusType.Declined: 102,
  TransactionStatusType.Settled: 104,
  TransactionStatusType.Cancelled: 105,
  TransactionStatusType.Open: 106,
  TransactionStatusType.Voided: 107,
  TransactionStatusType.Refunded: 113,
  TransactionStatusType.Authorized: -1,
};

SSSpendingDetailVO _$SSSpendingDetailVOFromJson(Map<String, dynamic> json) =>
    SSSpendingDetailVO(
      barcodeData: json['barcodeData'] as String?,
      merchantName: json['merchantName'] as String?,
      approvalCode: json['approvalCode'] as String?,
      mid: json['mid'] as String?,
      tid: json['tid'] as String?,
      productDesc: json['productDesc'] as String?,
      billPaymentDetail: json['billPaymentDetail'] == null
          ? null
          : SSBillPaymentDetailVO.fromJson(
              json['billPaymentDetail'] as Map<String, dynamic>),
    )
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType'])
      ..gatewayType =
          $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType'])
      ..amount = json['amount'] as String?
      ..amountAuthorized = json['amountAuthorized'] as String?
      ..currencyCode = json['currencyCode'] as String?
      ..foreignAmountAuthorized = json['foreignAmountAuthorized'] as String?
      ..foreignCurrencyCode = json['foreignCurrencyCode'] as String?
      ..processingFee = json['processingFee'] as String?;

Map<String, dynamic> _$SSSpendingDetailVOToJson(SSSpendingDetailVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$ChannelTypeEnumMap[instance.channelType]);
  writeNotNull('gatewayType', _$GatewayTypeEnumMap[instance.gatewayType]);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountAuthorized', instance.amountAuthorized);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('foreignAmountAuthorized', instance.foreignAmountAuthorized);
  writeNotNull('foreignCurrencyCode', instance.foreignCurrencyCode);
  writeNotNull('processingFee', instance.processingFee);
  writeNotNull('barcodeData', instance.barcodeData);
  writeNotNull('merchantName', instance.merchantName);
  writeNotNull('approvalCode', instance.approvalCode);
  writeNotNull('mid', instance.mid);
  writeNotNull('tid', instance.tid);
  writeNotNull('productDesc', instance.productDesc);
  writeNotNull('billPaymentDetail', instance.billPaymentDetail?.toJson());
  return val;
}

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

const _$GatewayTypeEnumMap = {
  GatewayType.Unknown: -1,
  GatewayType.IPay88: 0,
  GatewayType.TypeNapas: 1,
  GatewayType.VietinBank: 2,
};

SSWithdrawalDetailVO _$SSWithdrawalDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSWithdrawalDetailVO(
      bankId: json['bankId'] as int?,
      accountNo: json['accountNo'] as String?,
      accountName: json['accountName'] as String?,
      creditDebitCard: json['creditDebitCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['creditDebitCard'] as Map<String, dynamic>),
      identificationImage: json['identificationImage'] as String?,
      withdrawalCharges: json['withdrawalCharges'] as String?,
      withdrawalNetAmount: json['withdrawalNetAmount'] as String?,
      withdrawalMaxAmount: json['withdrawalMaxAmount'] as String?,
      bankName: json['bankName'] as String?,
      geoLocationInfo: json['geoLocationInfo'] == null
          ? null
          : SSGeoLocationInfoVO.fromJson(
              json['geoLocationInfo'] as Map<String, dynamic>),
    )
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType'])
      ..gatewayType =
          $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType'])
      ..amount = json['amount'] as String?
      ..amountAuthorized = json['amountAuthorized'] as String?
      ..currencyCode = json['currencyCode'] as String?
      ..foreignAmountAuthorized = json['foreignAmountAuthorized'] as String?
      ..foreignCurrencyCode = json['foreignCurrencyCode'] as String?
      ..processingFee = json['processingFee'] as String?;

Map<String, dynamic> _$SSWithdrawalDetailVOToJson(
    SSWithdrawalDetailVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$ChannelTypeEnumMap[instance.channelType]);
  writeNotNull('gatewayType', _$GatewayTypeEnumMap[instance.gatewayType]);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountAuthorized', instance.amountAuthorized);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('foreignAmountAuthorized', instance.foreignAmountAuthorized);
  writeNotNull('foreignCurrencyCode', instance.foreignCurrencyCode);
  writeNotNull('processingFee', instance.processingFee);
  writeNotNull('bankId', instance.bankId);
  writeNotNull('accountNo', instance.accountNo);
  writeNotNull('accountName', instance.accountName);
  writeNotNull('creditDebitCard', instance.creditDebitCard?.toJson());
  writeNotNull('identificationImage', instance.identificationImage);
  writeNotNull('withdrawalCharges', instance.withdrawalCharges);
  writeNotNull('withdrawalNetAmount', instance.withdrawalNetAmount);
  writeNotNull('withdrawalMaxAmount', instance.withdrawalMaxAmount);
  writeNotNull('bankName', instance.bankName);
  writeNotNull('geoLocationInfo', instance.geoLocationInfo?.toJson());
  return val;
}

SSGeoLocationInfoVO _$SSGeoLocationInfoVOFromJson(Map<String, dynamic> json) =>
    SSGeoLocationInfoVO(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      altitude: json['altitude'] as String?,
    );

Map<String, dynamic> _$SSGeoLocationInfoVOToJson(
        SSGeoLocationInfoVO instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
    };

SSTransactionDetailVO _$SSTransactionDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSTransactionDetailVO(
      channelType:
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType']),
      amount: json['amount'] as String?,
      amountAuthorized: json['amountAuthorized'] as String?,
      currencyCode: json['currencyCode'] as String?,
      foreignAmountAuthorized: json['foreignAmountAuthorized'] as String?,
      foreignCurrencyCode: json['foreignCurrencyCode'] as String?,
      processingFee: json['processingFee'] as String?,
    )..gatewayType =
        $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType']);

Map<String, dynamic> _$SSTransactionDetailVOToJson(
        SSTransactionDetailVO instance) =>
    <String, dynamic>{
      'channelType': _$ChannelTypeEnumMap[instance.channelType],
      'gatewayType': _$GatewayTypeEnumMap[instance.gatewayType],
      'amount': instance.amount,
      'amountAuthorized': instance.amountAuthorized,
      'currencyCode': instance.currencyCode,
      'foreignAmountAuthorized': instance.foreignAmountAuthorized,
      'foreignCurrencyCode': instance.foreignCurrencyCode,
      'processingFee': instance.processingFee,
    };

SSTopUpDetailVO _$SSTopUpDetailVOFromJson(Map<String, dynamic> json) =>
    SSTopUpDetailVO(
      topUpMethod:
          $enumDecodeNullable(_$TopUpMethodTypeEnumMap, json['topUpMethod']),
      cardType: $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']),
      creditDebitCard: json['creditDebitCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['creditDebitCard'] as Map<String, dynamic>),
    )
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType'])
      ..gatewayType =
          $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType'])
      ..amount = json['amount'] as String?
      ..amountAuthorized = json['amountAuthorized'] as String?
      ..currencyCode = json['currencyCode'] as String?
      ..foreignAmountAuthorized = json['foreignAmountAuthorized'] as String?
      ..foreignCurrencyCode = json['foreignCurrencyCode'] as String?
      ..processingFee = json['processingFee'] as String?;

Map<String, dynamic> _$SSTopUpDetailVOToJson(SSTopUpDetailVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$ChannelTypeEnumMap[instance.channelType]);
  writeNotNull('gatewayType', _$GatewayTypeEnumMap[instance.gatewayType]);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountAuthorized', instance.amountAuthorized);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('foreignAmountAuthorized', instance.foreignAmountAuthorized);
  writeNotNull('foreignCurrencyCode', instance.foreignCurrencyCode);
  writeNotNull('processingFee', instance.processingFee);
  writeNotNull('topUpMethod', _$TopUpMethodTypeEnumMap[instance.topUpMethod]);
  writeNotNull('cardType', _$CardTypeEnumMap[instance.cardType]);
  writeNotNull('creditDebitCard', instance.creditDebitCard?.toJson());
  return val;
}

const _$TopUpMethodTypeEnumMap = {
  TopUpMethodType.TopUpMethodTypeUnknown: -1,
  TopUpMethodType.TopUpMethodTypeOnlineBanking: 0,
  TopUpMethodType.TopUpMethodTypeVisa: 1,
  TopUpMethodType.TopUpMethodTypeMastercard: 2,
  TopUpMethodType.TopUpMethodTypeAmex: 3,
  TopUpMethodType.TopUpMethodTypeCreditDebitCard: 5,
  TopUpMethodType.TopUpMethodTypePayNow: 6,
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

SSTransferDetailVO _$SSTransferDetailVOFromJson(Map<String, dynamic> json) =>
    SSTransferDetailVO(
      transferName: json['transferName'] as String?,
      transferInputType: $enumDecodeNullable(
          _$TransferInputTypeEnumMap, json['transferInputType']),
    )
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType'])
      ..gatewayType =
          $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType'])
      ..amount = json['amount'] as String?
      ..amountAuthorized = json['amountAuthorized'] as String?
      ..currencyCode = json['currencyCode'] as String?
      ..foreignAmountAuthorized = json['foreignAmountAuthorized'] as String?
      ..foreignCurrencyCode = json['foreignCurrencyCode'] as String?
      ..processingFee = json['processingFee'] as String?;

Map<String, dynamic> _$SSTransferDetailVOToJson(SSTransferDetailVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$ChannelTypeEnumMap[instance.channelType]);
  writeNotNull('gatewayType', _$GatewayTypeEnumMap[instance.gatewayType]);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountAuthorized', instance.amountAuthorized);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('foreignAmountAuthorized', instance.foreignAmountAuthorized);
  writeNotNull('foreignCurrencyCode', instance.foreignCurrencyCode);
  writeNotNull('processingFee', instance.processingFee);
  writeNotNull('transferName', instance.transferName);
  writeNotNull('transferInputType',
      _$TransferInputTypeEnumMap[instance.transferInputType]);
  return val;
}

const _$TransferInputTypeEnumMap = {
  TransferInputType.TransferInputTypeUnknown: 0,
  TransferInputType.TransferInputTypeCredit: 1,
  TransferInputType.TransferInputTypeDebit: 2,
};

SSSpendingPassthroughDetailVO _$SSSpendingPassthroughDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSSpendingPassthroughDetailVO(
      merchantName: json['merchantName'] as String?,
      approvalCode: json['approvalCode'] as String?,
      mid: json['mid'] as String?,
      paymentGatewayChannelId: $enumDecodeNullable(
          _$SpendingPassthroughMethodTypeEnumMap,
          json['paymentGatewayChannelId']),
      cardType: $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']),
      creditDebitCard: json['creditDebitCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['creditDebitCard'] as Map<String, dynamic>),
      productDesc: json['productDesc'] as String?,
      billPaymentDetail: json['billPaymentDetail'] == null
          ? null
          : SSBillPaymentDetailVO.fromJson(
              json['billPaymentDetail'] as Map<String, dynamic>),
    )
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType'])
      ..gatewayType =
          $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType'])
      ..amount = json['amount'] as String?
      ..amountAuthorized = json['amountAuthorized'] as String?
      ..currencyCode = json['currencyCode'] as String?
      ..foreignAmountAuthorized = json['foreignAmountAuthorized'] as String?
      ..foreignCurrencyCode = json['foreignCurrencyCode'] as String?
      ..processingFee = json['processingFee'] as String?;

Map<String, dynamic> _$SSSpendingPassthroughDetailVOToJson(
    SSSpendingPassthroughDetailVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$ChannelTypeEnumMap[instance.channelType]);
  writeNotNull('gatewayType', _$GatewayTypeEnumMap[instance.gatewayType]);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountAuthorized', instance.amountAuthorized);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('foreignAmountAuthorized', instance.foreignAmountAuthorized);
  writeNotNull('foreignCurrencyCode', instance.foreignCurrencyCode);
  writeNotNull('processingFee', instance.processingFee);
  writeNotNull('merchantName', instance.merchantName);
  writeNotNull('approvalCode', instance.approvalCode);
  writeNotNull('mid', instance.mid);
  writeNotNull('paymentGatewayChannelId',
      _$SpendingPassthroughMethodTypeEnumMap[instance.paymentGatewayChannelId]);
  writeNotNull('cardType', _$CardTypeEnumMap[instance.cardType]);
  writeNotNull('creditDebitCard', instance.creditDebitCard?.toJson());
  writeNotNull('productDesc', instance.productDesc);
  writeNotNull('billPaymentDetail', instance.billPaymentDetail?.toJson());
  return val;
}

const _$SpendingPassthroughMethodTypeEnumMap = {
  SpendingPassthroughMethodType.SpendingPassthroughMethodTypeUnknown: -1,
  SpendingPassthroughMethodType.SpendingPassthroughMethodTypeOnlineBanking: 0,
  SpendingPassthroughMethodType.SpendingPassthroughMethodTypeVisa: 1,
  SpendingPassthroughMethodType.SpendingPassthroughMethodTypeMastercard: 2,
  SpendingPassthroughMethodType.SpendingPassthroughMethodTypeAmex: 3,
  SpendingPassthroughMethodType.SpendingPassthroughMethodTypeCreditDebitCard: 4,
};

SSWalletTransferDetailVO _$SSWalletTransferDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSWalletTransferDetailVO(
      isAddContacts: json['isAddContacts'] as bool?,
      isChangedAmount: json['isChangedAmount'] as bool?,
      isFixAmount: json['isFixAmount'] as bool?,
      transferDesc: json['transferDesc'] as String?,
      userProfile: json['userProfile'] == null
          ? null
          : SSUserProfileVO.fromJson(
              json['userProfile'] as Map<String, dynamic>),
      transferRequestDetail: json['transferRequestDetail'] == null
          ? null
          : SSWalletTransferRequestDetailVO.fromJson(
              json['transferRequestDetail'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : SSStatus.fromJson(json['status'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as String?,
    )
      ..channelType =
          $enumDecodeNullable(_$ChannelTypeEnumMap, json['channelType'])
      ..gatewayType =
          $enumDecodeNullable(_$GatewayTypeEnumMap, json['gatewayType'])
      ..amount = json['amount'] as String?
      ..amountAuthorized = json['amountAuthorized'] as String?
      ..currencyCode = json['currencyCode'] as String?
      ..foreignAmountAuthorized = json['foreignAmountAuthorized'] as String?
      ..foreignCurrencyCode = json['foreignCurrencyCode'] as String?
      ..processingFee = json['processingFee'] as String?;

Map<String, dynamic> _$SSWalletTransferDetailVOToJson(
    SSWalletTransferDetailVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelType', _$ChannelTypeEnumMap[instance.channelType]);
  writeNotNull('gatewayType', _$GatewayTypeEnumMap[instance.gatewayType]);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountAuthorized', instance.amountAuthorized);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('foreignAmountAuthorized', instance.foreignAmountAuthorized);
  writeNotNull('foreignCurrencyCode', instance.foreignCurrencyCode);
  writeNotNull('processingFee', instance.processingFee);
  writeNotNull('isAddContacts', instance.isAddContacts);
  writeNotNull('isChangedAmount', instance.isChangedAmount);
  writeNotNull('isFixAmount', instance.isFixAmount);
  writeNotNull('transferDesc', instance.transferDesc);
  writeNotNull('userProfile', instance.userProfile?.toJson());
  writeNotNull(
      'transferRequestDetail', instance.transferRequestDetail?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('transactionId', instance.transactionId);
  return val;
}

SSBillPaymentDetailVO _$SSBillPaymentDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSBillPaymentDetailVO(
      json['billerName'] as String?,
      json['productCode'] as String?,
      json['requiredAmount'] as String?,
      $enumDecodeNullable(
          _$BillerPlatformTypeEnumMap, json['billerPlatformType']),
      $enumDecodeNullable(
          _$BillPaymentAmountTypeEnumMap, json['billAmountType']),
      $enumDecodeNullable(
          _$BillPaymentTransactionTypeEnumMap, json['billTransactionType']),
      json['billPaymentRemark'] as String?,
      json['billerSubCategory'] as String?,
      json['isFavouriteBiller'] as bool?,
      (json['billPaymentInputFieldList'] as List<dynamic>?)
          ?.map((e) =>
              SSBillPaymentInputFieldVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSBillPaymentDetailVOToJson(
        SSBillPaymentDetailVO instance) =>
    <String, dynamic>{
      'billerName': instance.billerName,
      'productCode': instance.productCode,
      'requiredAmount': instance.requiredAmount,
      'billerPlatformType':
          _$BillerPlatformTypeEnumMap[instance.billerPlatformType],
      'billAmountType': _$BillPaymentAmountTypeEnumMap[instance.billAmountType],
      'billTransactionType':
          _$BillPaymentTransactionTypeEnumMap[instance.billTransactionType],
      'billPaymentRemark': instance.billPaymentRemark,
      'billerSubCategory': instance.billerSubCategory,
      'isFavouriteBiller': instance.isFavouriteBiller,
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

SSWalletCardVO _$SSWalletCardVOFromJson(Map<String, dynamic> json) =>
    SSWalletCardVO(
      json['cardId'] as String?,
      json['cardName'] as String?,
      json['cardNumber'] as String?,
      json['cardBalance'] as String?,
      $enumDecodeNullable(_$CardAccountTypeEnumMap, json['cardAccountType']),
      json['cardImage'] as String?,
      json['isDefaultCard'] as bool?,
      json['profileId'] as String?,
      $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']),
      json['lastEditedDateTime'] as int?,
      $enumDecodeNullable(_$CardStatusTypeEnumMap, json['cardStatusType']),
      json['issuingBankName'] as String?,
      json['expiryDate'] as String?,
      json['cardSerialNo'] as String?,
      json['isSharedBalance'] as bool?,
      json['creditLimit'] as String?,
      json['issueCardId'] as int?,
    );

Map<String, dynamic> _$SSWalletCardVOToJson(SSWalletCardVO instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardName': instance.cardName,
      'cardNumber': instance.cardNumber,
      'cardBalance': instance.cardBalance,
      'cardAccountType': _$CardAccountTypeEnumMap[instance.cardAccountType],
      'cardImage': instance.cardImage,
      'isDefaultCard': instance.isDefaultCard,
      'profileId': instance.profileId,
      'cardType': _$CardTypeEnumMap[instance.cardType],
      'lastEditedDateTime': instance.lastEditedDateTime,
      'cardStatusType': _$CardStatusTypeEnumMap[instance.cardStatusType],
      'issuingBankName': instance.issuingBankName,
      'expiryDate': instance.expiryDate,
      'cardSerialNo': instance.cardSerialNo,
      'isSharedBalance': instance.isSharedBalance,
      'creditLimit': instance.creditLimit,
      'issueCardId': instance.issueCardId,
    };

const _$CardAccountTypeEnumMap = {
  CardAccountType.Unknown: -1,
  CardAccountType.EMoney: 0,
  CardAccountType.CreditDebit: 1,
  CardAccountType.CASA: 2,
  CardAccountType.Frozen: -2,
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

SSWalletTransferRequestDetailVO _$SSWalletTransferRequestDetailVOFromJson(
        Map<String, dynamic> json) =>
    SSWalletTransferRequestDetailVO(
      json['transferRequestId'] as String?,
      $enumDecodeNullable(
          _$TransferRequestStatusEnumMap, json['transferRequestStatus']),
      $enumDecodeNullable(
          _$TransferRequestTypeEnumMap, json['transferRequestType']),
      json['transferRequestDateTime'] as String?,
      $enumDecodeNullable(
          _$TransferRequestTypeEnumMap, json['transferRequestTypeId']),
      $enumDecodeNullable(
          _$TransferRequestStatusEnumMap, json['transferRequestStatusId']),
    );

Map<String, dynamic> _$SSWalletTransferRequestDetailVOToJson(
        SSWalletTransferRequestDetailVO instance) =>
    <String, dynamic>{
      'transferRequestDateTime': instance.transferRequestDateTime,
      'transferRequestId': instance.transferRequestId,
      'transferRequestStatus':
          _$TransferRequestStatusEnumMap[instance.transferRequestStatus],
      'transferRequestStatusId':
          _$TransferRequestStatusEnumMap[instance.transferRequestStatusId],
      'transferRequestTypeId':
          _$TransferRequestTypeEnumMap[instance.transferRequestTypeId],
      'transferRequestType':
          _$TransferRequestTypeEnumMap[instance.transferRequestType],
    };

const _$TransferRequestStatusEnumMap = {
  TransferRequestStatus.Pending: 100,
  TransferRequestStatus.Approve: 101,
  TransferRequestStatus.Decline: 102,
  TransferRequestStatus.Void: -1,
};

const _$TransferRequestTypeEnumMap = {
  TransferRequestType.TransferRequestTypeUnknown: -1,
  TransferRequestType.TransferRequestTypePayer: 0,
  TransferRequestType.TransferRequestTypePayee: 1,
  TransferRequestType.TransferRequestTypeSplitBill: 2,
};

SSBillPaymentInputFieldVO _$SSBillPaymentInputFieldVOFromJson(
        Map<String, dynamic> json) =>
    SSBillPaymentInputFieldVO(
      json['billPaymentFieldName'] as String?,
      json['billPaymentFieldValue'] as String?,
      json['billPaymentFieldLength'] as int?,
      $enumDecodeNullable(_$BillPaymentFieldInputTypeEnumMap,
          json['billPaymentFieldInputType']),
    );

Map<String, dynamic> _$SSBillPaymentInputFieldVOToJson(
        SSBillPaymentInputFieldVO instance) =>
    <String, dynamic>{
      'billPaymentFieldName': instance.billPaymentFieldName,
      'billPaymentFieldValue': instance.billPaymentFieldValue,
      'billPaymentFieldLength': instance.billPaymentFieldLength,
      'billPaymentFieldInputType': _$BillPaymentFieldInputTypeEnumMap[
          instance.billPaymentFieldInputType],
    };

const _$BillPaymentFieldInputTypeEnumMap = {
  BillPaymentFieldInputType.BillPaymentFieldInputTypeUnknown: -1,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeAlphaNumeric: 0,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeNumeric: 1,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeMobileNumeric: 2,
  BillPaymentFieldInputType.BillPaymentFieldInputTypeNRIC: 3,
};
