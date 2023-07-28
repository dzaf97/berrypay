import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  // UI Variable
  RxString language = LocaleKeys.profile_page_current_lang_text.tr.obs;
  RxDouble animatedCircle = 0.0.obs;
  bool isJailbreak = false;
  bool? isLoggedIn;

  @override
  void onInit() async {
    super.onInit();
    isJailbreak = Get.arguments as bool;

    animate();
  }

  void animate() async {
    Future.delayed(const Duration(seconds: 300), () {
      animatedCircle.value = 250;
    });
  }

  void login() {
    // isLoggedIn = await UserSecureVault.initLoggedInUser();
    isLoggedIn = true;
    Get.toNamed(Routes.LOGIN);
  }

  void register() {
    Get.toNamed(Routes.REGISTER);
  }
}
