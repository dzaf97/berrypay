import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:get/get.dart';

import '../controllers/scan_transfer_my_controller.dart';

class ScanTransferMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanTransferMyController>(
      () => ScanTransferMyController(TransferRepo()),
    );
  }
}
