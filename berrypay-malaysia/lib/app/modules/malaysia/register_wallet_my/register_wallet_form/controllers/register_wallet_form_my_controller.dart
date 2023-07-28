import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterWalletFormMyController extends GetxController {
  // Text Editing
  final RegisterRepo registerRepo;
  final ProfileRepo profileRepo;

  RegisterWalletFormMyController(this.registerRepo, this.profileRepo);

  TextEditingController mobileNumber = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController identificationCard = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nickName = TextEditingController();
  Profile? userProfile;
  String? walletId;
  String? nationality;

  Rx<IdentificationType> id = IdentificationType.IdentificationTypeNRIC.obs;
  RxBool isLoading = false.obs;
  DataOnboarding? data;

  @override
  void onInit() {
    super.onInit();

    userProfile = Get.find<StorageProvider>().getProfileInfoResponse();
    walletId = Get.find<StorageProvider>().getFasspayWalletId();
    // checkPhoneNoData();
    logger("userProfile :: ${jsonEncode(userProfile)}");
    mobileNumber.text = userProfile!.mobile.fullNumber;
    fullName.text = userProfile!.fullName;
    email.text = userProfile?.email ?? "";
    nickName.text = userProfile!.username;
    identificationCard.text =
        userProfile!.identification!.identificationNo ?? "";
    nationality = userProfile!.nationality;

    var date =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(userProfile!.dob!));

    dateOfBirth = TextEditingController(text: date);

    if (userProfile?.identification?.identificationType == "NRIC") {
      id.value = IdentificationType.IdentificationTypeNRIC;
    } else if (userProfile?.identification?.identificationType == "PASSPORT") {
      id.value = IdentificationType.IdentificationTypePassport;
    } else {
      id.value = IdentificationType.IdentificationTypeNRIC;
    }
  }

  registerWallet(SSUserProfileVO request) async {
    logger('register rquest ${jsonEncode(request)}');
    isLoading(true);

    FasspayBase response = await registerRepo.registerFpContinue(request);
    if (!response.isSuccess) {
      isLoading(false);
      AppSnackbar.errorSnackbar(title: response.errorMessage!);
      return;
    }
    isLoading(false);

    logger(response.payload!);
    var ssOtpModel = SSOtpModelVO.fromJson(jsonDecode(response.payload!));

    // if (ssOtpModel.isCDCVMSetupRequired!) {
    //   await fasspayRepo.performCdcvmPin(ssOtpModel.loginId!);
    // }
    var profileInfo = Get.find<StorageProvider>().getProfileInfoResponse();
    walletId = ssOtpModel.walletId ?? "";
    Get.find<StorageProvider>().setProfileInfoResponse(profileInfo!);
    Get.find<StorageProvider>().setFasspayWalletId(walletId!);

    response = await profileRepo.syncData(ssOtpModel.walletId!);
    await Get.find<StorageProvider>().setSSWalletCardModelVO(
        SSWalletCardModelVO.fromJson(jsonDecode(response.payload!)));
    await Get.find<StorageProvider>().setSSUserProfileVO(
        Get.find<StorageProvider>().getSSWalletCardModelVO()!.userProfileVO!);
    Get.toNamed(Routes.WALLET_RESULT_MY, arguments: 'basic');
  }

  checkPhoneNoData() async {
    isLoading(true);
    var response =
        await profileRepo.getOnboardingDetails(userProfile!.mobile.number);

    if (verifyResponse(response)) {
      logger('data not found');
      isLoading(true);

      return;
    }

    response as GetOnboardingDetailsResponse;

    data = response.data!;

    var date = DateFormat('dd-MM-yyyy').format(DateTime.parse(data!.dob!));

    dateOfBirth = TextEditingController(text: date);

    isLoading(false);
  }

  final Uri toLaunch = Uri.parse(
      'https://media.berrypay.xyz/artifacts/BerryPay%20Malaysia%20PDPA.pdf');

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
