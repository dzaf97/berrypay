import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:get/get.dart';

import '../controllers/register_wallet_form_my_controller.dart';

class RegisterWalletFormMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterWalletFormMyController>(
      () => RegisterWalletFormMyController(RegisterRepo(), ProfileRepo()),
    );
  }
}
