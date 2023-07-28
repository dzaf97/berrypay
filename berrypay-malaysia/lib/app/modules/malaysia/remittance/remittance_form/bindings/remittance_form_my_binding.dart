import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/remittance_form_my_controller.dart';

class RemittanceFormMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemittanceFormMyController>(
      () => RemittanceFormMyController(RemittanceRepo()),
    );
  }
}
