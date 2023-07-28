import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/otp_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CountryController(RegisterRepo()));
    Get.put(NationalityController(RegisterRepo()));
    Get.put(BpgMyProvider());
    Get.lazyPut<RegisterController>(
      () => RegisterController(
          RegisterRepo(), ProfileRepo(), OtpRepo(), AuthRepo()),
    );
  }
}
