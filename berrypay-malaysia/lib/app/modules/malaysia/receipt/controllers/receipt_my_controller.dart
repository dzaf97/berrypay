import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/withdrawal/withdrawal_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/home_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/layout_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReceiptMyController extends GetxController {
  final ProfileRepo profileRepo;
  ReceiptMyController(this.profileRepo);

  RxString txnType = "".obs;
  String? txnMethod;
  String? dateTime;
  String? status;
  String? cardBalance;
  String? txnId;
  String? amount;
  String? merchant;
  String? name;
  String? description;
  String? message;
  String? statusRemit;

  SSWalletTransferModelVO? walletTransferModelVO;
  SSWalletCardModelVO? getSSWalletCardModelVO;
  SSWithdrawalModelVO? ssWithdrawalModelVO;
  Profile? getProfileInfo;
  String? walletId;
  String? paymentMode;

  @override
  void onInit() {
    logger("Previous Route :: ${Get.previousRoute}");
    String date = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
    String time = DateFormat("HH:mm:ss").format(DateTime.now());

    getProfileInfo = Get.find<StorageProvider>().getProfileInfoResponse();
    walletId = Get.find<StorageProvider>().getFasspayWalletId();

    logger('previous:: ${Get.previousRoute}');
    logger('arguements:: ${Get.arguments}');

    if (Get.previousRoute == Routes.TOPUP_MY) {
      txnType.value = "Topup";
      txnMethod = Get.arguments["transactionMethod"];
      dateTime = Get.arguments["dateTime"];
      status = Get.arguments["status"];
      cardBalance = Get.arguments["cardBalance"];
      txnId = Get.arguments["transactionId"];
      amount = Get.arguments["amount"];
      merchant = Get.arguments["merchant"] ?? "";
      description = Get.arguments["description"] ?? "";
    } else if (Get.previousRoute == Routes.RECIPIENT_DETAIL_MY) {
      txnType.value = Get.arguments["transactionType"];
      txnMethod = Get.arguments["transactionMethod"];
      dateTime = Get.arguments["dateTime"];
      status = Get.arguments["status"];
      cardBalance = Get.arguments["cardBalance"];
      txnId = Get.arguments["transactionId"];
      amount = Get.arguments["amount"];
      merchant = Get.arguments["merchant"] ?? "";
    } else if (Get.previousRoute == Routes.WITHDRAW_MY) {
      ssWithdrawalModelVO = Get.arguments;

      txnType.value = "Withdrawal";
      amount = (num.parse(ssWithdrawalModelVO!.withdrawalDetail!.amount!) / 100)
          .toStringAsFixed(2);
      txnId = ssWithdrawalModelVO!.transactionId!;
      status = "Success";
      cardBalance =
          'RM ${(num.parse(ssWithdrawalModelVO!.selectedWalletCard!.cardBalance!) / 100).toStringAsFixed(2)}';
      merchant = "-";
      dateTime = "$date $time";
      txnMethod = ssWithdrawalModelVO!.withdrawalDetail!.accountName;
      name = '-';
    } else if (Get.previousRoute == Routes.TRANSFER_MY ||
        Get.previousRoute == Routes.SCAN_TRANSFER_MY) {
      walletTransferModelVO = Get.arguments;

      txnType.value = "Transfer";
      amount = (num.parse(walletTransferModelVO!.p2pList![0].amount!) / 100)
          .toStringAsFixed(2);
      txnId = walletTransferModelVO!.p2pList![0].transactionId!;
      status = "Success";
      cardBalance =
          'RM ${(num.parse(walletTransferModelVO!.selectedWalletCard!.cardBalance!) / 100).toStringAsFixed(2)}';
      merchant = "-";
      dateTime = "$date $time";
      txnMethod = "withdrawal";
      name = walletTransferModelVO!.p2pList![0].userProfile!.fullName;
    }

    // if (Get.previousRoute == TopUpMY.route || Get.previousRoute == PayDetai.route) {
    else if (Get.previousRoute == Routes.WALLET_INFO_MY) {
      walletTransferModelVO = Get.arguments;

      txnType.value = "Transfer";
      amount = (num.parse(walletTransferModelVO!.p2pList![0].amount!) / 100)
          .toStringAsFixed(2);
      txnId = walletTransferModelVO!.p2pList![0].transactionId!;
      status = "Success";
      cardBalance =
          'RM ${(num.parse(walletTransferModelVO!.selectedWalletCard!.cardBalance!) / 100).toStringAsFixed(2)}';
      merchant = "-";
      dateTime = "$date $time";
      txnMethod = "withdrawal";
      name = walletTransferModelVO!.p2pList![0].userProfile!.fullName;
    } else if (Get.previousRoute == Routes.PAYMENT_METHOD_MY ||
        Get.previousRoute == Routes.FPX_MY ||
        Get.previousRoute == Routes.CONFIRMATION_REMITTANCE_MY) {
      var argument = Get.arguments;
      logger('argument:: $argument');

      txnType.value = Get.arguments['category'];
      dateTime = argument['date'] ?? "$date $time";
      status = argument['status'] ?? '-';
      amount = argument['amount'].toString();
      txnId = argument['txnId'] ?? '-';
      cardBalance = argument['cardBalance'] ?? '-';
      message = argument['message'];
      description = argument['description'] ?? '-';
      statusRemit = argument['statusRemit'] ?? '-';
      paymentMode = argument['paymentMode'] ?? '-';

      logger('message: $message');
    }

    super.onInit();
  }

  dynamic proceed() async {
    String? balance;
    getProfileInfo = Get.find<StorageProvider>().getProfileInfoResponse();

    if (getProfileInfo!.wallet
        .where((element) => element.bizSysId == "FASSPYMY")
        .isNotEmpty) {
      getSSWalletCardModelVO =
          Get.find<StorageProvider>().getSSWalletCardModelVO();

      FasspayBase fpResponse = await profileRepo.syncData(walletId ?? "");

      await Get.find<StorageProvider>().setSSWalletCardModelVO(
          SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));

      balance = Get.find<StorageProvider>()
          .getSSWalletCardModelVO()!
          .walletCardList![0]
          .cardBalance;

      logger('balance : $balance');
    }

    // await Get.find<StorageProvider>().setProfileInfoResponse(getSSWalletCardModelVO!.userProfileVO!);

    // await Storage.setSSWalletCardModelVO(
    //     SSWalletCardModelVO.fromJson(jsonDecode(fpResponse.payload!)));
    // await Storage.setSSUserProfileVO(
    //     Storage.getSSWalletCardModelVO()!.userProfileVO!);
    // Get page from previous class

    int? page = 0;

    // Set the selectedTab value to page
    // This is to show the selected page
    Get.find<LayoutMyController>().selectedTab.value = page;

    // Set the tabController value to page
    // This is to show the selected tab
    Get.find<LayoutMyController>().tabController.index = page;
    Get.find<HomeMyController>().balance.value =
        (double.parse(balance ?? "0") / 100);

    // Go to layout with the configuration setup above
    // Get.delete<TransactionMyController>();
    // Get.offNamedUntil(Routes.LAYOUT_MY, ModalRoute.withName(Routes.LAYOUT_MY));
    switch (Get.previousRoute) {
      case Routes.TOPUP_MY:
        Get.close(2);
        break;
      case Routes.RECIPIENT_DETAIL_MY:
        Get.close(3);
        break;
      case Routes.WITHDRAW_MY:
        Get.close(2);
        break;
      case Routes.TRANSFER_MY:
        Get.close(2);
        break;
      case Routes.SCAN_TRANSFER_MY:
        Get.close(3);
        break;

      case Routes.WALLET_INFO_MY:
        Get.close(2);
        break;
      case Routes.PAYMENT_METHOD_MY:
        if (txnType.value == "Remittance") {
          Get.close(7);
        } else {
          Get.close(5);
        }
        break;
      case Routes.FPX_MY:
        if (txnType.value == "Remittance") {
          Get.close(7);
        } else {
          Get.close(5);
        }
        break;
      case Routes.CONFIRMATION_REMITTANCE_MY:
        if (txnType.value == "Remittance") {
          Get.close(7);
        }
        break;
      default:
    }
    // if (Get.previousRoute == Routes.TOPUP_MY) {
    //   Get.close(2);
    // } else if (Get.previousRoute == Routes.RECIPIENT_DETAIL_MY) {
    // } else if (Get.previousRoute == Routes.WITHDRAW_MY) {
    // } else if (Get.previousRoute == Routes.TRANSFER_MY ||
    //     Get.previousRoute == Routes.SCAN_TRANSFER_MY) {
    // }

    // // if (Get.previousRoute == TopUpMY.route || Get.previousRoute == PayDetai.route) {
    // else if (Get.previousRoute == Routes.WALLET_INFO_MY) {
    // } else if (Get.previousRoute == Routes.PAYMENT_METHOD_MY ||
    //     Get.previousRoute == Routes.FPX_MY ||
    //     Get.previousRoute == Routes.CONFIRMATION_REMITTANCE_MY) {
    //   if (txnType.value == 'Remittance') {
    //     Get.close(7);
    //     return;
    //   }
    //   Get.close(4);
    // }

    // Get.offAllNamed(Routes.LAYOUT_MY);
    // Get.put(HomeMyController(AuthRepo(), ProfileRepo()));

// Get.offNamedUntil(Routes.LAYOUT_MY, ModalRoute.withName(Routes.LAYOUT_MY));
    // Get.delete<TopupMyController>();
    // Get.delete<TransferMyController>();
    // Get.delete<WalletInfoMyController>();
    // Get.delete<RecipientDetailMyController>();
  }
}
