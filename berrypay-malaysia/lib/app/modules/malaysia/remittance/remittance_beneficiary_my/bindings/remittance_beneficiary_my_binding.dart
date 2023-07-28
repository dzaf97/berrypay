import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:get/get.dart';

import '../controllers/remittance_beneficiary_my_controller.dart';

class RemittanceBeneficiaryMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryController(RegisterRepo()));
    Get.lazyPut<RemittanceBeneficiaryMyController>(
      () => RemittanceBeneficiaryMyController(RemittanceRepo()),
    );
  }
}
