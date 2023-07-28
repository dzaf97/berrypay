import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/layout_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KycResultMyController extends GetxController {
  final List<String> benefitsAdvance = [
    'Having up to RM4,999 wallet limit',
    'Flexibility to withdraw your wallet balance back to your bank account',
  ];

  final List<String> benefitsPremium = [
    'Having up to RM10,000 wallet limit',
    'Flexibility to withdraw your wallet balance back to your bank account',
    'Supports payWave payment method',
    'Spending tracking feature within your wallet',
  ];

  final List<String> pendingUpgrade = [
    'Turn on push notifications for wallet app',
    'Head to the card details to view the status'
  ];
  final List<String> failedUpgrade = [
    'IC details do not match with the registered profile',
    'Your selfie video does not match the photo in your IC'
  ];

  late String? argument;

  @override
  void onInit() {
    argument = Get.arguments;

    super.onInit();
  }

  dynamic proceed() {
    // Get page from previous class
    int? page = 0;

    Get.find<LayoutMyController>().selectedTab.value = page;

    // Set the tabController value to page
    // This is to show the selected tab
    Get.find<LayoutMyController>().tabController.index = page;

    // Go to layout with the configuration setup above
    Get.offNamedUntil(Routes.LAYOUT_MY, ModalRoute.withName(Routes.LAYOUT_MY));
  }
}
