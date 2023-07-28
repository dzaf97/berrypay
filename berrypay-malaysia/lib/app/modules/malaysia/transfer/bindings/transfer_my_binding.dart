import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:get/get.dart';

import '../controllers/transfer_my_controller.dart';

class TransferMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferMyController>(
      () => TransferMyController(ProfileRepo(), TransferRepo()),
    );
  }
}
