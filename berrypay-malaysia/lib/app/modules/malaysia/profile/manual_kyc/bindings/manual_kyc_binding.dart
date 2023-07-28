import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/manual_kyc_controller.dart';

class ManualKycBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BpgMyProvider());
    // Get.lazyPut(() => BpgMyProvider());
    // Get.lazyPut(() => BpgMyProvider());
    // Get.lazyPut(() => RemitxProvider());
    Get.lazyPut<ManualKycController>(
      () => ManualKycController(RemittanceRepo(), AuthRepo()),
    );
  }
}
