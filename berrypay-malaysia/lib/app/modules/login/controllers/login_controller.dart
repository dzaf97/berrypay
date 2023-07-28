import 'dart:convert';
import 'dart:developer';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/notification.dart';
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

class LoginController extends GetxController {
  // Dependecy Injection
  final AuthRepo authRepo;
  final ProfileRepo profileRepo;
  LoginController(this.authRepo, this.profileRepo);

  // UI Variable
  final FocusNode fnOne = FocusNode();
  final FocusNode fnTwo = FocusNode();
  RxBool isLoading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool toggleEye = true.obs;
  RxString selectedCode = "+60".obs;
  RxBool isLoggedIn = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final SecureStorage secureStorage = SecureStorage();
  RxString isLogin = 'false'.obs;

  @override
  void onInit() {
    super.onInit();

    // fetchSecureStorageData();
  }

  Future<void> fetchSecureStorageData() async {
    username.text = await secureStorage.getUserName() ?? '';
    password.text = await secureStorage.getPassWord() ?? '';
    isLogin.value = await secureStorage.getIslogin() ?? '';

    // if (username.text.isNotEmpty && isLogin.value == 'true') {
    //   // isLoggedIn.value = true;
    //   login(LoginRequest(login: username.text, password: password.text
    //       // grantType: "password",
    //       ));
    //   return;
    // }
  }

  void login(LoginRequest request) async {
    isLoading(true);
    var response = await authRepo.loginBpg(request);

    // Check if user credentials is valid or not
    if (verifyResponse(response)) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: 'Invalid username/password!');
      return;
    }
    response as Login;
    log(jsonEncode(response));

    if (response.token?.error != null) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: 'Invalid username/password!');
      return;
    } else {
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
            logger('In FasspayBaseEnum.Otp');
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
            logger('In FasspayBaseEnum.Default');
            if (loginModelVO.isCDCVMSetupRequired!) {
              fpResponse = await profileRepo.setupCdcvmPin(walletId);
            }
            logger('wallet id:: $walletId');
            fpResponse = await profileRepo.syncData(walletId);

            // Store all sync data in local storage and fasspay userProfile
            await Get.find<StorageProvider>().setSSWalletCardModelVO(
                SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));
            await Get.find<StorageProvider>().setSSUserProfileVO(
                Get.find<StorageProvider>()
                    .getSSWalletCardModelVO()!
                    .userProfileVO!);
            log(jsonEncode(Get.find<StorageProvider>()
                .getSSWalletCardModelVO()!
                .userProfileVO!));
            isLoading(false);
            break;
          default:
        }
      } else {
        logger('elseee');
        await authRepo.initFp(null);
        isLoading(false);
      }

      logger('Refresh token :: ${response.token?.refreshToken!}');
      await secureStorage.setRefreshToken(response.token?.refreshToken ?? "");
      await Get.find<StorageProvider>().setCredentials(request);
      await Get.find<StorageProvider>()
          .setProfileInfoResponse(response.profile!);
      await Get.find<StorageProvider>().setToken(response.token!.accessToken!);
      await secureStorage.setUserName(username.text);
      await secureStorage.setPassWord(password.text);
      await secureStorage.setIslogin('true');
      await secureStorage.setName(response.profile!.fullName);
      await NotificationService().initializeLoggedInNotification();

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

  // void initBiometricLogin() async {
  //   // Authenticate
  //   final isAuthenticated = await BiometricAuth.authenticate();
  //   if (isAuthenticated) {
  //     logger('Here1');
  //     String? username = await UserSecureVault.getUsername();
  //     String? password = await UserSecureVault.getPassword();
  //     loginBloc.add(Authenticate(username!, password!));
  //   }
  // }

  // addStringToSF(LoginIsSuccess state) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('accessToken', "Bearer ${state.getUser.accessToken}");
  //   prefs.setString('username', state.getUser.username);
  //   prefs.setString('fullName', state.getUser.fullName);
  //   prefs.setString('idToken', state.getUser.idToken);
  //   prefs.setString('phone', state.getUser.username);
  //   prefs.setInt('counter', 0);
  // }

  // Check whether the user has completed the PIN
  // and move to the next page
  // void _completeLogin(user) async {
  //   // If users pin is already set, go to [GetAccountInfo]
  //   if (user.isPinSetup == true) {
  //     AppNav.cupertinoPushReplacement(
  //         context: context, route: const GetAccountInfo());

  //     // If users pin is not set, go to [SetupPinPage]
  //   } else {
  //     AppNav.cupertinoPushAndRemoveUntil(
  //         context: context, route: SetupPinPage(user.accessToken));
  //   }
  // }
}
