import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/request_receipt_my_controller.dart';

class RequestReceiptMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestReceiptMyController>(
      () => RequestReceiptMyController(ProfileRepo()),
    );
  }
}
