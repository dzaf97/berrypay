import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/bpg/user_profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/change_mobile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/app/data/providers/fasspay_provider.dart';
import 'package:get/get.dart';

class ProfileRepo {
  final BpgProvider _bpgProvider = Get.find<BpgProvider>();
  final FasspayProvider _fasspayProvider = FasspayProvider();
  final BpgMyProvider _bpgMyProvider = Get.find<BpgMyProvider>();

  userInfo(UserInfoRequest request) => _bpgProvider.userInfo(request);

  getUserDetails(String username) => _bpgProvider.getProfileDetails(username);

  updateProfile(UpdateRequest request) => _bpgProvider.updateProfile(request);

  changeMobileNo(ChangeMobileNoRequest request) =>
      _fasspayProvider.performChangeMobileNo(request);
  syncData(String walletId) => _fasspayProvider.performSyncData(walletId);
  cdcvmValidation(CdcvmValidationRequest request) =>
      _fasspayProvider.performCdcvmValidation(request);
  setupCdcvmPin(String walletId) =>
      _fasspayProvider.performSetupCdcvmPin(walletId);
  changeCdcvmPin(String walletId) =>
      _fasspayProvider.performChangeCdcvmPin(walletId);
  updateProfileFp(SSUserProfileVO request, String walletId) =>
      _fasspayProvider.performUpdateProfile(request, walletId);

  validateProfile(SSUserProfileVO request, String walletId) =>
      _fasspayProvider.performValidateProfile(request, walletId);

  resetCdcvmPIN(String walletId) =>
      _fasspayProvider.performResetCdcvmPIN(walletId);

  getOnboardingDetails(String phoneNo) =>
      _bpgMyProvider.getBulkOnboardingDetails(phoneNo);

  getKycStatus(String phoneNo) => _bpgMyProvider.getKycStatus(phoneNo);

  getState() => _bpgMyProvider.getState();
}
