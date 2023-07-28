import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/change_mobile_no_controller.dart';

class ChangeMobileNoMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeMobileNoMyController>(
      () => ChangeMobileNoMyController(ProfileRepo()),
    );
  }
}
