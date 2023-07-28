// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSWithdrawalModelVO _$SSWithdrawalModelVOFromJson(Map<String, dynamic> json) =>
    SSWithdrawalModelVO(
      selectedWalletCard: json['selectedWalletCard'] == null
          ? null
          : SSWalletCardVO.fromJson(
              json['selectedWalletCard'] as Map<String, dynamic>),
      withdrawalDetail: json['withdrawalDetail'] == null
          ? null
          : SSWithdrawalDetailVO.fromJson(
              json['withdrawalDetail'] as Map<String, dynamic>),
      transactionRequestId: json['transactionRequestId'] as String?,
      transactionId: json['transactionId'] as String?,
      status: json['status'] == null
          ? null
          : SSStatusVO.fromJson(json['status'] as Map<String, dynamic>),
      otp: json['otp'] == null
          ? null
          : SSOtpVO.fromJson(json['otp'] as Map<String, dynamic>),
      withdrawalBankList: (json['withdrawalBankList'] as List<dynamic>?)
          ?.map((e) => SSParameterVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSWithdrawalModelVOToJson(
        SSWithdrawalModelVO instance) =>
    <String, dynamic>{
      'selectedWalletCard': instance.selectedWalletCard?.toJson(),
      'withdrawalDetail': instance.withdrawalDetail?.toJson(),
      'transactionRequestId': instance.transactionRequestId,
      'transactionId': instance.transactionId,
      'status': instance.status?.toJson(),
      'otp': instance.otp?.toJson(),
      'withdrawalBankList':
          instance.withdrawalBankList?.map((e) => e.toJson()).toList(),
    };
