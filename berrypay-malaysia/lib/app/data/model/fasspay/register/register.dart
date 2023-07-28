import 'package:json_annotation/json_annotation.dart';
part 'register.g.dart';

@JsonSerializable()
class RegisterRequest {
  RegisterRequest({
    required this.mobileNumber,
    required this.mobileNumberCountryCode,
  });

  String mobileNumber;
  String mobileNumberCountryCode;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
