import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'fasspay_base.g.dart';

@JsonSerializable()
class FasspayBase {
  FasspayBase({
    required this.isSuccess,
    this.payload,
    this.errorCode,
    this.errorMessage,
    this.fasspayBaseEnum = FasspayBaseEnum.Default,
  });

  bool isSuccess;
  String? payload;
  String? errorCode;
  String? errorMessage;
  FasspayBaseEnum fasspayBaseEnum;

  factory FasspayBase.fromJson(Map<String, dynamic> json) => _$FasspayBaseFromJson(json);

  Map<String, dynamic> toJson() => _$FasspayBaseToJson(this);
}
