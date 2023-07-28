import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/wallet_result_my_controller.dart';

class WalletResultMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletResultMyController>(
      () => WalletResultMyController(ProfileRepo()),
    );
  }
}
