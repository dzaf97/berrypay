import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:get/get.dart';

import '../controllers/nationality_controller.dart';

class NationalityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NationalityController>(
      () => NationalityController(RegisterRepo()),
    );
  }
}
