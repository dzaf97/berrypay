import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';
import 'package:get/get.dart';

class AuthRepo {
  final BpgProvider _bpgProvider = Get.find<BpgProvider>();
  final BpgMyProvider _bpgMyProvider = Get.find<BpgMyProvider>();
  final FasspayProvider _fasspayProvider = FasspayProvider();

  loginBpg(LoginRequest request) => _bpgProvider.loginBpg(request);
  getVersion(String clientOs) => _bpgMyProvider.getVersion(clientOs);
  updateFcmToken(FcmTokenRequest request) => _bpgProvider.updateFcmToken(request);

  loginFp(String walletId) => _fasspayProvider.performLogin(walletId);
  logoutFp(String walletId) => _fasspayProvider.performLogout(walletId);
  initFp(String? walletId) => _fasspayProvider.performInit(walletId);
  initFpSdk() => _fasspayProvider.initSdk();
}
