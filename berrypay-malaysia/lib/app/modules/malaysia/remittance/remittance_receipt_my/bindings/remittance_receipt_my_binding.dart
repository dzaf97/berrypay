import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/remittance_receipt_my_controller.dart';

class RemittanceReceiptMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemittanceReceiptMyController>(
      () => RemittanceReceiptMyController(RemittanceRepo()),
    );
  }
}
