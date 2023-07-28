import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/model/locale_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends GetxService {
  GetStorage box = GetStorage();

  Future<void> setSSWalletCardModelVO(
          SSWalletCardModelVO ssWalletCardModelVo) async =>
      await box.write("SSWalletCardModelVO", ssWalletCardModelVo.toJson());
  SSWalletCardModelVO? getSSWalletCardModelVO() =>
      SSWalletCardModelVO.fromJson(box.read("SSWalletCardModelVO"));

  Future<void> setSSUserProfileVO(SSUserProfileVO ssUserProfileVO) async =>
      await box.write("SSUserProfileVO", ssUserProfileVO.toJson());
  SSUserProfileVO? getSSUserProfileVO() =>
      SSUserProfileVO.fromJson(box.read("SSUserProfileVO"));

  Future<void> setProfileInfoResponse(Profile profileInfoResponse) async =>
      await box.write("UserProfile", profileInfoResponse.toJson());
  Profile? getProfileInfoResponse() =>
      Profile.fromJson(box.read("UserProfile"));

  Future<void> setFasspayWalletId(String walletId) async =>
      await box.write("FasspayWalletId", walletId);
  String? getFasspayWalletId() => box.read("FasspayWalletId") as String?;

  Future<void> setCredentials(LoginRequest credentials) async =>
      await box.write("credentials", credentials.toJson());
  LoginRequest? getCredentials() =>
      LoginRequest.fromJson(box.read("credentials"));

  Future<void> setToken(String token) async => await box.write("token", token);
  String? getToken() => box.read("token") as String?;

  Future<void> setLanguage(LocaleModel language) async =>
      await box.write("language", language.toJson());
  LocaleModel? getLanguage() => (box.read("language") != null)
      ? LocaleModel.fromJson(box.read("language"))
      : null;
}
