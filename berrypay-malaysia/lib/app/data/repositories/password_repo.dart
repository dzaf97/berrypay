import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:get/get.dart';

class PasswordRepo {
  final BpgProvider _bpgProvider = Get.find<BpgProvider>();

  resetPassword(ResetPasswordRequest request) =>
      _bpgProvider.resetPassword(request);
}
