import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmationRemittanceMyController extends GetxController {
  ConfirmationRemittanceMyController(this.remittanceRepo);
  final RemittanceRepo remittanceRepo;

  String? amount;
  String? calcBy;
  DataTransferFee? transferFeeResponse;
  DataBeneficiary? getBeneficiaryResponse;
  RxBool isLoading = false.obs;
  RxBool tnc = false.obs;
  String? paymentMode;
  String? agent;
  String currentDate = DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now());
  CountryController countryController = Get.find();

  @override
  onInit() {
    super.onInit();
    amount = Get.arguments['amount'];
    calcBy = Get.arguments['calcBy'];
    getBeneficiaryResponse = Get.arguments['data'] as DataBeneficiary;
    paymentMode = Get.arguments['paymentMode'];
    agent = Get.arguments['agent'];

    logger('getBeneficiaryResponse ${jsonEncode(getBeneficiaryResponse)}');
    logger('paymentMode $paymentMode');
    logger('agent $agent');
    calcTransferFee();
    // getCurrentDateTime();
    // logger('amount $amount');
  }

  calcTransferFee() async {
    isLoading(true);
    var response = await remittanceRepo.transferFee(
      TransferFeeRequest(
        transferAmount: amount,
        calcBy: calcBy,
        payoutCurrency:
            getBeneficiaryResponse!.Beneficiarydetail!.Receivecurrencycode,
        paymentMode: paymentMode,
        locationId: agent,
        payoutCountry: getBeneficiaryResponse!.Beneficiarydetail!.Countrycode,
      ),
    );

    if (verifyResponse(response)) {
      logger('verifyresponse');

      Get.close(1);
      isLoading(false);

      response as AppError;
      AppSnackbar.errorSnackbar(title: response.message);
      return;
    }
    isLoading(false);

    transferFeeResponse = (response as TransferFeeResponse).data;
    logger(jsonEncode(transferFeeResponse));
  }

  onSubmit() {
    Get.toNamed(Routes.PAYMENT_METHOD_MY, arguments: {
      'amount': transferFeeResponse!.CollectAmount,
      'transferFeeResponse': transferFeeResponse,
      'getBeneficiaryResponse': getBeneficiaryResponse
    });
  }

  String get getCountry {
    Country ccaCountry = countryController.countries.firstWhere((element) =>
        element.cca3 == getBeneficiaryResponse?.Beneficiarydetail?.Countrycode);
    return ccaCountry.flags!.png!;
  }

  Future<void> launchInBrowser() async {
    if (!await launchUrl(
      Uri.parse(
          'https://media.berrypay.xyz/artifacts/BerryPay%20Malaysia%20TnC.pdf'),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception(
          'Could not launch ${'https://media.berrypay.xyz/artifacts/BerryPay%20Malaysia%20TnC.pdf'}');
    }
  }
}
