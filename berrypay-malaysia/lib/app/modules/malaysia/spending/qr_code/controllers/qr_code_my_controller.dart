import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/spending_repo.dart';
import 'package:get/get.dart';

class QrCodeMyController extends GetxController {
  // final FasspayRepo fasspayRepo = FasspayRepo();

  final SpendingRepo spendingRepo;
  QrCodeMyController(this.spendingRepo);

  SSSpendingModelVO? ssSpendingModelVO;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    qrCode();

    super.onInit();
  }

  qrCode() async {
    logger('masuk qr code');
    isLoading(true);
    var ssWalletCard = Get.find<StorageProvider>().getSSWalletCardModelVO();
    String? walletId = Get.find<StorageProvider>().getFasspayWalletId();

    SpendingQrRequest spendingQrRequest = SpendingQrRequest(
      walletId: walletId ?? "",
      cardId: ssWalletCard!.walletCardList![0].cardId!,
    );

    FasspayBase response =
        await spendingRepo.performSpendingQrRequest(spendingQrRequest);

    logger(jsonEncode(response));

    ssSpendingModelVO =
        SSSpendingModelVO.fromJson(jsonDecode(response.payload!));

    logger(jsonEncode(ssSpendingModelVO));
    logger('barcode data: ${ssSpendingModelVO?.spendingDetail!.barcodeData}');
    logger(' transactionRequestId: ${ssSpendingModelVO?.transactionRequestId}');

    if (response.isSuccess) {
      isLoading(false);

      SpendingQrRequest performSpendingQRCheckStatus = SpendingQrRequest(
          walletId: walletId ?? "",
          cardId: ssWalletCard.walletCardList![0].cardId!,
          transactionRequestId: ssSpendingModelVO!.transactionRequestId);

      // check QR status

      response = await spendingRepo
          .performSpendingQRCheckStatus(performSpendingQRCheckStatus);

      logger('masuk sini');
    } else {
      Get.snackbar('Failed', "Failed to load");
    }
  }
}
