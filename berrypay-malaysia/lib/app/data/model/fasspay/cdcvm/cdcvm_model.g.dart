// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cdcvm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CdcvmValidationRequest _$CdcvmValidationRequestFromJson(
        Map<String, dynamic> json) =>
    CdcvmValidationRequest(
      json['walletId'] as String,
      $enumDecode(_$CdcvmTransactionTypeEnumMap, json['cdcvmTransactionType']),
    );

Map<String, dynamic> _$CdcvmValidationRequestToJson(
        CdcvmValidationRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'cdcvmTransactionType':
          _$CdcvmTransactionTypeEnumMap[instance.cdcvmTransactionType]!,
    };

const _$CdcvmTransactionTypeEnumMap = {
  CdcvmTransactionType.Unknown: 'Unknown',
  CdcvmTransactionType.Spending: 'Spending',
  CdcvmTransactionType.Withdrawal: 'Withdrawal',
  CdcvmTransactionType.ChangeMobileNo: 'ChangeMobileNo',
  CdcvmTransactionType.InAppPurchase: 'InAppPurchase',
  CdcvmTransactionType.Misc: 'Misc',
  CdcvmTransactionType.Detach: 'Detach',
  CdcvmTransactionType.LinkSupCard: 'LinkSupCard',
  CdcvmTransactionType.UnlinkSupCard: 'UnlinkSupCard',
  CdcvmTransactionType.ConfigureSupCard: 'ConfigureSupCard',
  CdcvmTransactionType.P2PSendMoney: 'P2PSendMoney',
  CdcvmTransactionType.P2PRequestMoney: 'P2PRequestMoney',
  CdcvmTransactionType.QRRequest: 'QRRequest',
};
