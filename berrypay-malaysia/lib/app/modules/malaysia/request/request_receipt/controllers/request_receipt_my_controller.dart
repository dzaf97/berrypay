import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/layout_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RequestReceiptMyController extends GetxController {
  SSWalletTransferModelVO? walletTransferModelVO;
  Profile? getProfileInfo;
  final ProfileRepo profileRepo;

  RequestReceiptMyController(this.profileRepo);
  @override
  void onInit() {
    walletTransferModelVO = Get.arguments;

    super.onInit();
  }

  dynamic proceed() async {
    logger('done');
    // Get page from previous class
    getProfileInfo = Get.find<StorageProvider>().getProfileInfoResponse();
    String? walletId = Get.find<StorageProvider>().getFasspayWalletId();

    // FasspayBase fpResponse = await fasspayRepo
    //     .performSyncData(Storage.getProfileInfoResponse()!.wallet.my!);

    FasspayBase fpResponse = await profileRepo.syncData(walletId!);

    await Get.find<StorageProvider>().setSSWalletCardModelVO(
        SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));

    int? page = 0;

    // Set the selectedTab value to page
    // This is to show the selected page
    Get.find<LayoutMyController>().selectedTab.value = page;

    // Set the tabController value to page
    // This is to show the selected tab
    Get.find<LayoutMyController>().tabController.index = page;

    // Go to layout with the configuration setup above

    logger(Get.previousRoute);

    if (Get.previousRoute == Routes.REQUEST_MONEY_MY) {
      Get.close(3);
      return;
    }

    Get.close(1);

    // Get.offAndToNamed(Routes.LAYOUT_MY);
    // Get.delete<WalletInfoMyController>();
  }
}
