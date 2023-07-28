import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/withdraw_repo.dart';
import 'package:get/get.dart';

import '../controllers/withdraw_my_controller.dart';

class WithdrawMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawMyController>(
      () => WithdrawMyController(ProfileRepo(), WithdrawRepo()),
    );
  }
}
