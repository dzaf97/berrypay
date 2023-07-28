import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/barcode_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferMyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Dependency Injection
  final ProfileRepo profileRepo;
  final TransferRepo transferRepo;
  TransferMyController(this.profileRepo, this.transferRepo);

  TextEditingController mobileNo = TextEditingController();
  RxList<SSWalletTransferDetailVO> contactList = RxList();
  String? walletId;
  SSUserProfileVO? userProfile;
  SSBarcodeModelVO? barcodeModelVO;
  RxInt currentIndex = RxInt(0);
  RxBool isLoading = RxBool(false);
  late TabController tabController;

  SSWalletTransferModelVO? ssWalletTransferModelVO;

  @override
  void onInit() {
    walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    userProfile = Get.find<StorageProvider>().getSSUserProfileVO();
    // verifyP2p();
    tabController = TabController(vsync: this, length: 2);
    qrCodeData();
    // verifyP2PBarcode();
    super.onInit();
  }

  verifyP2p() async {
    isLoading(true);
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    List<String> phoneNumbers = contacts
        .where((element) => element.phones!.isNotEmpty)
        .map((e) => e.phones?.first.value ?? "")
        .toList();
    FasspayBase response =
        await transferRepo.verifyP2P(walletId!, phoneNumbers);

    ssWalletTransferModelVO =
        SSWalletTransferModelVO.fromJson(jsonDecode(response.payload!));

    logger('ssWalletTransferModelVO:: ${jsonEncode(ssWalletTransferModelVO)}');

    if (!response.isSuccess) {
      return;
    }
    isLoading(false);

    SSWalletTransferModelVO walletTransferModelVO =
        SSWalletTransferModelVO.fromJson(jsonDecode(response.payload!));
    logger("Verify P2P: ${jsonEncode(walletTransferModelVO.p2pList)}");
    contactList.value = walletTransferModelVO.p2pList ?? [];
    for (var element in contactList) {
      element.isCheck = RxBool(false);
    }
  }

  selectWallet(SSUserProfileVO userProfileVO) {
    Get.toNamed(Routes.WALLET_INFO_MY, arguments: userProfileVO);
  }

  qrCodeData() async {
    isLoading(true);
    FasspayBase response = await profileRepo.cdcvmValidation(
      CdcvmValidationRequest(walletId!, CdcvmTransactionType.Detach),
    );

    if (!response.isSuccess) {
      Get.back();
      // AppSnackbar.errorSnackbar(title: response.errorMessage!);
      return;
    }

    FasspayBase responseQrcode =
        await transferRepo.getProfileBarcode(walletId!);
    isLoading(false);

    barcodeModelVO =
        SSBarcodeModelVO.fromJson(jsonDecode(responseQrcode.payload ?? ""));

    logger(
        'barcode data :${barcodeModelVO!.userProfile!.profileSettings!.profileBarcodeData!} ');

    logger(jsonEncode(barcodeModelVO));

    if (!responseQrcode.isSuccess) {
      AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
      return;
    }
  }
}
