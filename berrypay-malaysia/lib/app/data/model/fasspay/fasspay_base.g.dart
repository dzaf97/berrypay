// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasspay_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FasspayBase _$FasspayBaseFromJson(Map<String, dynamic> json) => FasspayBase(
      isSuccess: json['isSuccess'] as bool,
      payload: json['payload'] as String?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
      fasspayBaseEnum: $enumDecodeNullable(
              _$FasspayBaseEnumEnumMap, json['fasspayBaseEnum']) ??
          FasspayBaseEnum.Default,
    );

Map<String, dynamic> _$FasspayBaseToJson(FasspayBase instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'payload': instance.payload,
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
      'fasspayBaseEnum': _$FasspayBaseEnumEnumMap[instance.fasspayBaseEnum]!,
    };

const _$FasspayBaseEnumEnumMap = {
  FasspayBaseEnum.Default: 'Default',
  FasspayBaseEnum.Otp: 'Otp',
  FasspayBaseEnum.Withdrawal: 'Withdrawal',
  FasspayBaseEnum.TopupCancel: 'TopupCancel',
  FasspayBaseEnum.TransferP2P: 'TransferP2P',
  FasspayBaseEnum.RequestP2P: 'RequestP2P',
};
