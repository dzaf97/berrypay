import 'dart:convert';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transfer/transfer_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/home_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestMyController extends GetxController {
  final ProfileRepo profileRepo;
  final TransferRepo transferRepo;
  RequestMyController(this.transferRepo, this.profileRepo);
//  FasspayRepo fasspayRepo = FasspayRepo();
  SSWalletTransferModelVO? ssWalletTransferModelVO;
  RxBool isLoading = RxBool(false);
  String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
  String cardId = Get.find<StorageProvider>()
          .getSSWalletCardModelVO()
          ?.walletCardList
          ?.first
          .cardId ??
      "";

  RxList<ContactDetail> contact = RxList();

  @override
  onInit() {
    logger('masuk');
    requestHistory();
    super.onInit();
  }

  requestHistory() async {
    isLoading(true);
    String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    String cardId = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()
            ?.walletCardList
            ?.first
            .cardId ??
        "";

    FasspayBase response = await transferRepo.requestHistory(walletId, cardId);

    if (!response.isSuccess) {
      ssWalletTransferModelVO!.p2pList = [];
      return;
    }

    ssWalletTransferModelVO =
        SSWalletTransferModelVO.fromJson(jsonDecode(response.payload ?? ""));
    ssWalletTransferModelVO?.p2pList =
        ssWalletTransferModelVO?.p2pList?.reversed.toList();
    // ssWalletTransferModelVO!.p2pList = ssWalletTransferModelVO!.p2pList!
    //     .where(
    //       (element) =>
    //           element.userProfile!.profileSettings!.walletId != walletId,
    //     )
    //     .toList();
    // ssWalletTransferModelVO!.p2pList = [];

    logger('response payload:: ${jsonEncode(ssWalletTransferModelVO)}');

    if (response.isSuccess) {
      isLoading(false);
      logger('success');
    }
  }

  requestAction(SSWalletTransferDetailVO walletTransferDetailVO) {
    logger("SSWalletTransferDetailVO :: ${walletTransferDetailVO.toJson()}",
        name: "Request");
    logger(
        "SSWalletTransferDetailVO :: ${walletTransferDetailVO.transferRequestDetail?.toJson()}",
        name: "Request");
    String receiverWalletId =
        walletTransferDetailVO.userProfile?.profileSettings?.walletId ?? "";
    String amount =
        (num.parse(walletTransferDetailVO.amount!) / 100).toStringAsFixed(2);
    SSWalletTransferRequestDetailVO? walletTransferRequestDetailVO =
        walletTransferDetailVO.transferRequestDetail;
    logger("SSWalletTransferDetailVO :: ${walletTransferDetailVO.toJson()}");
    logger(
        "SSWalletTransferDetailVO :: ${walletTransferDetailVO.transferRequestDetail?.toJson()}");

    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(20),
      title: "Incoming Request",
      content: Text(
          "${walletTransferDetailVO.userProfile?.fullName} has requested RM $amount from you."),
      textConfirm: "Pay Now",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        FasspayBase response = await profileRepo.cdcvmValidation(
          CdcvmValidationRequest(walletId, CdcvmTransactionType.P2PSendMoney),
        );

        if (!response.isSuccess) {
          AppSnackbar.errorSnackbar(title: response.errorMessage!);
          return;
        }

        walletTransferRequestDetailVO?.transferRequestStatusId =
            TransferRequestStatus.Approve;
        walletTransferRequestDetailVO?.transferRequestStatus =
            TransferRequestStatus.Approve;
        walletTransferRequestDetailVO?.transferRequestType =
            TransferRequestType.TransferRequestTypePayer;

        response = await transferRepo.transferP2P(
          TransferP2PRequest(
            fasspayBaseEnum: FasspayBaseEnum.RequestP2P,
            senderWalletId: walletId,
            senderCardId: cardId,
            receiverWalletId: receiverWalletId,
            amount: walletTransferDetailVO.amount!,
            ssWalletTransferRequestDetailVO: walletTransferRequestDetailVO,
          ),
        );
        Get.back();
        if (!response.isSuccess) {
          AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
          walletTransferRequestDetailVO?.transferRequestStatusId =
              TransferRequestStatus.Pending;
          walletTransferRequestDetailVO?.transferRequestStatus =
              TransferRequestStatus.Pending;
          return;
        }
        AppSnackbar.successSnackbar(title: "Transfer success");

        await requestHistory();

        response = response = await profileRepo.syncData(walletId);
        await Get.find<StorageProvider>().setSSWalletCardModelVO(
            SSWalletCardModelVO.fromJson(jsonDecode(response.payload!)));

        var balance = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()!
            .walletCardList![0]
            .cardBalance;

        Get.find<HomeMyController>().balance.value =
            (double.parse(balance ?? "0") / 100);
      },
      textCancel: "Reject",
      cancelTextColor: AppColor.primary,
      onCancel: () async {
        FasspayBase response = await profileRepo.cdcvmValidation(
          CdcvmValidationRequest(walletId, CdcvmTransactionType.P2PSendMoney),
        );

        if (!response.isSuccess) {
          AppSnackbar.errorSnackbar(title: response.errorMessage!);
          return;
        }

        walletTransferRequestDetailVO?.transferRequestStatusId =
            TransferRequestStatus.Decline;
        walletTransferRequestDetailVO?.transferRequestStatus =
            TransferRequestStatus.Decline;
        walletTransferRequestDetailVO?.transferRequestType =
            TransferRequestType.TransferRequestTypePayer;
        response = await transferRepo.transferP2P(
          TransferP2PRequest(
            fasspayBaseEnum: FasspayBaseEnum.RequestP2P,
            senderWalletId: walletId,
            senderCardId: cardId,
            receiverWalletId: receiverWalletId,
            amount: walletTransferDetailVO.amount!,
            ssWalletTransferRequestDetailVO: walletTransferRequestDetailVO,
          ),
        );
        // Get.back();
        if (!response.isSuccess) {
          AppSnackbar.errorSnackbar(title: "Failed to reject. Try again");
          return;
        }
        AppSnackbar.successSnackbar(title: "Reject success");
        await requestHistory();
        Get.back();
      },
    );
  }

  resendRequest(SSWalletTransferDetailVO walletTransferDetailVO) async {
    String receiverWalletId =
        walletTransferDetailVO.userProfile?.profileSettings?.walletId ?? "";

    logger('receiverWalletId : $receiverWalletId');
    FasspayBase response = await profileRepo.cdcvmValidation(
      CdcvmValidationRequest(walletId, CdcvmTransactionType.P2PRequestMoney),
    );

    if (!response.isSuccess) {
      Get.defaultDialog(
        title: "Something went wrong",
        content: Text(response.errorMessage ?? ""),
        onConfirm: () => Get.back(),
        confirmTextColor: Colors.white,
      );
      return;
    }

    contact.add(ContactDetail(
        walletId: receiverWalletId, amount: walletTransferDetailVO.amount!));

    List<ContactDetail> p2pRequestList = contact
        .map((element) => ContactDetail(
            walletId: receiverWalletId, amount: walletTransferDetailVO.amount!))
        .toList();

    logger('p2pRequestList $p2pRequestList');

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
  }
}
