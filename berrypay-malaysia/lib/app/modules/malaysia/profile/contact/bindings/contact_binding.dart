import 'package:get/get.dart';

import '../controllers/contact_controller.dart';

class ContactMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactMyController>(
      () => ContactMyController(),
    );
  }
}
