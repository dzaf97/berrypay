import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:get/get.dart';

import '../controllers/exchange_rate_my_controller.dart';

class ExchangeRateMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BpgMyProvider());
    Get.lazyPut<ExchangeRateMyController>(
      () => ExchangeRateMyController(
          RemittanceRepo(), RegisterRepo(), ProfileRepo()),
    );
  }
}
