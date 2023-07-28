import 'package:get/get.dart';

import '../controllers/wallet_benefit_controller.dart';

class WalletBenefitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletBenefitController>(
      () => WalletBenefitController(),
    );
  }
}
