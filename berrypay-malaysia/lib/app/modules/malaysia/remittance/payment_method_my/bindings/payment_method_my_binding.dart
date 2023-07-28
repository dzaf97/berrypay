import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/payment_method_my_controller.dart';

class PaymentMethodMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodMyController>(
      () => PaymentMethodMyController(
          ProfileRepo(), RemittanceRepo(), BillRepo()),
    );
  }
}
