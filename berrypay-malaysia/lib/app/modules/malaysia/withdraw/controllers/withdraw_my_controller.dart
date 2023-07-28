import 'dart:convert';

import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/topup/topup.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/withdrawal/withdrawal_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/withdraw_repo.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class WithdrawMyController extends GetxController {
  final ProfileRepo profileRepo;
  final WithdrawRepo withdrawRepo;
  WithdrawMyController(this.profileRepo, this.withdrawRepo);

  RxList<SSParameterVO> bankDetails = RxList();
  RxNum cardBalance = RxNum(0);
  SSWithdrawalModelVO? withdrawalModelVO;
  TextEditingController accountNo = TextEditingController();
  TextEditingController fullName = TextEditingController();
  // TextEditingController amount = TextEditingController();
  MoneyMaskedTextController amount =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  RxString? bank = "".obs;

  RxString bankName = "".obs;
  RxBool isLoading = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fullName.text =
        Get.find<StorageProvider>().getSSUserProfileVO()?.fullName ?? "";
    setupWithdrawalCheck();
    super.onInit();
  }

  setupWithdrawalCheck() async {
    String cardId = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()
            ?.walletCardList
            ?.first
            .cardId ??
        "";
    String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    FasspayBase response = await withdrawRepo.withdrawalCheck(walletId, cardId);

    if (!response.isSuccess) {
      Get.defaultDialog(
        title: LocaleKeys.remittance_something_went_wrong.tr.toUpperCase(),
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titlePadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        content: Text(
          response.errorMessage ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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

    withdrawalModelVO =
        SSWithdrawalModelVO.fromJson(jsonDecode(response.payload!));
    cardBalance.value =
        num.parse(withdrawalModelVO?.selectedWalletCard?.cardBalance ?? "0") /
            100;

    bankDetails.value = withdrawalModelVO?.withdrawalBankList ?? [];
    logger(jsonEncode(withdrawalModelVO));
  }

  submitWithdrawal() async {
    isLoading(true);
    String cardId = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()
            ?.walletCardList
            ?.first
            .cardId ??
        "";
    String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    var request = SSWithdrawalDetailVO(
      accountName: fullName.text,
      accountNo: accountNo.text,
      // withdrawalCharges: "200",
      // withdrawalMaxAmount: "10000",
      bankId: bankDetails
          .where((p0) => p0.paramName == bankName.value)
          .first
          .paramId,
    );
    var amountWithdraw = (num.parse(amount.text) * 100).toStringAsFixed(0);
    request.amount = amountWithdraw.replaceAll('.', '').replaceAll(',', '');

    logger(request.toJson());

    FasspayBase response =
        await withdrawRepo.withdrawal(walletId, cardId, request);

    logger(jsonEncode(response));
    if (!response.isSuccess) {
      Get.defaultDialog(
        title: LocaleKeys.remittance_something_went_wrong.tr.toUpperCase(),
        content: Text(
          response.errorMessage ?? "",
          textAlign: TextAlign.center,
        ),
        onConfirm: () {
          Get.back();
        },
        confirmTextColor: Colors.white,
        textConfirm: "Okay",
      );
      return;
    }

    if (response.fasspayBaseEnum == FasspayBaseEnum.Withdrawal) {
      SSWithdrawalModelVO withdrawalModelVO =
          SSWithdrawalModelVO.fromJson(jsonDecode(response.payload ?? ""));
      Get.defaultDialog(
        title: LocaleKeys.withdrawal_confirm_withdraw.tr,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titlePadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        content: Text(
          LocaleKeys.withdrawal_confirm_withdraw_desc
              .trParams({'amount': 'RM${amount.text}'}),
          // "Are you sure you want to withdraw RM${amount.text}?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        onConfirm: () async {
          var cdcvm = await profileRepo.cdcvmValidation(
            CdcvmValidationRequest(
              walletId,
              CdcvmTransactionType.Withdrawal,
            ),
          );

          if (cdcvm.isSuccess) {
            logger('masuk  cdcvm');
            response = await withdrawRepo.confirmWithdrawal(
                walletId, cardId, withdrawalModelVO.transactionRequestId ?? "");

            SSWithdrawalModelVO ssWithdrawalModelVO =
                SSWithdrawalModelVO.fromJson(jsonDecode(response.payload!));
            logger("ssWithdrawalModelVO :: ${jsonEncode(ssWithdrawalModelVO)}");

            Get.back();

            Get.toNamed(Routes.RECEIPT_MY, arguments: ssWithdrawalModelVO);
          }
        },
        onCancel: () => Get.back(),
        cancelTextColor: AppColor.primary,
        confirmTextColor: Colors.white,
        textCancel: LocaleKeys.cancel_text.tr,
        textConfirm: "Okay",
      );
    }
  }
}
