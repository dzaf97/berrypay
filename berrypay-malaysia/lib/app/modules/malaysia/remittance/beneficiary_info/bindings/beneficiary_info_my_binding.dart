import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/beneficiary_info_my_controller.dart';

class BeneficiaryInfoMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeneficiaryInfoMyController>(
      () => BeneficiaryInfoMyController(RemittanceRepo()),
    );
  }
}
