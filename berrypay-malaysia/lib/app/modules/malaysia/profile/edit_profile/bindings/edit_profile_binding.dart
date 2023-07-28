import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/edit_profile_my_controller.dart';

class EditProfileMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BpgMyProvider());
    Get.lazyPut<EditProfileMyController>(
      () => EditProfileMyController(
          ProfileRepo(), RegisterRepo(), RemittanceRepo()),
    );
  }
}
