import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/home_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletResultMyController extends GetxController {
  final ProfileRepo profileRepo;

  WalletResultMyController(this.profileRepo);

  Profile? getProfileInfo;

  String? argument;

  @override
  onInit() {
    argument = Get.arguments;
    super.onInit();
  }

  startNow() async {
    // profileRepo.setupCdcvmPin(walletId)
    if (argument == "basic") {
      var walletId = Get.find<StorageProvider>().getFasspayWalletId();
      await profileRepo.setupCdcvmPin(walletId!);
    }
    Get.replace(HomeMyController(AuthRepo(), ProfileRepo()));
    Get.offNamedUntil(Routes.LAYOUT_MY, ModalRoute.withName(Routes.LAYOUT_MY));
  }
}
