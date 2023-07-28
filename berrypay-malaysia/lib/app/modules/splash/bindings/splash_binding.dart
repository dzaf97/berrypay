import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageProvider());
    Get.lazyPut(() => BpgProvider());
    Get.lazyPut(() => BpgMyProvider());

    Get.lazyPut<SplashController>(
      () => SplashController(AuthRepo()),
    );
  }
}
