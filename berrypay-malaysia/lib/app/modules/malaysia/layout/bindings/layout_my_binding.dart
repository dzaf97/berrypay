import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transaction_repo.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/home_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_my_controller.dart';
import 'package:get/get.dart';

import '../controllers/layout_my_controller.dart';

class LayoutMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransactionMyController(
        ProfileRepo(), TransactionRepo(), RemittanceRepo()));
    Get.lazyPut<HomeMyController>(
      () => HomeMyController(AuthRepo(), ProfileRepo()),
    );
    Get.lazyPut<LayoutMyController>(
      () => LayoutMyController(AuthRepo()),
    );
  }
}
