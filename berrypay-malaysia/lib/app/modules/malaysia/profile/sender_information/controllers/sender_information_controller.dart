import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/model/remitx/sender.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SenderInformationController extends GetxController {
  final RemittanceRepo remittanceRepo;
  final ProfileRepo profileRepo;
  final RegisterRepo registerRepo;
  SenderInformationController(
      this.remittanceRepo, this.profileRepo, this.registerRepo);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  TextEditingController senderCompanyName = TextEditingController();

  CountryController countryController = Get.find();
  NationalityController nationalityController = Get.find();

  RxString dropdownvalue = 'NRIC'.obs;

  List<DatumResult> customerDocTypeResponse = [];
  List<DatumResult> occupationResponse = [];
  List<DatumResult> sourceOfFund = [];
  List<DatumResult> relationshipResponse = [];
  List<DataDocType>? dataDocType;
  RxString? selectedIdType = "".obs;

  RxString selectedRelationship = "".obs;
  RxString selectedCustomerType = "".obs;
  RxString selectedSourceFund = "".obs;
  RxString selectedOccupation = "".obs;
  RxString selectedGender = 'Female'.obs;
  DataOnboarding? data;

  RxBool isLoading = false.obs;
  RxBool isLoad = false.obs;
  Profile? userProfile;
  String? username;
  QuerySenderResponse? senderDetailsResponse;
  String? remitxId;

  @override
  void onInit() async {
    super.onInit();

    username = Get.find<StorageProvider>().getProfileInfoResponse()!.username;
    userProfile = Get.find<StorageProvider>().getProfileInfoResponse();
    fullname = TextEditingController(text: userProfile!.fullName);
    firstName = TextEditingController(text: userProfile!.firstName);
    lastName = TextEditingController(text: userProfile!.lastName);
    phone = TextEditingController(text: userProfile!.mobile.fullNumber);
    email = TextEditingController(text: userProfile?.email ?? '');
    id = TextEditingController(
        text: userProfile!.identification!.identificationNo ?? '');

    if (Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "REMITXMY")
        .isNotEmpty) {
      remitxId = Get.find<StorageProvider>()
          .getProfileInfoResponse()!
          .wallet
          .where((element) => element.bizSysId == "REMITXMY")
          .first
          .bizSysUID!;

      getSenderDetails();
    } else if (Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "REMITXMY")
        .isEmpty) {
      logger('here 3');
      senderDetailsResponse = null;
      checkPhoneNoData();
    } else {
      logger('here 4');
      checkPhoneNoData();
    }
  }

  getCustomerDocType() async {
    isLoading(true);
    var response = await remittanceRepo.getCustomerDocType();

    if (verifyResponse(response)) {
      isLoading(false);
      return;
    }

    CustomerDocTypeResponse customerDocType =
        await remittanceRepo.getCustomerDocType();
    customerDocTypeResponse = customerDocType.data ?? [];

    selectedCustomerType.value = customerDocTypeResponse[0].Data!;

    for (var element in customerDocTypeResponse) {
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }

    getOccupation();
  }

  getOccupation() async {
    isLoading(true);
    OccupationResponse occupation = await remittanceRepo.getOccupation();

    occupationResponse = occupation.data ?? [];
    selectedOccupation.value = occupationResponse[0].Data!;

    var test = [];

    for (var element in occupationResponse) {
      test.add(element.Value);
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }

    getSourceOfFund();
  }

  getSourceOfFund() async {
    isLoading(true);
    TransferOfFundsResponse transferOfFundsResponse =
        await remittanceRepo.transferOfFunds();
    sourceOfFund = transferOfFundsResponse.data ?? [];

    selectedSourceFund.value = sourceOfFund[0].Data!;
    for (var element in sourceOfFund) {
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }
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
    // isLoading(true);
    isLoad(true);
    logger(jsonEncode(request));
    var response = await remittanceRepo.senderRegister(request);

    if (verifyResponse(response)) {
      isLoad(false);
      AppSnackbar.errorSnackbar(title: 'Error');
      return;
    }

    response as SenderRegisterResponse;

    var userInfo = await profileRepo.getUserDetails(username!);

    if (verifyResponse(userInfo)) {
      logger('failed');
      isLoading(false);
      isLoad(false);
      return;
    }

    userInfo as Profile;
    logger('user info:: ${jsonEncode(userInfo)}');

    await Get.find<StorageProvider>().setProfileInfoResponse(userInfo);

    Profile profileInfo = Get.find<StorageProvider>().getProfileInfoResponse()!;
    logger('profile info:: ${jsonEncode(profileInfo)}');
    isLoading(false);

    // Get.back();

    if (Get.find<StorageProvider>().getFasspayWalletId() == null) {
      AppSnackbar.successSnackbar(
          title:
              '${response.data!.Message!}. ${LocaleKeys.kyc_page_proceed_wallet.tr}');
      Get.toNamed(Routes.REGISTER_WALLET_MY, arguments: 'Basic');

      return;
    }

    AppSnackbar.successSnackbar(
        title:
            '${response.data!.Message!}. ${LocaleKeys.kyc_page_proceed_kyc.tr}');

    Get.toNamed(Routes.KYC_MY);
  }

  getSenderDetails() async {
    isLoading(true);
    var response = await remittanceRepo.getSenderDetails(remitxId!);

    if (verifyResponse(response)) {
      isLoading(false);
      senderDetailsResponse = null;
      return;
    }

    senderDetailsResponse = response;

    isLoading(false);
  }

  checkPhoneNoData() async {
    isLoading(true);

    var response =
        await profileRepo.getOnboardingDetails(userProfile!.mobile.number);

    if (verifyResponse(response)) {
      getCustomerDocType();
      getState();

      return;
    }

    response as GetOnboardingDetailsResponse;

    data = response.data!;

    if (data?.isOnboarding == false) {
      isLoading(false);
      var date = DateFormat('yyyy-MM-dd').format(DateTime.parse(data!.dob!));
      Country country = countryController.countries
          .firstWhere((element) => element.cca3 == data!.address?.country);

      poscode = TextEditingController(text: data?.address?.postcode);
      dob = TextEditingController(text: date);
      phone =
          TextEditingController(text: data!.userPhone?.registeredMobileNumber);

      senderCompanyName = TextEditingController(text: data?.companyName ?? '');

      selectedGender.value = data!.gender ?? 'Female';

      if (data?.address?.address1 != null) {
        address1 = TextEditingController(
            text:
                '${data?.address?.address1} ${data?.address?.address2} ${data?.address?.address3}');
        address2 = TextEditingController(text: data?.address?.city);
      }

      countryController.selectedCountryCode.value = country.cca3!;

      getCustomerDocType();
      getState();
      logger('end check phoneNo');
      return;
    }

    getCustomerDocType();
    getState();

    // isLoading(false);
  }

  getState() async {
    isLoading(true);
    var response = await profileRepo.getState();

    if (verifyResponse(response)) {
      // isLoading(false);
    } else {
      // logger(false);
      response as StateResponse;
      if (data?.address?.address1 != null) {
        StateData filter = response.data!
            .firstWhere((element) => element.id == data?.address?.state);

        address3 = TextEditingController(text: filter.name);
        return;
      }
    }
  }

  void launchMailClient() async {
    const mailUrl = 'mailto:servicedesk@berrypay.com';
    try {
      await launchUrl(Uri.parse(mailUrl));
    } catch (e) {
      await Clipboard.setData(
          const ClipboardData(text: 'servicedesk@berrypay.com'));
    }
  }
}
