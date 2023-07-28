import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/topup/topup.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/topup_repo.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TopupMyController extends GetxController {
  // Repo
  final TopupRepo topupRepo;
  TopupMyController(this.topupRepo);

  // Storage
  SSWalletCardModelVO? getSSWalletCardModelVO;
  Profile? getProfileInfo;

  // Variable
  final TextEditingController amount = TextEditingController();
  MoneyMaskedTextController amountTopup =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  RxBool isLoading = RxBool(false);

  // Form
  final formKey = GlobalKey<FormState>();
  List<bool> selections = List.generate(3, (_) => false);

  String? balance;
  ProfileType? accountType;

  void onClick(String value) {
    logger('value $value');

    String amount = (num.parse(value) * 100).toString();

    amountTopup.text = amount;
  }

  @override
  void onInit() {
    getSSWalletCardModelVO =
        Get.find<StorageProvider>().getSSWalletCardModelVO();
    getProfileInfo = Get.find<StorageProvider>().getProfileInfoResponse();

    balance = getSSWalletCardModelVO!.walletCardList![0].cardBalance;
    accountType = getSSWalletCardModelVO!
        .userProfileVO!.walletProfileList![0].profileType!;
    logger('balance :: $balance');
    logger('account type:: $accountType');
    super.onInit();
  }

  proceedTopUp() async {
    isLoading(true);

    // Get Profile Info
    // ProfileInfoResponse? profileInfo = Storage.getProfileInfoResponse();

    String? walletId = Get.find<StorageProvider>().getFasspayWalletId();

    // perform check status

    FasspayBase response =
        await topupRepo.topupCheckStatus(TopUpCheckStatusRequest(
      walletId: walletId,
      cardId: getSSWalletCardModelVO!.walletCardList![0].cardId!,
    ));

    String status = "Success";

    logger('End performTopUpCheckStatus');

    SSTopupModelVO ssTopupModelVO =
        SSTopupModelVO.fromJson(jsonDecode(response.payload!));

    logger('Start topup');
    logger(amountTopup.text.replaceAll(',', '').replaceAll('.', ''));
    response = await topupRepo.performTopUp(
      TopUpRequest(
        walletId: walletId,
        topUpMethodType: TopUpMethodType.TopUpMethodTypeOnlineBanking,
        cardId: getSSWalletCardModelVO!.walletCardList![0].cardId!,
        amount: amountTopup.text.replaceAll(',', '').replaceAll('.', ''),
        // amount: (num.parse(amount.text) * 100).toStringAsFixed(0),
        profileId: getSSWalletCardModelVO!
            .userProfileVO!.walletProfileList!.first.profileId,
      ),
    );

    logger('enum: ${response.fasspayBaseEnum}');

    String date = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
    String time = DateFormat("HH:mm:ss").format(DateTime.now());
    logger(date);

    if (!response.isSuccess) {
      logger('masuk verify response');
      isLoading(false);

      // if (response.errorCode == "80202") {}
      Get.toNamed(Routes.RECEIPT_MY, arguments: {
        "page": 0,
        "transactionType": "Top Up",
        "transactionMethod": "Online Banking",
        "dateTime": "$date $time",
        "transactionId": ssTopupModelVO.transactionId ?? '-',
        "status": 'Failed',
        "description": response.errorMessage,
        // "cardBalance":
        //     "RM ${((double.parse(ssTopupModelVO.selectedWalletCard!.cardBalance!) / 100)).toStringAsFixed(2)}",
        "amount": amountTopup.text
      });

      logger('masuk failed');
      logger(jsonEncode(response));

      return;
    }

    isLoading(false);
    ssTopupModelVO = SSTopupModelVO.fromJson(jsonDecode(response.payload!));

    // logger(jsonEncode(ssTopupModelVO));

    logger('date : $date');
    logger('time : $time');
    logger('amount ${amount.text}');

    if (response.fasspayBaseEnum == FasspayBaseEnum.TopupCancel) {
      status = "Failed";
    }
    logger('response.fasspayBaseEnum : ${response.fasspayBaseEnum}');

    Get.toNamed(Routes.RECEIPT_MY, arguments: {
      "page": 0,
      "transactionType": "Top Up",
      "transactionMethod": "Online Banking",
      "dateTime": "$date $time",
      "transactionId": ssTopupModelVO.transactionId ?? '-',
      "status": status,
      "cardBalance":
          "RM ${((double.parse(ssTopupModelVO.selectedWalletCard!.cardBalance!) / 100)).toStringAsFixed(2)}",
      "amount": amountTopup.text
    });
  }
}
