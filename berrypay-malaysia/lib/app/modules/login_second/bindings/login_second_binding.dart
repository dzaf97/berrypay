import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/login_second_controller.dart';

class LoginSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginSecondController>(
      () => LoginSecondController(AuthRepo(), ProfileRepo()),
    );
  }
}
