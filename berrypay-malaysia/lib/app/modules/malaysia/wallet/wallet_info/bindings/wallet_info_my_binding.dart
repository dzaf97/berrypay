import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:get/get.dart';

import '../controllers/wallet_info_my_controller.dart';

class WalletInfoMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletInfoMyController>(
      () => WalletInfoMyController(ProfileRepo(), TransferRepo()),
    );
  }
}
