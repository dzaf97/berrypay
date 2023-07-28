import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/sender_information_controller.dart';

class SenderInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SenderInformationController>(
      () => SenderInformationController(
          RemittanceRepo(), ProfileRepo(), RegisterRepo()),
    );
  }
}
