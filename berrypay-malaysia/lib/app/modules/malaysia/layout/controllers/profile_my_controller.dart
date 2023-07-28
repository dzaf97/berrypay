import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/notification.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/secure_storage.dart';
import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/locale_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMyController extends GetxController {
  // Dependency Injection
  final AuthRepo authRepo;
  final ProfileRepo profileRepo;
  ProfileMyController(this.authRepo, this.profileRepo);
  SecureStorage secureStorage = SecureStorage();

  // UI Variable
  Profile? userProfile;
  String? walletId;
  var version = "1.0.0".obs;
  var name = "Anis".obs;
  var language = "-".obs;
  RxString? email = "".obs;

  @override
  void onInit() {
    super.onInit();

    walletId = Get.find<StorageProvider>().getFasspayWalletId();
    userProfile = Get.find<StorageProvider>().getProfileInfoResponse();
    getUserDetails();

    if (walletId == null) {
      email!.value = userProfile!.mobile.fullNumber;
    } else {
      email = Get.find<StorageProvider>()
          .getSSWalletCardModelVO()!
          .userProfileVO!
          .walletProfileList![0]
          .email!
          .obs;
    }

    switch (Get.locale!.countryCode!) {
      case "ID":
        language.value = "Bahasa Indonesia";
        break;
      case "MS":
        language.value = "Bahasa Melayu";
        break;
      case "US":
        language.value = "English";
        break;
      default:
        language.value = "-";
    }
  }

  signOut() async {
    if (walletId != null) {
      await authRepo.logoutFp(walletId!);
    }
    Get.offNamedUntil(Routes.WELCOME, ModalRoute.withName(Routes.WELCOME),
        arguments: false);

    var locale = Locale(
      Get.find<StorageProvider>().getLanguage()?.language ?? "en",
      Get.find<StorageProvider>().getLanguage()?.countryCode ?? "US",
    );

    Get.find<StorageProvider>().box.erase();

    await secureStorage.deleteAll();
    await NotificationService().removeFcmToken();

    Get.updateLocale(locale);
    Get.find<StorageProvider>().setLanguage(
      LocaleModel(
        language: locale.languageCode,
        countryCode: locale.countryCode!,
      ),
    );
    // Get.find<StorageProvider>().box.remove(key);
  }

  Future<void> changePin() async {
    // Storage.getSSUserProfileVO().profileSettings.
    if (walletId == null) {
      AppSnackbar.errorSnackbar(
          title: LocaleKeys.profile_page_please_create_wallet.tr);
      return;
    }

    FasspayBase response = await profileRepo.changeCdcvmPin(walletId ?? "");

    if (response.fasspayBaseEnum == FasspayBaseEnum.Otp) {
      SSOtpModelVO ssOtpModelVO =
          SSOtpModelVO.fromJson(jsonDecode(response.payload!));
      Get.toNamed(
        Routes.OTP,
        arguments: {
          "otp": Otp.fasspay,
          "ssOtpModelVO": ssOtpModelVO,
          "otpPacNo": ssOtpModelVO.otp!.otpPacNo,
          "phoneNo": userProfile?.mobile.fullNumber ?? "",
          "route": Routes.LAYOUT_MY,
          "walletId": walletId,
        },
      );

      return;
    }

    if (response.isSuccess) {
      AppSnackbar.successSnackbar(title: 'Successfully updated');
    }
  }

  getUserDetails() async {
    var response = await profileRepo.getUserDetails(
        Get.find<StorageProvider>().getProfileInfoResponse()!.username);

    if (verifyResponse(response)) {
      logger('error');
      return;
    }

    response as Profile;

    await Get.find<StorageProvider>().setProfileInfoResponse(response);
  }
}
