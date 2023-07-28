import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/kyc_my_controller.dart';

class KycMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycMyController>(
      () => KycMyController(ProfileRepo()),
    );
  }
}
