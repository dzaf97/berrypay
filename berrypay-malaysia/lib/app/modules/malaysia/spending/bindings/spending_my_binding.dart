import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/spending_repo.dart';
import 'package:get/get.dart';

import '../controllers/spending_my_controller.dart';

class SpendingMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpendingMyController>(
      () => SpendingMyController(SpendingRepo(), ProfileRepo()),
    );
  }
}
