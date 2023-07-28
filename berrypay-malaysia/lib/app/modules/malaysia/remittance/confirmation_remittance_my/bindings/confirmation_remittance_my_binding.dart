import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:get/get.dart';

import '../controllers/confirmation_remittance_my_controller.dart';

class ConfirmationRemittanceMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryController(RegisterRepo()));
    Get.lazyPut<ConfirmationRemittanceMyController>(
      () => ConfirmationRemittanceMyController(RemittanceRepo()),
    );
  }
}
