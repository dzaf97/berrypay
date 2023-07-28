import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:get/get.dart';

import '../controllers/register_wallet_my_controller.dart';

class RegisterWalletMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterWalletMyController>(
      () => RegisterWalletMyController(RegisterRepo()),
    );
  }
}
