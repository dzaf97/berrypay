import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cdcvm_model.g.dart';

@JsonSerializable()
class CdcvmValidationRequest {
  final String walletId;
  final CdcvmTransactionType cdcvmTransactionType;

  CdcvmValidationRequest(this.walletId, this.cdcvmTransactionType);

  factory CdcvmValidationRequest.fromJson(Map<String, dynamic> json) => _$CdcvmValidationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CdcvmValidationRequestToJson(this);
}
