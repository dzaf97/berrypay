import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutMyController>(
      () => AboutMyController(),
    );
  }
}
