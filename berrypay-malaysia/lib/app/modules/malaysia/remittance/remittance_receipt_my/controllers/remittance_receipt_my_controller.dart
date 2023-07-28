import 'dart:convert';
import 'dart:developer';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/remitx/transaction.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/layout_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_my_controller.dart';
import 'package:get/get.dart';

class RemittanceReceiptMyController extends GetxController {
  PaymentRequeryData? paymentRequery;
  String? id;

  final RemittanceRepo remittanceRepo;

  RxBool isLoading = false.obs;
  RemittanceReceiptMyController(this.remittanceRepo);

  @override
  onInit() {
    super.onInit();
    id = Get.arguments["id"];
    getTxnDetails(id!);
  }

  getTxnDetails(String id) async {
    isLoading(true);

    var response = await remittanceRepo.getFpxTransaction(PaymentRequeryRequest(
      BpgTxnId: id,
    ));

    if (verifyResponse(response)) {
      isLoading(false);
      logger('cannot get details');

      return;
    }

    isLoading(false);

    response as PaymentRequeryResponse;

    var tarikh = response.data?[0].txnDate?.split(' ');
    var tarikh2 = '${tarikh?[0]} ${tarikh?[1]}';

    logger('tarikh2 $tarikh2');
    response.data?[0].txnDate = tarikh2;

    paymentRequery = response.data![0];

    log('PaymentRequeryResponse ${jsonEncode(paymentRequery)}');
  }

  proceed() {
    int? page = 1;

    Get.find<LayoutMyController>().selectedTab.value = page;

    Get.find<LayoutMyController>().tabController.index = page;

    Get.find<TransactionMyController>().getFpxTransaction();

    // Get.replace(TransactionMyController(
    //     ProfileRepo(), TransactionRepo(), RemittanceRepo()));

    // Get.offNamedUntil(Routes.LAYOUT_MY, ModalRoute.withName(Routes.LAYOUT_MY));
    Get.back();
  }
}
