import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';

class KycMyController extends GetxController {
  final ProfileRepo profileRepo;
  KycMyController(this.profileRepo);

  SSWalletCardModelVO? ssWalletCardModelVO;

  @override
  onInit() {
    ssWalletCardModelVO = Get.find<StorageProvider>().getSSWalletCardModelVO();
    super.onInit();
  }

  getStarted() async {
    logger("getStarted");
    SSUserProfileVO userProfileVo =
        Get.find<StorageProvider>().getSSUserProfileVO()!;

    String walletId = Get.find<StorageProvider>().getFasspayWalletId()!;
    // userProfileVo.nickName = "Anis";
    // userProfileVo.residentialAddress = "Malakat Mall, Cyberjaya";
    // userProfileVo.deliveryAddress = SSAddressVO(
    //     "62250", "Presint 9", "Putrajaya", "Putrajaya", "Putrajaya");
    // userProfileVo.genderType = GenderType.Female;

    logger(jsonEncode(userProfileVo));

    FasspayBase response = await profileRepo.validateProfile(
      userProfileVo,
      walletId,
    );

    if (!response.isSuccess) {
      AppSnackbar.errorSnackbar(title: response.errorMessage!);

      return;
    }
    if (response.isSuccess) {
      Get.toNamed(Routes.WALLET_RESULT_MY, arguments: 'advance');
    }

    // SSUpdateProfileModelVO ssUpdateProfileModelVO =
    //     SSUpdateProfileModelVO.fromJson(jsonDecode(response.payload!));
    logger(jsonEncode(response.payload));
  }
}
