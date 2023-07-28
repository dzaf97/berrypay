import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/spending_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecipientDetailMyController extends GetxController {
  // final FasspayRepo fasspayRepo = FasspayRepo();

  final ProfileRepo profileRepo;
  final SpendingRepo spendingRepo;
  RecipientDetailMyController(this.profileRepo, this.spendingRepo);

  final TextEditingController amount = TextEditingController();

  RxBool isLoading = false.obs;
  SSWalletCardModelVO? getSSWalletCardModelVO;
  double? cardBalance;
  ProfileType? accountType;

  SSSpendingDetailVO? spendingDetail;
  @override
  void onInit() {
    spendingDetail = Get.arguments["SSSpendingDetailVO"];
    logger(jsonEncode(spendingDetail));
    getSSWalletCardModelVO =
        Get.find<StorageProvider>().getSSWalletCardModelVO();

    cardBalance =
        (double.parse(getSSWalletCardModelVO!.walletCardList![0].cardBalance!) /
            100);
    amount.text = "0.00";
    accountType = getSSWalletCardModelVO!
        .userProfileVO!.walletProfileList![0].profileType!;

    super.onInit();
  }

  Future<void> payNow() async {
    isLoading(true);
    SpendingRequest spendingRequest =
        Get.arguments["SpendingRequest"] as SpendingRequest;
    String? walletId = Get.find<StorageProvider>().getFasspayWalletId();
    FasspayBase response = await profileRepo.cdcvmValidation(
      CdcvmValidationRequest(walletId ?? "", CdcvmTransactionType.Spending),
    );
    logger(jsonEncode(response));
    if (!response.isSuccess) {
      Get.back();
      Get.back();
      AppSnackbar.errorSnackbar(title: response.errorMessage!);
      return;
    }

    spendingRequest.amount = (num.parse(amount.text) * 100).toStringAsFixed(0);

    response = await spendingRepo.confirmSpending(spendingRequest);
    isLoading(false);
    logger(jsonEncode(response));
    if (!response.isSuccess) {
      Get.back();
      Get.back();
      AppSnackbar.errorSnackbar(
          title: 'Failed Payment. ${response.errorMessage!}');

      return;
    }

    SSSpendingModelVO ssSpendingModelVO =
        SSSpendingModelVO.fromJson(jsonDecode(response.payload!));
    logger('response pay now');
    logger(jsonEncode(ssSpendingModelVO));

    double balance =
        (double.parse(ssSpendingModelVO.selectedWalletCard!.cardBalance!) /
            100);

    double amountPay =
        (double.parse(ssSpendingModelVO.spendingDetail!.amount!) / 100);

    String balanceCard = balance.toStringAsFixed(2);
    logger('balance: $balanceCard');

    var millis = ssSpendingModelVO.transactionDateTimeInMilis;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis!);

    var date = DateFormat('yyyy-MM-dd, hh:mm a').format(dt);

    if (response.isSuccess) {
      Get.toNamed(Routes.RECEIPT_MY, arguments: {
        "page": 0,
        "transactionType": "Pay",
        "merchant": ssSpendingModelVO.spendingDetail?.merchantName ?? '-',
        "dateTime": date,
        "transactionId": ssSpendingModelVO.transactionId ?? '-',
        "status": "Success",
        "cardBalance": "RM $balanceCard",
        "amount": amountPay.toStringAsFixed(2),
        "transactionMethod": "Pay"
      });

      // Get.toNamed(PayCompleted.route);
    }
  }
}
