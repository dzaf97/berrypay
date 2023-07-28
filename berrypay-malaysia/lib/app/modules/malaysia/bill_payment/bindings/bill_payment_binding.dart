import 'package:get/get.dart';

import '../controllers/bill_payment_controller.dart';

class BillPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillPaymentController>(
      () => BillPaymentController(),
    );
  }
}
