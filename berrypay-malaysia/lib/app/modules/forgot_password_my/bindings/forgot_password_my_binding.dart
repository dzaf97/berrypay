import 'package:berrypay_global_x/app/data/repositories/otp_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:get/get.dart';

import '../controllers/forgot_password_my_controller.dart';

class ForgotPasswordMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordMyController>(
      () => ForgotPasswordMyController(OtpRepo(), ProfileRepo()),
    );
  }
}
