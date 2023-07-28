import 'dart:io';
import 'dart:math';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/bpg/otp.dart';
import 'package:berrypay_global_x/app/data/repositories/otp_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ForgotPasswordMyController extends GetxController {
  final OtpRepo otpRepo;
  final ProfileRepo profileRepo;
  ForgotPasswordMyController(this.otpRepo, this.profileRepo);

  TextEditingController mobileNo = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? deviceModel;
  RxBool isLoading = false.obs;

  checkPhoneNo() async {
    isLoading(true);
    var response = await profileRepo.getOnboardingDetails(mobileNo.text);

    if (verifyResponse(response)) {
      logger('failed to fetch');
      isLoading(false);
      // AppSnackbar.errorSnackbar(title: LocaleKeys.not_registered.tr);
      AppSnackbar.errorSnackbar(title: LocaleKeys.forgot_pass_page_otp_sent.tr);

      DataRequestOtp dataRequestOtp = DataRequestOtp(
          requestorRef: const Uuid().v1(),
          otpId: '30c67651e858cc230032',
          challengeCode: generateRandomString(4));

      logger(dataRequestOtp.challengeCode);

      Get.toNamed(Routes.OTP, arguments: {
        "route": Routes.FORGOT_PASSWORD_FORM,
        "otp": Otp.forgotPassword,
        "dataRequestOtp": dataRequestOtp,
        "deviceId": deviceModel,
        "otpPacNo": dataRequestOtp.challengeCode,
        "phoneNo": mobileNo.text
      });

      return;
    }
    requestOtp();
    isLoading(false);
  }

  String generateRandomString(int length) {
    const String alphabet =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(alphabet.length);
      result += alphabet[randomIndex];
    }

    return result;
  }

  requestOtp() async {
    isLoading(true);
    // Get device model
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
      logger('Running on $deviceModel'); // e.g. "Moto G (4)"
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceModel = iosInfo.utsname.machine;
    }
    // Generate UUID for reference no
    var uuid = const Uuid();

    uuid.v1();
    logger(uuid.v1());

    RequestOtp requestOtp = RequestOtp(
        deviceId: deviceModel,
        reference: uuid.v1(),
        prefix: '60',
        number: mobileNo.text);

    var response = await otpRepo.requestOtp(requestOtp);
    logger(response);

    if (verifyResponse(response)) {
      isLoading(false);
      response as AppError;
      AppSnackbar.errorSnackbar(title: response.message);
      return;
    }

    response as RequestOtpResponse;
    isLoading(false);

    DataRequestOtp dataRequestOtp = response.data!;

    AppSnackbar.successSnackbar(title: LocaleKeys.send_otp_number.tr);

    Get.toNamed(Routes.OTP, arguments: {
      "route": Routes.FORGOT_PASSWORD_FORM,
      "otp": Otp.nexmo,
      "dataRequestOtp": dataRequestOtp,
      "deviceId": deviceModel,
      "otpPacNo": dataRequestOtp.challengeCode,
      "phoneNo": mobileNo.text
    });
  }
}
