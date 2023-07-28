import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/bpg/user_profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transaction_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/layout_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeMyController extends GetxController {
  // Dependency Injection
  final AuthRepo authRepo;
  final ProfileRepo profileRepo;
  HomeMyController(this.authRepo, this.profileRepo);

  // Variable
  SSWalletCardModelVO? getSSWalletCardModelVO;
  RxDouble balance = 0.0.obs;
  var name = "-".obs;
  RxBool isLoading = false.obs;
  Profile? profileInfo;
  String? walletId;
  RxString? status = "VERIFIED".obs;
  DataKyc? kycStatus;
  // Rx<KycStatus> kycStatus = Rx(KycStatus);

  @override
  void onInit() {
    LoginRequest? credentials = Get.find<StorageProvider>().getCredentials();
    profileInfo = Get.find<StorageProvider>().getProfileInfoResponse();
    getKycStatus();

    // getSSWalletCardModelVO =
    //     Get.find<StorageProvider>().getSSWalletCardModelVO();
    // balance =
    //     (double.parse(getSSWalletCardModelVO!.walletCardList![0].cardBalance!) /
    //         100);
    // logger('Balance :: $balance', name: "HomeMy");
    userProfile(UserInfoRequest(username: int.parse(credentials!.login)));

    if (Get.find<StorageProvider>().getFasspayWalletId() != null) {
      logger(Get.find<StorageProvider>().getFasspayWalletId());
      getSSWalletCardModelVO =
          Get.find<StorageProvider>().getSSWalletCardModelVO();
      balance.value = (double.parse(
              getSSWalletCardModelVO!.walletCardList![0].cardBalance!) /
          100);
      return;
    }

    super.onInit();
  }

  void userProfile(UserInfoRequest userInfoRequest) async {
    isLoading(true);
    walletId = Get.find<StorageProvider>().getFasspayWalletId();
    // var response = await profileRepo.userInfo(userInfoRequest);
    // if (verifyResponse(response)) return;
    // profileInfo = response;

    if (walletId != null) {
      FasspayBase fasspayResponse = await profileRepo.syncData(walletId!);
      logger('Sync Data :: ${fasspayResponse.payload}', name: "HomeMy");
      await Get.find<StorageProvider>().setSSWalletCardModelVO(
          SSWalletCardModelVO.fromJson(jsonDecode(fasspayResponse.payload!)));
      await Get.find<StorageProvider>().setSSUserProfileVO(
          Get.find<StorageProvider>().getSSWalletCardModelVO()!.userProfileVO!);
      getSSWalletCardModelVO =
          Get.find<StorageProvider>().getSSWalletCardModelVO();
      balance.value = (double.parse(
              getSSWalletCardModelVO!.walletCardList![0].cardBalance!) /
          100);
    }
    isLoading(false);
  }

  dynamic goToTransaction() {
    Get.put(LayoutMyController(AuthRepo())).tabController.animateTo(1);
    Get.put(LayoutMyController(AuthRepo())).selectedTab.value = 1;
    Get.replace(TransactionMyController(
        ProfileRepo(), TransactionRepo(), RemittanceRepo()));
  }

  void toWithdrawPage() {
    SSUserProfileVO? ssUserProfileVO =
        Get.find<StorageProvider>().getSSUserProfileVO();
    ProfileType profileType =
        ssUserProfileVO?.walletProfileList?.first.profileType ??
            ProfileType.PersonalUnverified;
    logger('Cuurent Wallet Type :: ${profileType.name}', name: "HomeMy");

    switch (profileType) {
      case ProfileType.PersonalAdvance:
        Get.toNamed(Routes.WITHDRAW_MY);
        break;
      case ProfileType.PersonalPremium:
        Get.toNamed(Routes.WITHDRAW_MY);
        break;
      default:
        AppSnackbar.errorSnackbar(
            title: LocaleKeys.home_page_error_withdrawl.tr);
        return;
    }
  }

  // Get Permission Contact
  void requestContactPermission(String route) async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      logger('Permission is granted', name: "HomeMy");
      // Get.toNamed(Routes.REQUEST_MY);
      Get.toNamed(route);
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.contacts.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        logger("Permission was granted", name: "HomeMy");
      }
    } else if (status.isPermanentlyDenied) {
      logger(status, name: "HomeMy");
      openAppSettings();
    }

    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
  }

  refreshHome() async {
    if (Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "FASSPYMY")
        .isNotEmpty) {
      walletId = Get.find<StorageProvider>().getFasspayWalletId();
      isLoading(true);

      FasspayBase fpResponse = await profileRepo.syncData(walletId!);

      await Get.find<StorageProvider>().setSSWalletCardModelVO(
          SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));
      isLoading(false);

      getSSWalletCardModelVO =
          Get.find<StorageProvider>().getSSWalletCardModelVO();
      balance.value = (double.parse(
              getSSWalletCardModelVO!.walletCardList![0].cardBalance!) /
          100);
      return;
    }

    logger('end');
  }

  getKycStatus() async {
    isLoading(true);
    String phoneNum =
        Get.find<StorageProvider>().getProfileInfoResponse()!.mobile.number;
    var response = await profileRepo.getKycStatus(phoneNum);

    if (verifyResponse(response)) {
      logger('cannot get');
      isLoading(false);
    } else {
      response as GetKycStatus;
      kycStatus = response.data;
      status?.value = kycStatus!.kycStatus.toString().split('.').last;
      logger(status?.value);

      isLoading(false);
    }
  }

  // Future<void> requestLocationPermission() async {
  //   final PermissionStatus permissionStatus =
  //       await Permission.locationWhenInUse.status;

  //   if (permissionStatus.isDenied) {
  //     await Permission.locationWhenInUse.request();
  //   }
  // }

  void requestLocationPermission(String route) async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.location.status;

    if (status.isGranted) {
      logger('Permission is granted', name: "HomeMy");
      // Get.toNamed(Routes.REQUEST_MY);
      Get.toNamed(route);
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.locationWhenInUse.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        logger("Permission was granted", name: "HomeMy");
      } else {
        // Popup dialog and ask to enable location in settings

        Get.defaultDialog(
          title: LocaleKeys.remittance_something_went_wrong.tr,
          titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          titlePadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          content: Text(
            'You are required to enable location setting to use remittance.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          onConfirm: () {
            Get.back();
            openAppSettings();
          },
          onCancel: () => {},
          confirmTextColor: Colors.white,
        );
      }
    } else if (status.isPermanentlyDenied) {
      logger(status, name: "HomeMy");
      Get.defaultDialog(
        title: LocaleKeys.remittance_something_went_wrong.tr,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titlePadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        content: Text(
          'You are required to enable location setting to use remittance.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        onConfirm: () {
          Get.back();
          openAppSettings();
        },
        onCancel: () => {},
        confirmTextColor: Colors.white,
      );
    }

    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
  }
}
