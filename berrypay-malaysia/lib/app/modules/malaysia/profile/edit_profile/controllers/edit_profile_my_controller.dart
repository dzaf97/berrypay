import 'dart:convert';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/model/remitx/sender.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/profile_my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileMyController extends GetxController {
  // Dependency Injection
  final ProfileRepo profileRepo;
  final RegisterRepo registerRepo;
  final RemittanceRepo remittanceRepo;
  EditProfileMyController(
      this.profileRepo, this.registerRepo, this.remittanceRepo);

  // Variable
  String? code;
  // Text Editing
  String? username;
  TextEditingController fullname = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController idType = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController poscode = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();

  RxString dropdownvalue = 'NRIC'.obs;

  List<DatumResult> customerDocTypeResponse = [];
  List<DatumResult> occupationResponse = [];
  List<DatumResult> sourceOfFund = [];
  List<DatumResult> relationshipResponse = [];

  RxString selectedRelationship = "".obs;
  RxString selectedCustomerType = "".obs;
  RxString selectedSourceFund = "".obs;
  RxString selectedOccupation = "".obs;
  RxString selectedGender = 'Female'.obs;

  // final RxString selectedCountryCode = "MY".obs;
  // final RxString selectedCountry = "Malaysia".obs;

  // User? userData;
  bool showLoading = true;
  //Declaration form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Model declaration
  late UpdateResponse response;

  //Loading
  RxBool isLoading = false.obs;

  // User info response
  String? walletId;
  Profile? userProfile;

  @override
  void onInit() async {
    super.onInit();

    // countries.value = await registerRepo.getCountry();
    // SuspensionUtil.sortListBySuspensionTag(countries);
    // SuspensionUtil.setShowSuspensionStatus(countries);

    // getCustomerDocType();

    userProfile = Get.find<StorageProvider>().getProfileInfoResponse();

    // walletId = Get.find<StorageProvider>()
    //     .getProfileInfoResponse()!
    //     .wallet[0]
    //     .bizSysUID;

    username = Get.find<StorageProvider>().getProfileInfoResponse()!.username;
    email = TextEditingController(text: userProfile!.email ?? '');

    fullname = TextEditingController(text: userProfile!.fullName);
    firstName =
        TextEditingController(text: userProfile!.fullName.split(' ').first);
    middleName =
        TextEditingController(text: userProfile!.fullName.split(' ').last);

    phone = TextEditingController(text: userProfile!.mobile.number);
    id = TextEditingController(
        text: userProfile!.identification!.identificationNo ?? '');

    if (Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "FASSPYMY")
        .isNotEmpty) {
      SSWalletCardModelVO getSSWalletCardModelVO =
          Get.find<StorageProvider>().getSSWalletCardModelVO()!;
      logger('masuk');

      logger(
          'dateofbirth: ${getSSWalletCardModelVO.userProfileVO!.dateOfBirth}');

      email = email = TextEditingController(
          text: getSSWalletCardModelVO
              .userProfileVO!.walletProfileList![0].email);

      dob = TextEditingController(
          text: getSSWalletCardModelVO.userProfileVO!.dateOfBirth);
    }
  }

  void updateProfile(UpdateRequest updateRequest) async {
    isLoading(true);

    // Update fasspay email
    SSUserProfileVO userProfileVO =
        Get.find<StorageProvider>().getSSUserProfileVO()!;
    userProfileVO.walletProfileList?.first.email = email.text;

    FasspayBase fasspayResponse = await profileRepo.updateProfileFp(
      userProfileVO,
      walletId ?? "",
    );

    if (fasspayResponse.isSuccess) {
      fasspayResponse = await profileRepo.syncData(walletId ?? "");
      await Get.find<StorageProvider>().setSSWalletCardModelVO(
          SSWalletCardModelVO.fromJson(jsonDecode(fasspayResponse.payload!)));

      await Get.find<StorageProvider>().setSSUserProfileVO(
          Get.find<StorageProvider>().getSSWalletCardModelVO()!.userProfileVO!);

      var emailUser = Get.find<StorageProvider>()
          .getSSWalletCardModelVO()!
          .userProfileVO!
          .walletProfileList![0]
          .email!;

      logger('email $emailUser');

      Get.find<ProfileMyController>().email!.value = emailUser;
      isLoading(false);
      Get.back();
      AppSnackbar.successSnackbar(
          title: 'You successfully update your profile');
    }

    // var response = await profileRepo.updateProfile(updateRequest);
    // if (verifyResponse(response)) {
    //   return;
    // }
    isLoading(false);
  }

  getCustomerDocType() async {
    isLoading(true);
    var response = await remittanceRepo.getCustomerDocType();

    if (verifyResponse(response)) {
      isLoading(false);
      // AppSnackbar.errorSnackbar(title: '');
      return;
    }

    CustomerDocTypeResponse customerDocType =
        await remittanceRepo.getCustomerDocType();
    customerDocTypeResponse = customerDocType.data ?? [];
    selectedCustomerType.value = customerDocTypeResponse[0].Data!;

    isLoading(false);

    getOccupation();
  }

  getOccupation() async {
    isLoading(true);
    OccupationResponse occupation = await remittanceRepo.getOccupation();

    occupationResponse = occupation.data ?? [];
    selectedOccupation.value = occupationResponse[0].Data!;
    isLoading(false);
    getSourceOfFund();
  }

  getSourceOfFund() async {
    isLoading(true);
    TransferOfFundsResponse transferOfFundsResponse =
        await remittanceRepo.transferOfFunds();
    sourceOfFund = transferOfFundsResponse.data ?? [];
    logger('source :: ${sourceOfFund[0].Data}');
    selectedSourceFund.value = sourceOfFund[0].Data!;

    isLoading(false);
    getRelationship();
  }

  getRelationship() async {
    isLoading(true);
    RelationshipResponse relationship = await remittanceRepo.getRelationship();
    relationshipResponse = relationship.data ?? [];
    selectedRelationship.value = relationshipResponse[0].Data!;
    isLoading(false);
  }

  registerSender(SenderRegisterRequest request) async {
    logger(jsonEncode(request));
    var response = await remittanceRepo.senderRegister(request);

    if (verifyResponse(response)) {
      AppSnackbar.errorSnackbar(title: 'error');
      return;
    }

    response as SenderRegisterResponse;
    Get.back();
    AppSnackbar.successSnackbar(title: response.data!.Message!);
  }
}
