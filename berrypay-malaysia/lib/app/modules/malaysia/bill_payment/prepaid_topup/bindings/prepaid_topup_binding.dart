import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:get/get.dart';

import '../controllers/prepaid_topup_controller.dart';

class PrepaidTopupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrepaidTopupController>(
      () => PrepaidTopupController(BillRepo()),
    );
  }
}
