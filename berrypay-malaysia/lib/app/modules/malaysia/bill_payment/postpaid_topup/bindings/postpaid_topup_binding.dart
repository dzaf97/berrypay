import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:get/get.dart';

import '../controllers/postpaid_topup_controller.dart';

class PostpaidTopupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostpaidTopupController>(
      () => PostpaidTopupController(BillRepo()),
    );
  }
}
