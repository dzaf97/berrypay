import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletBenefitController extends GetxController
    with GetTickerProviderStateMixin {
  TabController? tabController;

  SSWalletCardModelVO? getSSWalletCardModelVO;
  double balance = 0.0;

  List<String> benefitsPremium = [
    LocaleKeys.kyc_page_premium_desc.tr,
    LocaleKeys.kyc_page_premium_desc1.tr,
    LocaleKeys.profile_page_benefit_premium1.tr,
    LocaleKeys.profile_page_benefit_premium2.tr,
    LocaleKeys.profile_page_benefit_premium3.tr,
  ];

  List<String> titleBenefitsPremium = [
    LocaleKeys.profile_page_wallet_size.tr,
    LocaleKeys.home_withdraw.tr,
    LocaleKeys.home_withdraw.tr,
    LocaleKeys.home_page_transfer.tr,
    LocaleKeys.profile_page_spending.tr
  ];

  List<IconData> icon = [
    Icons.wallet,
    Icons.credit_card,
    Icons.outbond,
    Icons.currency_exchange,
    Icons.price_change
  ];

  List<IconData> iconBasic = [
    Icons.wallet,
    Icons.credit_card,
  ];

  List<String> titleBenefitsBasic = [
    LocaleKeys.profile_page_wallet_size.tr,
    LocaleKeys.profile_page_spending.tr
  ];

  final List<String> benefitBasic = [
    LocaleKeys.kyc_page_basic_desc.tr,
    LocaleKeys.kyc_page_basic_desc1.tr
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    if (Get.find<StorageProvider>().getFasspayWalletId() != null) {
      logger(Get.find<StorageProvider>().getFasspayWalletId());
      getSSWalletCardModelVO =
          Get.find<StorageProvider>().getSSWalletCardModelVO();
      balance = (double.parse(
              getSSWalletCardModelVO!.walletCardList![0].cardBalance!) /
          100);
      logger(jsonEncode(
          getSSWalletCardModelVO?.userProfileVO?.walletProfileList?[0]));

      logger(getSSWalletCardModelVO
          ?.userProfileVO?.walletProfileList?[0].profileMaxBalance);

      getSSWalletCardModelVO!
              .userProfileVO!.walletProfileList![0].profileType ==
          ProfileType.PersonalPremium;
      return;
    }
  }
}
