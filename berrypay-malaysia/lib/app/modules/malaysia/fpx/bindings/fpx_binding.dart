import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/fpx_controller.dart';

class FpxMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FpxMyController>(
      () => FpxMyController(RemittanceRepo()),
    );
  }
}
