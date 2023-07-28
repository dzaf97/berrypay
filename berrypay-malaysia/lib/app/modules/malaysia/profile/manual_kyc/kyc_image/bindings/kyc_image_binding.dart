import 'package:get/get.dart';

import '../controllers/kyc_image_controller.dart';

class KycImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycImageController>(
      () => KycImageController(),
    );
  }
}
