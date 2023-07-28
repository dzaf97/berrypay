import 'dart:convert';
import 'dart:developer';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/remitx/transaction.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionMyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ProfileRepo profileRepo;
  final TransactionRepo transactionRepo;
  final RemittanceRepo remittanceRepo;
  TransactionMyController(
      this.profileRepo, this.transactionRepo, this.remittanceRepo);

  RxList<SSTransactionVO> transactionList = RxList<SSTransactionVO>();
  final PagingController<int, SSTransactionVO> pagingController =
      PagingController(firstPageKey: 1);

  RxBool isLoading = true.obs;
  RxInt currentIndex = RxInt(0);

  String? walletId = Get.find<StorageProvider>().getFasspayWalletId();
  // Profile profileInfoResponse =
  //     Get.find<StorageProvider>().getProfileInfoResponse()!;
  TabController? tabController;

  List<PaymentRequeryData>? paymentRequery = [];
  List<PaymentRequeryData>? remittanceList = [];
  List<PaymentRequeryData>? billerList = [];

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    pagingController
        .addPageRequestListener(((pageKey) => fetchTransaction(pageKey)));
    Get.locale;
    super.onInit();
    // getFpxTransaction();
  }

  fetchTransaction(int page) async {
    logger("Current Page: $page", name: "Transaction");
    final String walletId =
        Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    final String cardId = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()
            ?.walletCardList
            ?.first
            .cardId ??
        "";

    try {
      FasspayBase response = await transactionRepo.getTransactionHistory(
          walletId, cardId, page.toString());
      isLoading(false);

      SSTransactionHistoryModelVO transactionHistoryModelVO =
          SSTransactionHistoryModelVO.fromJson(jsonDecode(response.payload!));

      log('transactionHistoryModelVO 1 ${jsonEncode(transactionHistoryModelVO)}');
      if (response.isSuccess) {
        SSTransactionHistoryModelVO transactionHistoryModelVO =
            SSTransactionHistoryModelVO.fromJson(jsonDecode(response.payload!));
        log('transactionHistoryModelVO 2 ${jsonEncode(transactionHistoryModelVO)}');
        transactionList.value = transactionHistoryModelVO
                .transactionCardList?.first.transactionList ??
            [];
        // final previouslyFetchedItemsCount =
        //     // 2
        //     pagingController.itemList?.length ?? 0;

        // final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        pagingController.appendPage(transactionList, page + 1);

        // if (isLastPage) {
        //   // 3
        //   pagingController.appendLastPage(newItems);
        // } else {
        //   final nextPageKey = pageKey + 1;
        //   pagingController.appendPage(newItems, nextPageKey);
        // }
      } else {
        pagingController.appendLastPage(transactionList);
      }
    } catch (error) {
      logger('Scroll $error');
      pagingController.error = error;
    }
    Set<String> seen = <String>{};
    transactionList
        .where((transaction) => seen.add(transaction.transactionId!))
        .toList();
    transactionList.value = transactionList
        .where((transaction) => seen.add(transaction.transactionId.toString()))
        .toList();

    isLoading(false);
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  getFpxTransaction() async {
    isLoading(true);

    var response = await remittanceRepo.getFpxTransaction(PaymentRequeryRequest(
      BpgTxnId: '',
    ));

    if (verifyResponse(response)) {
      isLoading(false);
      logger('cannot get');
      // getFpxTransaction();
      return;
    }

    response as PaymentRequeryResponse;
    logger('response payment : ${jsonEncode(response)}');

    for (var element in response.data!) {
      var tarikh = element.txnDate!.split(' ');

      var tarikh2 = '${tarikh[0]} ${tarikh[1]}';

      element.txnDate = tarikh2;
    }

    isLoading(false);

    paymentRequery = response.data;

    remittanceList = paymentRequery!
        .where((element) => element.paymentType == "Remittance")
        .toList();

    billerList = paymentRequery!
        .where((element) => element.paymentType == "Billers")
        .toList();
  }
}
