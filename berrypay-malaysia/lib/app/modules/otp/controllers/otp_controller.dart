import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/notification.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/secure_storage.dart';
import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/otp.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/otp_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OtpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Dependency Injection
  final OtpRepo otpRepo;
  final ProfileRepo profileRepo;
  OtpController(this.otpRepo, this.profileRepo);

  // UI Variable
  Otp? otpType;
  SSOtpModelVO? ssOtpModelVO;
  RxString? otpPacNo = "".obs;
  AnimationController? controller;
  String? timerString;
  Duration? duration;
  TextEditingController otpCode = TextEditingController();
  final focusNode = FocusNode();
  RxBool isLoading = false.obs;
  DataRequestOtp? dataRequestOtp;
  String? deviceModel;
  String? routes;
  DataOnboarding? data;
  LoginRequest? credentials;
  Login? loginData;

  final pinController = TextEditingController();
  final SecureStorage secureStorage = SecureStorage();

  @override
  void onInit() {
    super.onInit();
    routes = Get.arguments["route"] ?? '';
    otpType = Get.arguments["otp"];
    ssOtpModelVO = Get.arguments['ssOtpModelVO'];
    otpPacNo?.value = Get.arguments["otpPacNo"] ?? "";
    dataRequestOtp = Get.arguments["dataRequestOtp"];
    deviceModel = Get.arguments['deviceId'];
    data = Get.arguments['dataOnboarding'];
    credentials = Get.arguments?['credentials'];
    loginData = Get.arguments?['loginData'];

    logger('otpPacNo $otpPacNo');

    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 5),
    );

    timer();
  }

  otpAction(String action) {
    switch (otpType!) {
      case Otp.fasspay:
        handleFasspay(action);
        break;
      case Otp.nexmo:
        handleNexmo(action);
        break;

      case Otp.forgotPassword:
        handleForgotPassword(action);
        break;
    }
  }

  handleNexmo(String action) {
    switch (action) {
      case "verify":
        validateOtp();
        break;

      case "resend":
        requestOtp();
        break;
    }
  }

  handleFasspay(String action) async {
    logger(Get.previousRoute);
    // return;
    switch (action) {
      case "verify":
        isLoading(true);

        String walletId = Get.arguments["walletId"] ?? '';
        String route = Get.arguments["route"];
        ssOtpModelVO?.otp!.otpValue = otpCode.text;
        FasspayBase response = await otpRepo.otpValidation(ssOtpModelVO!);
        isLoading(false);

        logger('response: ${jsonEncode(response)}');
        if (!response.isSuccess) {
          logger('masuk otp salah');
          logger('response 1: ${jsonEncode(response)}');
          isLoading(false);
          AppSnackbar.errorSnackbar(title: response.errorMessage!);
          return;
        }

        SSOtpModelVO responseOtp =
            SSOtpModelVO.fromJson(jsonDecode(response.payload!));

        if (responseOtp.isCDCVMSetupRequired!) {
          isLoading(true);
          await profileRepo.setupCdcvmPin(walletId);
          isLoading(false);
        }

        // On forgot pin, reset cdcvm pin
        if (Get.previousRoute == "/malaysia/layout") {
          isLoading(true);
          FasspayBase fpResponse = await profileRepo.resetCdcvmPIN(walletId);
          isLoading(false);
          if (!fpResponse.isSuccess) {
            AppSnackbar.errorSnackbar(title: fpResponse.errorMessage!);
            return;
          }
        }

        if (route == Routes.LAYOUT_MY) {
          isLoading(true);
          FasspayBase fpResponse = await profileRepo.syncData(walletId);
          isLoading(false);
          await Get.find<StorageProvider>().setSSWalletCardModelVO(
              SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));
          await Get.find<StorageProvider>().setSSUserProfileVO(
              Get.find<StorageProvider>()
                  .getSSWalletCardModelVO()!
                  .userProfileVO!);
        }

        // If user is from Routes.LOGIN, set all login parameters and initialize notification
        if (Get.previousRoute == Routes.LOGIN ||
            Get.previousRoute == Routes.LOGIN_SECOND) {
          isLoading(true);
          logger('In Routes.OTP');
          await secureStorage
              .setRefreshToken(loginData?.token?.refreshToken ?? "");
          await Get.find<StorageProvider>().setCredentials(credentials!);
          await Get.find<StorageProvider>()
              .setProfileInfoResponse(loginData!.profile!);
          await Get.find<StorageProvider>()
              .setToken(loginData!.token!.accessToken!);
          await secureStorage.setUserName(credentials!.login);
          await secureStorage.setPassWord(credentials!.password);
          await secureStorage.setIslogin('true');
          await secureStorage.setName(loginData!.profile!.fullName);
        }

        if (Get.previousRoute == Routes.LOGIN) {
          await NotificationService().initializeLoggedInNotification();
        }

        Get.offAndToNamed(route, arguments: {
          "phone": Get.arguments['phone'] ?? '',
          "dataOnboarding": data
        });

        if (route == Routes.LAYOUT_MY) {
          AppSnackbar.successSnackbar(title: 'Success.');
        }
        // Get.offNamedUntil(route, ModalRoute.withName(route));

        break;
      case "resend":
        isLoading(true);
        // SSOtpModelVO ssOtpModelVo = Get.arguments["ssOtpModelVO"];
        FasspayBase response = await otpRepo.otpResend(ssOtpModelVO!);

        logger('otpPac:: $otpPacNo');

        if (response.isSuccess) {
          ssOtpModelVO = SSOtpModelVO.fromJson(jsonDecode(response.payload!));
          otpPacNo!.value = ssOtpModelVO!.otp!.otpPacNo!;
          isLoading(false);
          AppSnackbar.successSnackbar(
              title: 'OTP successfully resend to your number');
        } else {
          isLoading(false);
          AppSnackbar.errorSnackbar(title: 'Failed to resend OTP');
        }
        break;
    }
  }

  timer() {
    duration = controller!.duration! * controller!.value;
    timerString =
        '${duration!.inMinutes}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  validateOtp() async {
    isLoading(true);
    ValidateOtpRequest validateOtpRequest = ValidateOtpRequest(
        deviceId: deviceModel,
        reference: dataRequestOtp?.requestorRef,
        pin: otpCode.text,
        otpId: dataRequestOtp?.otpId,
        challengeCode: dataRequestOtp?.challengeCode);

    logger(jsonEncode(validateOtpRequest));
    var response = await otpRepo.validateOtp(validateOtpRequest);

    if (verifyResponse(response)) {
      isLoading(false);
      response as AppError;
      AppSnackbar.errorSnackbar(title: response.message);
      return;
    }
    response as ValidateOtpResponse;
    if (response.data?.result == false) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: 'Failed to validate Otp. Try again.');
      return;
    }

    isLoading(false);
    AppSnackbar.successSnackbar(title: 'Success validate OTP');

    if (routes == Routes.FORGOT_PASSWORD_FORM) {
      Get.toNamed(routes!, arguments: {"phoneNo": Get.arguments['phoneNo']});
    } else {
      // Get.to(() => const RegisterFormView());
    }
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
        number: Get.arguments['phoneNo']);

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

    DataRequestOtp data = response.data!;

    logger('data ${jsonEncode(dataRequestOtp)}');

    otpPacNo!.value = data.challengeCode!;
    dataRequestOtp!.requestorRef = data.requestorRef;
    dataRequestOtp?.otpId = data.otpId;
    dataRequestOtp?.challengeCode = data.challengeCode;

    logger('code :: ${dataRequestOtp?.challengeCode}');
    otpCode.text = '';

    AppSnackbar.successSnackbar(title: LocaleKeys.send_otp_number.tr);
  }

  handleForgotPassword(String action) {
    switch (action) {
      case "resend":
        isLoading(true);
        var otpPac = generateRandomString(4);
        otpPacNo!.value = otpPac;
        dataRequestOtp!.requestorRef = const Uuid().v1();
        dataRequestOtp?.otpId = '30c67651e858cc230032';
        dataRequestOtp?.challengeCode = otpPac;

        logger('code :: ${dataRequestOtp?.challengeCode}');
        otpCode.text = '';

        isLoading(false);

        AppSnackbar.successSnackbar(title: LocaleKeys.send_otp_number.tr);
        break;

      case "verify":
        validateOtp();
        break;

      default:
    }
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
}
