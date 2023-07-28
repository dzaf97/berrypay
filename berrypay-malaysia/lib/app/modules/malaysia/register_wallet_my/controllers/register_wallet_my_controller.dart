import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/values/enum.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/register/register.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterWalletMyController extends GetxController {
  final RegisterRepo registerRepo;
  RegisterWalletMyController(this.registerRepo);
  RxBool isloading = false.obs;

  String? type;

  @override
  void onInit() {
    super.onInit();

    type = Get.arguments;
  }

  registerFpWallet() async {
    isloading(true);
    // Get.toNamed(WalletOtp.route);
    Profile userProfile = Get.find<StorageProvider>().getProfileInfoResponse()!;

    String mobileNumber = userProfile.mobile.fullNumber;

    logger(
        jsonEncode(RegisterRequest(
          mobileNumber: mobileNumber,
          mobileNumberCountryCode: "MY",
        )),
        name: "RegisterWalletMyController");

    FasspayBase response = await registerRepo.registerFasspay(
      RegisterRequest(
        mobileNumber: mobileNumber,
        mobileNumberCountryCode: "MY",
      ),
    );

    if (response.errorCode == "20044") {
      Get.toNamed(Routes.REGISTER_WALLET_FORM_MY);
      return;
    }

    if (response.isSuccess) {
      SSOtpModelVO ssOtpModelVO =
          SSOtpModelVO.fromJson(jsonDecode(response.payload!));
      isloading(false);
      Get.toNamed(
        Routes.OTP,
        arguments: {
          "otp": Otp.fasspay,
          "isFP": true,
          "ssOtpModelVO": ssOtpModelVO,
          "otpPacNo": ssOtpModelVO.otp!.otpPacNo,
          "phone": mobileNumber,
          "route": Routes.REGISTER_WALLET_FORM_MY
        },
      );
    } else {
      isloading(false);
      logger('errprrrr');

      AppSnackbar.successSnackbar(title: response.errorMessage!);
    }
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
