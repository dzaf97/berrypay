import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:get/get.dart';

import '../controllers/request_money_my_controller.dart';

class RequestMoneyMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestMoneyMyController>(
      () => RequestMoneyMyController(TransferRepo()),
    );
  }
}
