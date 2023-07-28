import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/repositories/password_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordFormController extends GetxController {
  String? phoneNo;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    phoneNo = Get.arguments['phoneNo'];
    logger('phone $phoneNo');

    super.onInit();
  }

  final PasswordRepo passwordRepo;
  ForgotPasswordFormController(this.passwordRepo);

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool toggleEye = true.obs;
  RxBool toggleEye2 = true.obs;

  resetPassword() async {
    isLoading(true);
    ResetPasswordRequest request =
        ResetPasswordRequest(login: phoneNo, resetPassword: password.text);

    logger(jsonEncode(request));

    var response = await passwordRepo.resetPassword(request);

    if (verifyResponse(response)) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: 'Failed to update');
      return;
    }

    isLoading(false);
    Get.close(4);
    // Get.offNamedUntil(Routes.LOGIN, ModalRoute.withName(Routes.LOGIN));

    AppSnackbar.successSnackbar(
        title: LocaleKeys.forgot_pass_page_success_change_password.tr);
  }
}
