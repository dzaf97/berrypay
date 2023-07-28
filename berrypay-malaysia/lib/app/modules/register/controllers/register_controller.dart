import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/register/register.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/otp_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController
    with GetTickerProviderStateMixin {
  // Dependency Injection
  final RegisterRepo registerRepo;
  final ProfileRepo profileRepo;
  final AuthRepo authRepo;
  final OtpRepo otpRepo;

  RegisterController(
      this.registerRepo, this.profileRepo, this.otpRepo, this.authRepo);

  // UI Variable
  RxString code = "+60".obs;
  final TextEditingController phoneNoCtrl = TextEditingController();
  List<DataDocType>? dataDocType;
  DataOnboarding? data;

  bool btnDisabled = true;

  late AnimationController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  String? phoneNo;

  CountryController countryController = Get.find();
  NationalityController nationalityController = Get.find();

  @override
  void onInit() async {
    super.onInit();
    // phoneNoCtrl.text = '159636985';

    if (phoneNoCtrl.text.trim() != "") {
      btnDisabled = false;
    }
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 5),
    );
    // getDocType("MYS");

    // nationalityController.selectedNationalityCode.listen((p0) {
    //   logger(p0);
    //   getDocType(p0);
    // });
  }

  verify() {
    isLoading(true);
    if (phoneNoCtrl.text.isEmpty) {
      AppSnackbar.errorSnackbar(
          title: LocaleKeys.profile_page_please_enter_phone_number_text.tr);
    } else if (phoneNoCtrl.text.length < 9) {
      AppSnackbar.errorSnackbar(
          title: 'Please enter phone number more than 10 digits');
    } else {
      getOnboardingDetails();
    }
    isLoading(false);
  }

  getOnboardingDetails() async {
    isLoading(true);
    var response = await profileRepo.getOnboardingDetails(phoneNoCtrl.text);

    if (verifyResponse(response)) {
      logger('failed to fetch');
      isLoading(false);
      data = null;
      // requestOtp();
      // Get.toNamed(Routes.REGISTER_FORM, arguments: {'phone': phoneNoCtrl.text});

      registerFpWallet(null);
      // Get.to(() => const RegisterFormView());
      return;
    }
    isLoading(false);

    response as GetOnboardingDetailsResponse;

    logger('responseee ${jsonEncode(response)}');

    data = response.data!;

    if (data?.isOnboarding == false) {
      logger('masuk tak?');

      return Get.defaultDialog(
        title: "Already Registered",
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titlePadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        content: Text(
          'Your number already registered. Kindly login to your account.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        onConfirm: () {
          Get.back();
        },
        confirmTextColor: Colors.white,
      );
    } else if (data!.isOnboarding == true) {
      // Get.toNamed(Routes.REGISTER_FORM,
      //     arguments: {"dataOnboarding": data, "phone": phoneNoCtrl.text});

      registerFpWallet(data);
    }
  }

  registerFpWallet(DataOnboarding? data) async {
    isLoading(true);

    logger('data register wallet :: ${jsonEncode(data)}');

    FasspayBase fpResponse = await authRepo.initFp(null);

    if (!fpResponse.isSuccess) {
      AppSnackbar.errorSnackbar(title: fpResponse.errorMessage!);
      return;
    }

    FasspayBase response = await registerRepo.registerFasspay(
      RegisterRequest(
        mobileNumber: '60${phoneNoCtrl.text}',
        mobileNumberCountryCode: "MY",
      ),
    );

    if (response.errorCode == "20044") {
      isLoading(false);
      // Get.toNamed(Routes.REGISTER_FORM, arguments: {
      //   "dataOnboarding": data,
      //   "phone": phoneNoCtrl.text,
      // });
      return AppSnackbar.errorSnackbar(title: response.errorMessage!);
    }

    if (response.isSuccess) {
      logger('data register wallet 2 :: ${jsonEncode(data)}');
      SSOtpModelVO ssOtpModelVO =
          SSOtpModelVO.fromJson(jsonDecode(response.payload!));
      isLoading(false);
      Get.toNamed(
        Routes.OTP,
        arguments: {
          "otp": Otp.fasspay,
          "isFP": true,
          "ssOtpModelVO": ssOtpModelVO,
          "otpPacNo": ssOtpModelVO.otp!.otpPacNo,
          "phone": phoneNoCtrl.text,
          "route": Routes.REGISTER_FORM,
          "dataOnboarding": data
        },
      );
    } else {
      isLoading(false);
      logger('errprrrr');

      AppSnackbar.errorSnackbar(title: response.errorMessage!);
    }
  }
}
