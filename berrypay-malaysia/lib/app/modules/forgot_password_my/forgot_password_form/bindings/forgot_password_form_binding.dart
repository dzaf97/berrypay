import 'package:berrypay_global_x/app/data/repositories/password_repo.dart';
import 'package:get/get.dart';

import '../controllers/forgot_password_form_controller.dart';

class ForgotPasswordFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordFormController>(
      () => ForgotPasswordFormController(PasswordRepo()),
    );
  }
}
