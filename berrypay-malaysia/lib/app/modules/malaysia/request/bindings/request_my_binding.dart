import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:get/get.dart';

import '../controllers/request_my_controller.dart';

class RequestMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestMyController>(
      () => RequestMyController(TransferRepo(), ProfileRepo()),
    );
  }
}
