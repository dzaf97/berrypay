import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/register/register.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';
import 'package:get/get.dart';

class RegisterRepo {
  final BpgProvider _bpgProvider = Get.find<BpgProvider>();
  final FasspayProvider _fasspayProvider = FasspayProvider();
  final BpgMyProvider _bpgMyProvider = Get.find<BpgMyProvider>();

  // Bpg provicer
  registerBpg(RegisterBpgRequest request) => _bpgProvider.registerBpg(request);
  getCountry() => _bpgProvider.getCountry();
  getDocType(String country) => _bpgMyProvider.getDocType(country);

  // Fasspay
  registerFasspay(RegisterRequest request) =>
      _fasspayProvider.performRegister(request);
  registerFpContinue(SSUserProfileVO request) =>
      _fasspayProvider.performRegisterContinue(request);
}
