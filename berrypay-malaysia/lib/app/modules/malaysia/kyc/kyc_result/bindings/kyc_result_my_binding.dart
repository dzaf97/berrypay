import 'package:get/get.dart';

import '../controllers/kyc_result_my_controller.dart';

class KycResultMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycResultMyController>(
      () => KycResultMyController(),
    );
  }
}
