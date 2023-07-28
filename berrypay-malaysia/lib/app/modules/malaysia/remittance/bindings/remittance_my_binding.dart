import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/remittance_my_controller.dart';

class RemittanceMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemittanceMyController>(
      () => RemittanceMyController(ProfileRepo(), RemittanceRepo()),
    );
  }
}
