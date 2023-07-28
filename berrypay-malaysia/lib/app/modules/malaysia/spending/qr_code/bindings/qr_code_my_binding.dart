import 'package:berrypay_global_x/app/data/repositories/spending_repo.dart';
import 'package:get/get.dart';

import '../controllers/qr_code_my_controller.dart';

class QrCodeMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeMyController>(
      () => QrCodeMyController(SpendingRepo()),
    );
  }
}
