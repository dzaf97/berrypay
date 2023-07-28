import 'package:berrypay_global_x/app/data/repositories/topup_repo.dart';
import 'package:get/get.dart';

import '../controllers/topup_my_controller.dart';

class TopupMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopupMyController>(
      () => TopupMyController(TopupRepo()),
    );
  }
}
