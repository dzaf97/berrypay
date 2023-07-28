import 'package:get/get.dart';

import '../controllers/referrel_code_controller.dart';

class ReferrelCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferrelCodeController>(
      () => ReferrelCodeController(),
    );
  }
}
