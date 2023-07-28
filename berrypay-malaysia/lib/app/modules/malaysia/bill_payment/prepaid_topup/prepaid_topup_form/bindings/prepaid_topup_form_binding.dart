import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:get/get.dart';

import '../controllers/prepaid_topup_form_controller.dart';

class PrepaidTopupFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrepaidTopupFormController>(
      () => PrepaidTopupFormController(BillRepo()),
    );
  }
}
