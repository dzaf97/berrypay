import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/receipt_my_controller.dart';

class ReceiptMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptMyController>(
      () => ReceiptMyController(ProfileRepo()),
    );
  }
}
