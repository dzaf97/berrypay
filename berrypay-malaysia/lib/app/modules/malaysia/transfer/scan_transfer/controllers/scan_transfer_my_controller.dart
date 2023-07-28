import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/transfer_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanTransferMyController extends GetxController {
  MobileScannerController cameraController = MobileScannerController();
  // FasspayRepo fasspayRepo = FasspayRepo();

  final TransferRepo transferRepo;
  ScanTransferMyController(this.transferRepo);
  String walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? "";

  onDetect(Barcode barcode, MobileScannerArguments? args) async {
    logger('ondetect masuk');

    if (barcode.rawValue == null) {
      logger('Failed to scan Barcode');
      AppSnackbar.errorSnackbar(title: 'Try again.');

      return;
    }

    logger('Success detect');
    final String code = barcode.rawValue!;

    logger('code:: $code');

    FasspayBase response = await transferRepo.verifyP2PBarcode(
        VerifyP2PBarcodeRequest(walletId: walletId, barcodeData: code));

    logger("performVerifyP2PBarcode :: ${jsonEncode(response)}");

    SSWalletTransferModelVO ssWalletTransferModelVO =
        SSWalletTransferModelVO.fromJson(jsonDecode(response.payload ?? ""));

    // SSUserProfileVO ssUserProfileVO = ssVerifyP2PBarcodeModel.p2pList[0]!.userProfile

    logger('responsssss:::');
    logger(jsonEncode(ssWalletTransferModelVO));

    logger(
        'fullname:  ${(ssWalletTransferModelVO.p2pList![0].userProfile!.fullName!)}');

    if (response.isSuccess) {
      logger('masuk sini');

      Get.toNamed(Routes.WALLET_INFO_MY,
          arguments: ssWalletTransferModelVO.p2pList![0].userProfile!);
    } else {
      AppSnackbar.errorSnackbar(title: 'Invalid QR. Please scan a valid QR!');
    }
  }
}
