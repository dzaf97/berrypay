import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/spending_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SpendingMyController extends GetxController {
  // controller mobile scanner
  MobileScannerController cameraController = MobileScannerController();

  //  Repo
  final SpendingRepo spendingRepo;
  final ProfileRepo profileRepo;
  SpendingMyController(this.spendingRepo, this.profileRepo);

  // Storage
  SSWalletCardModelVO? ssWalletCard;
  String? walletId;

  onDetect(Barcode barcode, MobileScannerArguments? args) async {
    logger('ondetect masuk');

    ssWalletCard = Get.find<StorageProvider>().getSSWalletCardModelVO();
    walletId = Get.find<StorageProvider>().getFasspayWalletId();

    if (barcode.rawValue == null) {
      logger('Failed to scan Barcode');
      AppSnackbar.errorSnackbar(title: 'Try again');
      return;
    }

    logger('Success detect');
    final String code = barcode.rawValue!;
    SpendingRequest spendingRequest = SpendingRequest(
      walletId: walletId ?? "",
      cardId: ssWalletCard!.walletCardList![0].cardId!,
      barcodeData: code,
    );
    FasspayBase response = await spendingRepo.spending(spendingRequest);
    logger(jsonEncode(response));

    if (!response.isSuccess) {
      // Snackbar.errorSnackbar(title: 'Please scan a valid QR!');

      Get.back();
      AppSnackbar.errorSnackbar(title: response.errorMessage!);

      return;
    }

    Get.toNamed(
      Routes.RECIPIENT_DETAIL_MY,
      arguments: {
        "SSSpendingDetailVO":
            SSSpendingDetailVO.fromJson(jsonDecode(response.payload!)),
        "SpendingRequest": spendingRequest,
      },
    );

    // if (response.isSuccess) {
    //   logger('masuk sini');
    //   // Get.toNamed(
    //   //   PayDetail.route,
    //   //   arguments: {
    //   //     "SSSpendingDetailVO":
    //   //         SSSpendingDetailVO.fromJson(jsonDecode(response.payload!)),
    //   //     "SpendingRequest": spendingRequest,
    //   //   },
    //   // );
    // } else {
    //   Get.snackbar('Invalid QR', "Please scan a valid QR!");
    // }
  }

  showQR() async {
    logger(
      jsonEncode(
          CdcvmValidationRequest(walletId!, CdcvmTransactionType.QRRequest)),
    );
    FasspayBase response = await profileRepo.cdcvmValidation(
      CdcvmValidationRequest(walletId!, CdcvmTransactionType.QRRequest),
    );

    if (response.isSuccess) {
      Get.toNamed(Routes.QR_CODE_MY);
    }
  }
  // qrCode() async {
  //   logger('masuk qr code');

  //   var profileInfo = Storage.getProfileInfoResponse();

  //   String walletId = profileInfo!.wallet.my!;

  //   logger(
  //     jsonEncode(
  //         CdcvmValidationRequest(walletId, CdcvmTransactionType.QRRequest)),
  //   );
  //   var response = await fasspayRepo.performCdcvmValidation(
  //     CdcvmValidationRequest(walletId, CdcvmTransactionType.QRRequest),
  //   );

  //   if (response.isSuccess) {
  //     Get.toNamed(QRScannerPage.route);
  //   }
  // }
}
