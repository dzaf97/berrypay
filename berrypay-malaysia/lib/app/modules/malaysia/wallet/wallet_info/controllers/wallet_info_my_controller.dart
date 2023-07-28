import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transfer/transfer_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletInfoMyController extends GetxController {
  // Dependency Injection
  final ProfileRepo profileRepo;
  final TransferRepo transferRepo;
  WalletInfoMyController(this.profileRepo, this.transferRepo);

  TextEditingController amount = TextEditingController();
  RxBool isConfirmAmount = false.obs;
  String cardId = Get.find<StorageProvider>()
          .getSSWalletCardModelVO()
          ?.walletCardList
          ?.first
          .cardId ??
      "";

  String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
  SSUserProfileVO? userProfileVO;
  // SSWalletTransferModelVO
  final formKey = GlobalKey<FormState>();

  RxList<ContactDetail> contact = RxList();
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    userProfileVO = Get.arguments;

    logger(userProfileVO!.toJson());

    super.onInit();
  }

  // set setConfirmAmount(RxBool confAmount) => isConfirmAmount = confAmount;
  setIsConfirmAmount() {
    if (amount.text.isEmpty || amount.text == "0.0") {
      AppSnackbar.errorSnackbar(title: 'Please enter amount');
    } else {
      isConfirmAmount.value = !isConfirmAmount.value;
    }
  }

  onProceed() async {
    isLoading(true);
    if (Get.previousRoute == Routes.REQUEST_MONEY_MY) {
      logger('masuk sini');
      FasspayBase response = await profileRepo.cdcvmValidation(
        CdcvmValidationRequest(walletId, CdcvmTransactionType.P2PRequestMoney),
      );
      isLoading(false);

      if (!response.isSuccess) {
        Get.defaultDialog(
          title: "Something went wrong",
          content: Text(response.errorMessage ?? ""),
          onConfirm: () => Get.back(),
          confirmTextColor: Colors.white,
        );
        return;
      }

      isLoading(true);
      contact.add(ContactDetail(
          walletId: userProfileVO!.profileSettings!.walletId,
          amount: amount.text));

      logger('contact : ${contact.toJson()}');

      List<ContactDetail> p2pRequestList = contact
          .map((element) => ContactDetail(
              walletId: element.walletId,
              amount: (num.parse(amount.text) * 100).toStringAsFixed(0)))
          .toList();

      logger('p2pRequestList ${jsonEncode(p2pRequestList)}');

      Requestp2p requestp2p = Requestp2p(
          walletId: walletId, cardId: cardId, contactDetail: p2pRequestList);

      logger(requestp2p.toJson());

      response = await transferRepo.requestP2P(requestp2p);
      logger(response.toJson());

      if (!response.isSuccess) {
        isLoading(false);
        AppSnackbar.errorSnackbar(title: response.errorMessage!);
        return;
      }

      isLoading(false);
      SSWalletTransferModelVO walletTransferModelVO =
          SSWalletTransferModelVO.fromJson(jsonDecode(response.payload!));

      // Get.delete<RequestMyController>();
      // Get.delete<RequestMoneyMyController>();
      Get.offAndToNamed(Routes.REQUEST_RECEIPT_MY,
          arguments: walletTransferModelVO);
      // Get.offNamedUntil(RequestReceipt.route, ModalRoute.withName(RequestMoney.route));

      logger('success');
    } else {
      logger('masuk sini 2');
      FasspayBase response = await profileRepo.cdcvmValidation(
        CdcvmValidationRequest(walletId, CdcvmTransactionType.P2PSendMoney),
      );
      isLoading(false);

      if (!response.isSuccess) {
        Get.defaultDialog(
          title: "Something went wrong",
          content: Text(response.errorMessage ?? ""),
          onConfirm: () => Get.back(),
          confirmTextColor: Colors.white,
        );
        return;
      }

      logger('request::: ${jsonEncode(
        TransferP2PRequest(
          fasspayBaseEnum: FasspayBaseEnum.TransferP2P,
          senderWalletId: walletId,
          senderCardId: cardId,
          receiverWalletId: userProfileVO?.profileSettings?.walletId ?? "",
          amount: (num.parse(amount.text) * 100).toString(),
        ),
      )}');

      response = await transferRepo.transferP2P(
        TransferP2PRequest(
          fasspayBaseEnum: FasspayBaseEnum.TransferP2P,
          senderWalletId: walletId,
          senderCardId: cardId,
          receiverWalletId: userProfileVO?.profileSettings?.walletId ?? "",
          amount: (num.parse(amount.text) * 100).toStringAsFixed(0),
        ),
      );

      if (!response.isSuccess) {
        AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
        isLoading(false);
        return;
      }

      SSWalletTransferModelVO walletTransferModelVO =
          SSWalletTransferModelVO.fromJson(jsonDecode(response.payload!));

      isLoading(false);
      if (!response.isSuccess) {
        AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
        return;
      }

      logger('walletTransferModelVO :: ${jsonEncode(walletTransferModelVO)}');

      // Get.delete<TransferMyController>();
      Get.offAndToNamed(Routes.RECEIPT_MY, arguments: walletTransferModelVO);
    }
  }
}
