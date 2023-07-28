import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'topup.g.dart';

@JsonSerializable()
class TopUpCheckStatusRequest {
  String? walletId;
  String? cardId;
  String? profileId;
  String? amount;
  String? topUpMethod;
  String? creditDebitCard;

  TopUpCheckStatusRequest({
    this.walletId,
    this.cardId,
    this.profileId,
    this.amount,
    this.topUpMethod,
    this.creditDebitCard,
  });

  factory TopUpCheckStatusRequest.fromJson(Map<String, dynamic> json) => _$TopUpCheckStatusRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TopUpCheckStatusRequestToJson(this);
}

@JsonSerializable()
class TopUpRequest {
  String? walletId;
  TopUpMethodType? topUpMethodType;
  String? cardId;
  String? amount;
  String? profileId;

  TopUpRequest({
    this.walletId,
    this.topUpMethodType,
    this.cardId,
    this.amount,
    this.profileId,
  });

  factory TopUpRequest.fromJson(Map<String, dynamic> json) => _$TopUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TopUpRequestToJson(this);
}

@JsonSerializable()
class SSTopupModelVO {
  final SSWalletCardVO? selectedWalletCard;
  final SSTopUpDetailVO? topUpDetail;
  final String? transactionRequestId;
  final bool? isAsyncCheck;
  final String? gatewayRequestUrl;
  final String? gatewayBaseUrl;
  final String? transactionId;
  final SSStatusVO? status;
  final List<SSParameterVO>? topUpMethodList;
  final List<SSWalletCardVO>? topUpFavouriteCardList;
  final String? maxTopUpAmount;
  final String? minTopUpAmount;
  final String? payNowQR;
  final bool? isOtpValidationRequied;
  final String? topUpMethod;
  final String? amount;

  const SSTopupModelVO({
    this.amount,
    this.selectedWalletCard,
    this.topUpDetail,
    this.transactionRequestId,
    this.isAsyncCheck,
    this.gatewayRequestUrl,
    this.gatewayBaseUrl,
    this.transactionId,
    this.status,
    this.topUpMethodList,
    this.topUpFavouriteCardList,
    this.maxTopUpAmount,
    this.minTopUpAmount,
    this.payNowQR,
    this.isOtpValidationRequied,
    this.topUpMethod,
  });

  factory SSTopupModelVO.fromJson(Map<String, dynamic> json) => _$SSTopupModelVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSTopupModelVOToJson(this);
}

@JsonSerializable()
class SSParameterVO {
  final int? paramId;
  final String? paramName;
  final String? paramValue;

  const SSParameterVO({
    this.paramId,
    this.paramName,
    this.paramValue,
  });

  factory SSParameterVO.fromJson(Map<String, dynamic> json) => _$SSParameterVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSParameterVOToJson(this);
}

@JsonSerializable()
class SSStatusVO {
  final int? code;
  final String? message;
  final String? reason;

  const SSStatusVO({
    this.code,
    this.message,
    this.reason,
  });

  factory SSStatusVO.fromJson(Map<String, dynamic> json) => _$SSStatusVOFromJson(json);
  Map<String, dynamic> toJson() => _$SSStatusVOToJson(this);
}
