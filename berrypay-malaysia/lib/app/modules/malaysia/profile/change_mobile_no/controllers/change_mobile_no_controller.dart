import 'dart:convert';

import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/change_mobile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeMobileNoMyController extends GetxController {
  // Dependency Injection
  final ProfileRepo profileRepo;
  ChangeMobileNoMyController(this.profileRepo);

  TextEditingController newMobile = TextEditingController();
  SSWalletCardModelVO? getSSWalletCardModelVO;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  onInit() {
    // newMobile.text = "60133373713";
    super.onInit();
  }

  submit() async {
    String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";

    getSSWalletCardModelVO =
        Get.find<StorageProvider>().getSSWalletCardModelVO();

    String loginId =
        Get.find<StorageProvider>().getProfileInfoResponse()?.mobile.number ??
            "";

    FasspayBase response = await profileRepo.cdcvmValidation(
      CdcvmValidationRequest(walletId, CdcvmTransactionType.ChangeMobileNo),
    );

    if (!response.isSuccess) {
      AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
      return;
    }

    var request = ChangeMobileNoRequest(
      walletId: walletId,
      newMobileNoCountryCode: '+60',
      loginId: loginId,
      loginType: LoginType.MobileNo,
      loginMode: LoginMode.Otp,
      newMobileNo: '6${newMobile.text}',
    );

    response = await profileRepo.changeMobileNo(request);

    if (!response.isSuccess) {
      Get.defaultDialog(
        title: "Something went wrong!",
        content: Text(
          response.errorMessage ?? "",
          textAlign: TextAlign.center,
        ),
        onConfirm: () {
          Get.back();
          Get.back();
        },
        confirmTextColor: Colors.white,
        textConfirm: "Okay",
      );
      return;
    }

    if (response.fasspayBaseEnum == FasspayBaseEnum.Otp) {
      SSOtpModelVO ssOtpModelVO =
          SSOtpModelVO.fromJson(jsonDecode(response.payload!));
      Get.toNamed(
        Routes.OTP,
        arguments: {
          "otp": Otp.fasspay,
          "ssOtpModelVO": ssOtpModelVO,
          "otpPacNo": ssOtpModelVO.otp!.otpPacNo,
          "route": Routes.LAYOUT_MY,
          "walletId": walletId,
        },
      );
      Get.delete<ChangeMobileNoMyController>();
      return;
    }

    // if (response.isSuccess) {
    //   var request = ChangeMobileNoRequest(
    //       walletId: walletId,
    //       newMobileNoCountryCode: '+60',
    //       loginId: loginId,
    //       newMobileNo: newMobile.text);

    //   logger('request ${(request.toJson())}');
    //   FasspayBase response = await fasspayRepo.performChangeMobileNo(request);

    //   logger('response :::  ${jsonEncode(response)}');

    //   if (!response.isSuccess) {
    //     Get.defaultDialog(
    //       title: "Error",
    //       content: Text(
    //         response.errorMessage ?? "",
    //         textAlign: TextAlign.center,
    //       ),
    //       onConfirm: () {
    //         Get.back();
    //         Get.back();
    //       },
    //       confirmTextColor: Colors.white,
    //       textConfirm: "Okay",
    //     );
    //     return;
    //   }
    // }
  }
}
