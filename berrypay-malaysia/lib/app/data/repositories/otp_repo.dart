import 'package:berrypay_global_x/app/data/model/bpg/otp.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';
import 'package:get/get.dart';

class OtpRepo {
  final FasspayProvider _fasspayProvider = FasspayProvider();
  final BpgMyProvider _bpgMyProvider = Get.find<BpgMyProvider>();

  otpValidation(SSOtpModelVO request) =>
      _fasspayProvider.performOTPValidation(request);
  otpResend(SSOtpModelVO request) => _fasspayProvider.performOtpResend(request);

  requestOtp(RequestOtp requestOtp) => _bpgMyProvider.requestOtp(requestOtp);

  validateOtp(ValidateOtpRequest validateOtpRequest) =>
      _bpgMyProvider.validateOtp(validateOtpRequest);
}
