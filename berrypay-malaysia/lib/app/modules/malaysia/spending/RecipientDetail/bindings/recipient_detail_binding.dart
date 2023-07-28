import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/spending_repo.dart';
import 'package:get/get.dart';

import '../controllers/recipient_detail_controller.dart';

class RecipientDetailMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipientDetailMyController>(
      () => RecipientDetailMyController(ProfileRepo(), SpendingRepo()),
    );
  }
}
