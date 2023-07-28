// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Requestp2p _$Requestp2pFromJson(Map<String, dynamic> json) => Requestp2p(
      walletId: json['walletId'] as String?,
      cardId: json['cardId'] as String?,
      contactDetail: (json['contactDetail'] as List<dynamic>?)
          ?.map((e) => ContactDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Requestp2pToJson(Requestp2p instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'cardId': instance.cardId,
      'contactDetail': instance.contactDetail?.map((e) => e.toJson()).toList(),
    };

ContactDetail _$ContactDetailFromJson(Map<String, dynamic> json) =>
    ContactDetail(
      amount: json['amount'] as String?,
      walletId: json['walletId'] as String?,
    );

Map<String, dynamic> _$ContactDetailToJson(ContactDetail instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'walletId': instance.walletId,
    };
