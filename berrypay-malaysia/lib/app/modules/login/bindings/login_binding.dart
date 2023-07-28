import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BpgProvider());
    Get.put(BpgMyProvider());
    Get.lazyPut<LoginController>(
      () => LoginController(AuthRepo(), ProfileRepo()),
    );
  }
}
