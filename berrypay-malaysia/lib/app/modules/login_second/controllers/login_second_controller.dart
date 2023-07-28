import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/secure_storage.dart';
import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/login/login_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSecondController extends GetxController {
  final AuthRepo authRepo;
  final ProfileRepo profileRepo;
  LoginSecondController(this.authRepo, this.profileRepo);

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool toggleEye = true.obs;
  RxString selectedCode = "+60".obs;
  RxString isLoggedIn = 'true'.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final SecureStorage secureStorage = SecureStorage();
  RxString isLogin = 'false'.obs;
  RxString? name = 'Member'.obs;
  RxBool isLoading = false.obs;
  bool isJailbreak = false;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isJailbreak = Get.arguments as bool;
    fetchSecureStorageData();
  }

  Future<void> fetchSecureStorageData() async {
    isLoggedIn.value = await secureStorage.getIslogin() ?? '';
    username.text = await secureStorage.getUserName() ?? '';
    name?.value = await secureStorage.getName() ?? '';

    logger('name:: $name');
  }

  void login(LoginRequest request) async {
    isLoading(true);
    var response = await authRepo.loginBpg(request);

    logger('res 1 $response');

    // Check if user credentials is valid or not
    if (verifyResponse(response)) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: 'Invalid username/password!');
      return;
    }
    response as Login;
    // log(jsonEncode(response));

    if (response.token?.error != null) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: 'Invalid username/password!');
      return;
    }
    logger(response.profile!.fullName);

    if (response.profile!.wallet
        .where((element) => element.bizSysId == "FASSPYMY")
        .isNotEmpty) {
      String walletId = response.profile!.wallet
          .where((element) => element.bizSysId == "FASSPYMY")
          .first
          .bizSysUID!;

      Get.find<StorageProvider>().setFasspayWalletId(walletId);
      logger("Wallet Id :: $walletId", name: "Login");
      FasspayBase fpResponse = await authRepo.initFp(walletId);
      fpResponse = await authRepo.loginFp(walletId);
      isLoading(false);

      if (!fpResponse.isSuccess) {
        AppSnackbar.errorSnackbar(title: fpResponse.errorMessage!);
        return;
      }
      SSLoginModelVO loginModelVO =
          SSLoginModelVO.fromJson(jsonDecode(fpResponse.payload!));

      logger("Fasspay Enum :: ${fpResponse.fasspayBaseEnum}", name: "Login");
      switch (fpResponse.fasspayBaseEnum) {
        case FasspayBaseEnum.Otp:
          isLoading(false);
          var ssOtpModelVO =
              SSOtpModelVO.fromJson(jsonDecode(fpResponse.payload!));
          logger("Otp Payload :: ${fpResponse.payload!}", name: "Login");
          Get.toNamed(
            Routes.OTP,
            arguments: {
              "otp": Otp.fasspay,
              "otpPacNo": ssOtpModelVO.otp!.otpPacNo,
              "ssOtpModelVO": ssOtpModelVO,
              "phoneNo": username.text,
              "route": Routes.LAYOUT_MY,
              "walletId": walletId,
              "credentials": request,
              "loginData": response,
            },
          );
          return;
        case FasspayBaseEnum.Default:
          if (loginModelVO.isCDCVMSetupRequired!) {
            fpResponse = await profileRepo.setupCdcvmPin(walletId);
          }
          fpResponse = await profileRepo.syncData(walletId);

          // Store all sync data in local storage and fasspay userProfile
          await Get.find<StorageProvider>().setSSWalletCardModelVO(
              SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));
          await Get.find<StorageProvider>().setSSUserProfileVO(
              Get.find<StorageProvider>()
                  .getSSWalletCardModelVO()!
                  .userProfileVO!);
          isLoading(false);
          break;
        default:
      }
    } else {
      await authRepo.initFp(null);
      isLoading(false);
    }

    await secureStorage.setRefreshToken(response.token?.refreshToken ?? "");
    await Get.find<StorageProvider>().setCredentials(request);
    await Get.find<StorageProvider>().setProfileInfoResponse(response.profile!);
    await Get.find<StorageProvider>().setToken(response.token!.accessToken!);
    await secureStorage.setUserName(username.text);
    await secureStorage.setPassWord(password.text);
    await secureStorage.setIslogin('true');
    await secureStorage.setName(response.profile!.fullName);


    // If login success, store the login credentials
    switch (selectedCode.value) {
      case "+60":
        Get.toNamed(Routes.LAYOUT_MY, arguments: selectedCode.value);
        break;
      // case "+971":
      //   // Get.put(HomeMyController());
      //   Get.toNamed(Layout.route, arguments: selectedCode.value);
      //   // Get.snackbar(
      //   //     "Country code not available!", "UAE feature will be coming soon!");
      //   break;
    }
  }
}
