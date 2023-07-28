import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RemittanceMyController extends GetxController {
  final ProfileRepo _profileRepo;
  final RemittanceRepo _remittanceRepo;

  RemittanceMyController(this._profileRepo, this._remittanceRepo);

  MoneyMaskedTextController sendController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  MoneyMaskedTextController receivedController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  RxString controlleText = "".obs;
  DataKyc? kycStatus;
  double transferFee = 10.0;
  RxDouble payableAmount = 0.0.obs;
  String? locationId;
  RxDouble adminFee = 10.00.obs;
  dynamic rate, currency, country;
  String? receiverCountry;
  String? calcBy;
  RxBool isLoading = false.obs;

  final currencyFormat = NumberFormat("#,###.00");
  final idnCurrencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    decimalDigits: 0,
  );

  @override
  void onInit() async {
    super.onInit();
    rate = Get.arguments['rate'];
    if (rate.runtimeType == String) {
      rate = double.parse(rate).toStringAsFixed(4);
    }
    currency = Get.arguments['currency'];
    country = Get.arguments['country'];
    receiverCountry = Get.arguments['receiverCountry'];

    getLocationId();
    getTransferFee();
  }

  void getLocationId() async {
    var response = await _remittanceRepo.agent(AgentRequest(
      paymentMode: "B",
      payoutCountry: receiverCountry,
    ));
    if (verifyResponse(response)) return;
    locationId = (response as AgentResponse).data!.first.LocationId;
  }

  void calculateSend(String value) async {
    // Prevent user from clearing the send textfield
    if (value.isEmpty) {
      receivedController.text = '0';
      payableAmount.value = 0;
      return;
    }

    // Remove comma from the textfield sending amount
    value = double.parse(value.replaceAll(",", "")).toString();

    // Calculate sending amount using remitx API
    var response = await _remittanceRepo.transferFee(TransferFeeRequest(
      calcBy: "P",
      transferAmount: value.toString(),
      payoutCurrency: currency,
      paymentMode: "B",
      locationId: locationId,
      payoutCountry: receiverCountry,
    ));

    // Http request error check
    if (verifyResponse(response)) return;

    // If payout amount is not null, get the payout amount from API
    if ((response as TransferFeeResponse).data!.PayoutAmount != null) {
      sendController.text = response.data!.TransferAmount!;
      payableAmount.value = double.parse(response.data!.CollectAmount!);
      calcBy = "P";
      return;
    }

    // Else calculate based on exchange rate fee
    double sendAmount = double.parse(value) / num.parse(rate);
    sendController.text = sendAmount.toStringAsFixed(2);
    payableAmount.value = sendAmount + transferFee;

    logger('payableAmount ${payableAmount.value}');
  }

  void calculcateReceive(String value) async {
    // Prevent user from clearing the send textfield
    if (value.isEmpty) {
      receivedController.text = '0';
      payableAmount.value = 0;
      return;
    }

    // Remove comma from the textfield sending amount
    value = double.parse(value.replaceAll(",", "")).toString();

    // Calculate receiving ammount using remitx API
    var response = await _remittanceRepo.transferFee(TransferFeeRequest(
      calcBy: "C",
      transferAmount: value.toString(),
      payoutCurrency: currency,
      paymentMode: "B",
      locationId: locationId,
      payoutCountry: receiverCountry,
    ));

    // Http request error check
    if (verifyResponse(response)) return;

    // If payout amount is not null, get the payout amount from API
    if ((response as TransferFeeResponse).data!.PayoutAmount != null) {
      receivedController.text = response.data!.PayoutAmount!;
      payableAmount.value = double.parse(response.data!.CollectAmount!);
      calcBy = "C";
      return;
    }

    // Else calculate based on exchange rate fee
    receivedController.text =
        (double.parse(value) * num.parse(rate)).toStringAsFixed(2);
    payableAmount.value =
        double.parse(sendController.text.replaceAll(",", "")) + transferFee;
  }

  getKycStatus() async {
    logger('start getKycStatus');
    String phoneNum =
        Get.find<StorageProvider>().getProfileInfoResponse()!.mobile.number;
    var response = await _profileRepo.getKycStatus(phoneNum);

    if (verifyResponse(response)) {
      logger('cannot get');
      kycStatus = null;
    } else {
      response as GetKycStatus;
      kycStatus = response.data;

      logger(Get.find<StorageProvider>().getFasspayWalletId());

      logger(kycStatus?.kycStatus);

      // Check amount before proceed
      if (sendController.text.isEmpty ||
          sendController.text == '0.00' ||
          sendController.text == '0') {
        AppSnackbar.errorSnackbar(
            title: LocaleKeys.remittance_error_no_amount.tr);
        return;
      }

      if (num.parse(sendController.text.replaceAll(",", "")) < 20) {
        AppSnackbar.errorSnackbar(
            title: LocaleKeys.remittance_minimimum_amount.tr);
        return;
      }
      if (num.parse(sendController.text.replaceAll(",", "")) > 50000) {
        AppSnackbar.errorSnackbar(
            title: LocaleKeys.remittance_error_max_amount.tr);
        return;
      }

      logger(
          'remit id:: ${jsonEncode(Get.find<StorageProvider>().getProfileInfoResponse()!)}');

      // Check if user already registered for remittance
      if (Get.find<StorageProvider>()
          .getProfileInfoResponse()!
          .wallet
          .where((element) => element.bizSysId == "REMITXMY")
          .isEmpty) {
        Get.defaultDialog(
          title: LocaleKeys.remittance_sender_incomplete.tr.toUpperCase(),
          titleStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          titlePadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          content: Text(
            LocaleKeys.remittance_sender_information_desc.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          onConfirm: () {
            Get.back();
            Get.toNamed(Routes.SENDER_INFORMATION);
          },
          onCancel: () => Get.back(),
          confirmTextColor: Colors.white,
        );
        return;
      }
      logger('kyc ${jsonEncode(kycStatus)}');
      // Check if user kyc document already uploaded or not

      if (kycStatus?.kycStatus == KycStatus.VERIFIED) {
        String amount = "";

        if (calcBy == "C") {
          amount = sendController.text.replaceAll(",", "");
        } else if (calcBy == "P") {
          amount = receivedController.text.replaceAll(",", "");
        }
        logger('sendAmount :: $amount');

        Get.toNamed(Routes.REMITTANCE_BENEFICIARY_MY, arguments: {
          "amount": amount,
          "calcBy": calcBy,
          "country": country,
          "currency": currency,
          "receiverCountry": receiverCountry
        });

        return;
      }

      if (Get.find<StorageProvider>().getFasspayWalletId() == null) {
        Get.defaultDialog(
          title: 'UPGRADE',
          titlePadding: const EdgeInsets.only(top: 20),
          content: Text(
            LocaleKeys.remittance_create_basic.tr,
            textAlign: TextAlign.center,
          ),
          onConfirm: () {
            Get.toNamed(Routes.REGISTER_WALLET_MY, arguments: 'Basic');
          },
          onCancel: () => Get.back(),
          confirmTextColor: Colors.white,
        );

        return;
      }
      if (kycStatus?.kycStatus != KycStatus.VERIFIED) {
        logger('kyc status 2');
        getStatus(Get.find<StorageProvider>()
            .getSSWalletCardModelVO()!
            .userProfileVO!
            .walletProfileList![0]
            .eKYCStatus!);

        return;
      }

      String amount = "";

      if (calcBy == "C") {
        amount = sendController.text.replaceAll(",", "");
      } else if (calcBy == "P") {
        amount = receivedController.text.replaceAll(",", "");
      }
      logger('sendAmount :: $amount');

      Get.toNamed(Routes.REMITTANCE_BENEFICIARY_MY, arguments: {
        "amount": amount,
        "calcBy": calcBy,
        "country": country,
        "currency": currency,
        "receiverCountry": receiverCountry
      });
    }
  }

  getTransferFee() async {
    isLoading(true);
    var response = await _remittanceRepo.displayTransferFee(
      receiverCountry!,
      currency,
    );

    if (verifyResponse(response)) {
      isLoading(false);
      logger('cannot get transfer fee');
    } else {
      isLoading(false);
      logger('response get Transfer fee:: ${jsonEncode(response)}');
      transferFee = double.parse((response as GetTransferFee).data ?? '0.0');
    }
  }

  getStatus(EKYCStatus status) {
    switch (status) {
      case EKYCStatus.AdminRejected:
        return getDialog();

      case EKYCStatus.AdminRejectedPremium:
        return getDialog();

      case EKYCStatus.AdminRejectedAdvance:
        return getDialog();

      case EKYCStatus.Failed:
        return getDialog();

      case EKYCStatus.NotVerify:
        return getDialog();

      case EKYCStatus.Pending:
        return Get.toNamed(Routes.KYC_RESULT_MY,
            arguments: 'eKYCStatusPending');

      default:
        // return Get.defaultDialog(
        //   title: LocaleKeys.remittance_kyc_incomplete.tr,
        //   titlePadding: const EdgeInsets.only(top: 20),
        //   content: Text(
        //     LocaleKeys.remittance_verification_kyc.tr,
        //     textAlign: TextAlign.center,
        //   ),
        //   onConfirm: () {
        //     Get.back();
        //     // Get.toNamed(Routes.SENDER_INFORMATION);
        //   },
        //   onCancel: () => Get.back(),
        //   confirmTextColor: Colors.white,
        // );
        //

        return Get.toNamed(Routes.KYC_RESULT_MY,
            arguments: 'eKYCStatusRemitPending');
    }
  }

  getDialog() {
    return Get.defaultDialog(
      title: 'UPGRADE',
      titlePadding: const EdgeInsets.only(top: 20),
      content: Text(
        LocaleKeys.remittance_kyc_upgrade.tr,
        textAlign: TextAlign.center,
      ),
      onConfirm: () {
        Get.toNamed(Routes.REGISTER_WALLET_MY, arguments: 'Premium');
      },
      onCancel: () => Get.back(),
      confirmTextColor: Colors.white,
    );
  }
}
