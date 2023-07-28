import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/fpx_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/wallet/wallet_model.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/bill.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/model/remitx/transaction.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum PaymentMethod { wallet, fpx }

class PaymentMethodMyController extends GetxController {
  final ProfileRepo profileRepo;
  final RemittanceRepo remittanceRepo;
  final BillRepo billRepo;
  PaymentMethodMyController(
      this.profileRepo, this.remittanceRepo, this.billRepo);

  String? amount;
  SSWalletCardModelVO? getSSWalletCardModelVO;
  String? remitxId;
  RxBool isLoading = false.obs;
  List<DatumResult> paymentModeResponse = [];
  RxString? selectedPaymentMode = "".obs;

  Profile? userProfile = Get.find<StorageProvider>().getProfileInfoResponse();

  DataTransferFee? transferFeeResponse;
  DataBeneficiary? getBeneficiaryResponse;
  InitiateBillerRequest? initiateBillerRequest;
  String? category;

  // final String merchantId = "800380000000001"; // Hardcdoed with Berrypay mid
  String? merchantId;
  RxBool isloading = false.obs;
  RxBool isFinished = false.obs;
  RxString? gender = 'Male'.obs;
  Rx<PaymentMethod> payment = Rx<PaymentMethod>(PaymentMethod.fpx);
  RxBool disableWallet = true.obs;

  @override
  onInit() {
    if (Get.find<StorageProvider>().getFasspayWalletId() != null) {
      disableWallet(false);
    }
    amount = Get.arguments['amount'];
    getBeneficiaryResponse = Get.arguments['getBeneficiaryResponse'];
    transferFeeResponse = Get.arguments['transferFeeResponse'];
    initiateBillerRequest = Get.arguments['initiateBillerRequest'];
    category = Get.arguments['category'];
    super.onInit();
    if (category != "Biller") {
      getPaymentMode();
    }
  }

  walletSubmit() async {
    isloading(true);
    transferFeeResponse as DataTransferFee;
    getBeneficiaryResponse as DataBeneficiary;
    merchantId = dotenv.env['fasspayRemitMid']!;

    remitxId = Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "REMITXMY")
        .first
        .bizSysUID!;

    Data data = Data(
        CustomerId: remitxId,
        BeneficiaryId: getBeneficiaryResponse!.BeneficiaryId,
        SendCurrency: transferFeeResponse!.CollectCurrency,
        RemittanceAmount: transferFeeResponse!.TransferAmount,
        RemittanceFee: transferFeeResponse!.ServiceCharge,
        TotalAmount: transferFeeResponse!.CollectAmount,
        EstimatedReceivingAmount: null,
        ExchanageRate: transferFeeResponse!.ExchangeRate,
        PromoCode: null,
        DepositeMethodCode: selectedPaymentMode?.value,
        IncludeFee: true,
        AmountMethodCode: null,
        Remittancereasoncode: getBeneficiaryResponse!.Remittancereasoncode,
        SourceOfFunds: '',
        Purpose: getBeneficiaryResponse?.Remittancereasondetail ?? '',
        PaymentMode: 'Wallet',
        PaymentModeSubCat: 'FassPay',
        PaymentModeStatus: '',
        PaymentModeTxnRef: '');

    logger('data :: ${jsonEncode(data)}');
    logger('payment mode :: ${jsonEncode(data.PaymentMode)}');
    PayRequest payRequest = PayRequest(data: data);

    var responseInitiate = await remittanceRepo.initiateTransaction(payRequest);

    if (verifyResponse(responseInitiate)) {
      logger('error');
      isloading(false);
      Get.back();
      AppSnackbar.errorSnackbar(title: LocaleKeys.please_try_again_text.tr);
      return;
    }

    responseInitiate as PayResponse;

    if (responseInitiate.initiateStatus != "SUCCESS") {
      logger('error');
      isloading(false);
      Get.back();
      AppSnackbar.errorSnackbar(
          title: responseInitiate.initiateMessage ?? 'Try again!');
      return;
    }

    getSSWalletCardModelVO =
        Get.find<StorageProvider>().getSSWalletCardModelVO()!;

    final String walletId =
        Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    final String cardId = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()
            ?.walletCardList
            ?.first
            .cardId ??
        "";
    FasspayBase response = await profileRepo.cdcvmValidation(
        CdcvmValidationRequest(walletId, CdcvmTransactionType.InAppPurchase));
    if (!response.isSuccess) {
      // comit failed txn
      Get.back();
      logger('cancel cdcvm');
      var responseComit = await remittanceRepo.commitRemit(ComitRemit(
          bpgTxnId: responseInitiate.bpgTxnId, txnRefId: "", status: 'FAILED'));
      logger(jsonEncode(responseComit));

      AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
      return;
    }

    InAppPurchaseRequest request = InAppPurchaseRequest(
      walletId: walletId,
      cardId: cardId,
      amount: (num.parse(transferFeeResponse!.CollectAmount!) * 100)
          .toStringAsFixed(0),
      mid: merchantId!,
      productDesc: "remit",
    );
    logger('request: ${jsonEncode(request)}');

    response = await remittanceRepo.performInAppPurchase(request);

    if (!response.isSuccess) {
      isloading(false);
      Get.back();
      // comit failed txn
      var responseComit = await remittanceRepo.commitRemit(ComitRemit(
          bpgTxnId: responseInitiate.bpgTxnId, txnRefId: "", status: 'FAILED'));

      logger(jsonEncode(responseComit));

      AppSnackbar.errorSnackbar(title: response.errorMessage!);
      return;
    }

    // Comit remit txn success

    SSSpendingModelVO ssSpendingModelVO =
        SSSpendingModelVO.fromJson(jsonDecode(response.payload!));

    var responseComit = await remittanceRepo.commitRemit(ComitRemit(
        bpgTxnId: responseInitiate.bpgTxnId,
        txnRefId: ssSpendingModelVO.transactionId,
        status: 'SUCCESS'));

    if (verifyResponse(responseComit)) {
      logger('error comit');
    }
    responseComit as ComitRemitResponse;

    logger('res: ${jsonEncode(ssSpendingModelVO)}');

    var millis = ssSpendingModelVO.transactionDateTimeInMilis.toString();

    var dt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(millis),
      // isUtc: true
    );

    var date = DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    isloading(false);

    Get.toNamed(Routes.RECEIPT_MY, arguments: {
      'status': 'Success',
      'statusRemit': 'IN PROCESS',
      'amount': (num.parse(ssSpendingModelVO.spendingDetail!.amount!) / 100)
          .toStringAsFixed(2),
      'txnId': ssSpendingModelVO.transactionId,
      'cardBalance':
          'RM ${(num.parse(ssSpendingModelVO.selectedWalletCard!.cardBalance!) / 100).toStringAsFixed(2)}',
      'date': date,
      'category': 'Remittance'
    });
  }

  onlineBankingSubmit() async {
    isloading(true);
    logger('masuk');
    getBeneficiaryResponse as DataBeneficiary;
    transferFeeResponse as DataTransferFee;

    remitxId = Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "REMITXMY")
        .first
        .bizSysUID!;

    Data data = Data(
        CustomerId: remitxId,
        BeneficiaryId: getBeneficiaryResponse!.BeneficiaryId,
        SendCurrency: transferFeeResponse!.CollectCurrency,
        RemittanceAmount: transferFeeResponse!.TransferAmount,
        RemittanceFee: transferFeeResponse!.ServiceCharge,
        TotalAmount: transferFeeResponse!.CollectAmount,
        EstimatedReceivingAmount: null,
        ExchanageRate: transferFeeResponse!.ExchangeRate,
        PromoCode: null,
        DepositeMethodCode: selectedPaymentMode?.value,
        IncludeFee: true,
        AmountMethodCode: null,
        Remittancereasoncode: getBeneficiaryResponse!.Remittancereasoncode,
        SourceOfFunds: '',
        Purpose: getBeneficiaryResponse?.Remittancereasondetail ?? '',
        PaymentMode: 'Payment Gateway',
        PaymentModeSubCat: 'FPX',
        PaymentModeStatus: '',
        PaymentModeTxnRef: '');

    logger(data);
    PayRequest request = PayRequest(data: data);

    logger(jsonEncode(request));
    var response = await remittanceRepo.initiateTransaction(request);

    if (verifyResponse(response)) {
      logger('error initiate');
      isloading(false);
      AppSnackbar.errorSnackbar(title: LocaleKeys.please_try_again_text.tr);
      return;
    }

    response as PayResponse;

    logger('BPG ID:: ${response.bpgTxnId}');

    if (response.initiateStatus != "SUCCESS") {
      logger('error');
      isloading(false);
      AppSnackbar.errorSnackbar(title: response.initiateMessage ?? 'Try again');
      return;
    }

    FpxModel? fpxModel;

    fpxModel = FpxModel(
        txnAmount: double.parse(amount!),
        txnBuyerEmail: userProfile!.email!,
        txnBuyerName: userProfile!.fullName,
        txnBuyerPhone: userProfile!.mobile.number,
        txnOrderId: response.bpgTxnId!,
        txnProductDesc: 'Remittance',
        txnProductName: 'Remittance');

    logger('remit');
    logger(fpxModel.toJson());

    Get.toNamed(Routes.FPX_MY, arguments: {
      "newRoute": Routes.RECEIPT_MY,
      "fpxModel": fpxModel,
      'category': 'Remittance'
    });
    isloading(false);
  }

  getPaymentMode() async {
    isLoading(true);
    getBeneficiaryResponse as DataBeneficiary;
    transferFeeResponse as DataTransferFee;

    var response = await remittanceRepo.getPaymentMode(
        getBeneficiaryResponse!.Addressinfo!.Addresscountrycode ?? 'idn');

    // var response = await remittanceRepo.getPaymentMode("IDN");

    if (verifyResponse(response)) {
      logger('error ni');
      return;
    }

    response as PaymentModeResponse;

    paymentModeResponse = response.data ?? [];

    logger('paymentModeResponse ${jsonEncode(paymentModeResponse)}');

    List<DatumResult> filter = paymentModeResponse
        .where(
          (element) => element.Value!.contains('Bank Transfer'),
        )
        .toList();

    logger('filter ${jsonEncode(filter)}');

    paymentModeResponse = filter;
    selectedPaymentMode?.value = paymentModeResponse[0].AdditionalValue!;

    isLoading(false);
  }

  payBiller() async {
    isLoading(true);
    initiateBillerRequest as InitiateBillerRequest;
    initiateBillerRequest?.data?.amount =
        initiateBillerRequest!.data!.amount! + 1;
    var response = await billRepo.initiateBiller(initiateBillerRequest!);

    if (verifyResponse(response)) {
      isloading(false);
      Get.back();
      AppSnackbar.errorSnackbar(title: 'Error');
      return;
    }

    response as InitiateBillerResponse;
    logger(response);

    if (response.data?.status != "SUCCESS") {
      isloading(false);
      Get.back();
      AppSnackbar.errorSnackbar(
          title: response.data?.statusDescription ?? 'Try again');
      return;
    }

    FpxModel? fpxModel;

    fpxModel = FpxModel(
        txnAmount: initiateBillerRequest!.data!.amount!.toDouble(),
        txnBuyerEmail: userProfile!.email!,
        txnBuyerName: userProfile!.fullName,
        txnBuyerPhone: userProfile!.mobile.number,
        txnOrderId: response.data!.bpgTxnId!,
        txnProductDesc:
            'Purchase biller to ${initiateBillerRequest?.data?.msisdn}',
        txnProductName: initiateBillerRequest?.data?.productCode ?? 'Biller');

    logger('remit');
    logger(fpxModel.toJson());

    Get.toNamed(Routes.FPX_MY, arguments: {
      "newRoute": Routes.RECEIPT_MY,
      "fpxModel": fpxModel,
      'category': 'Biller'
    });
    isloading(false);
  }

  payBillerWalet() async {
    isloading(true);
    merchantId = dotenv.env['fasspayBillMid']!;

    initiateBillerRequest as InitiateBillerRequest;
    initiateBillerRequest!.data!.paymentMode = "Wallet";
    initiateBillerRequest?.data?.paymentModeSubCat = "FassPay";

    logger('initiate biller ${jsonEncode(initiateBillerRequest)}');

    var responseInitiate =
        await billRepo.initiateBiller(initiateBillerRequest!);

    if (verifyResponse(responseInitiate)) {
      logger('error');
      isloading(false);
      Get.back();
      AppSnackbar.errorSnackbar(title: LocaleKeys.please_try_again_text.tr);
      return;
    }

    responseInitiate as InitiateBillerResponse;

    if (responseInitiate.data?.status != "SUCCESS") {
      logger('error');
      isloading(false);
      Get.back();
      AppSnackbar.errorSnackbar(
          title: responseInitiate.data?.statusDescription ?? 'Try again!');
      return;
    }

    logger('responseInitiate ${jsonEncode(responseInitiate)}');
    logger('bpgID 1 :: ${responseInitiate.data?.bpgTxnId}');

    getSSWalletCardModelVO =
        Get.find<StorageProvider>().getSSWalletCardModelVO()!;

    final String walletId =
        Get.find<StorageProvider>().getFasspayWalletId() ?? "";
    final String cardId = Get.find<StorageProvider>()
            .getSSWalletCardModelVO()
            ?.walletCardList
            ?.first
            .cardId ??
        "";
    FasspayBase response = await profileRepo.cdcvmValidation(
        CdcvmValidationRequest(walletId, CdcvmTransactionType.InAppPurchase));
    if (!response.isSuccess) {
      // comit failed txn
      isloading(false);
      Get.back();

      ComitRemit comit = ComitRemit(
          bpgTxnId: responseInitiate.data?.bpgTxnId,
          txnRefId: '',
          status: 'FAILED');

      logger('comit :: ${jsonEncode(comit)}');
      // comit failed txn
      await remittanceRepo.commitBillers(comit);

      AppSnackbar.errorSnackbar(title: response.errorMessage ?? "");
      return;
    }

    InAppPurchaseRequest request = InAppPurchaseRequest(
      walletId: walletId,
      cardId: cardId,
      amount: ((initiateBillerRequest!.data!.productAmount!) * 100)
          .toStringAsFixed(0),
      mid: merchantId!,
      productDesc: "Biller",
    );
    logger('request: ${jsonEncode(request)}');

    response = await remittanceRepo.performInAppPurchase(request);

    if (!response.isSuccess) {
      isloading(false);
      Get.back();
      ComitRemit comit = ComitRemit(
          bpgTxnId: responseInitiate.data?.bpgTxnId,
          txnRefId: '',
          status: 'FAILED');
      logger('comit :: ${jsonEncode(comit)}');
      // comit failed txn
      var responseComit = await remittanceRepo.commitBillers(comit);
      logger('responseComit ${jsonEncode(responseComit)}');
      AppSnackbar.errorSnackbar(title: response.errorMessage!);
      return;
    }

    logger('dapat sini');

    // Comit remit txn success

    SSSpendingModelVO ssSpendingModelVO =
        SSSpendingModelVO.fromJson(jsonDecode(response.payload!));

    var responseComit = await remittanceRepo.commitBillers(ComitRemit(
        bpgTxnId: responseInitiate.data?.bpgTxnId,
        txnRefId: ssSpendingModelVO.transactionId,
        status: 'SUCCESS'));

    if (verifyResponse(responseComit)) {
      logger('error comit');
    }
    responseComit as ComitRemitResponse;

    logger('res: ${jsonEncode(ssSpendingModelVO)}');

    var millis = ssSpendingModelVO.transactionDateTimeInMilis.toString();

    var dt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(millis),
      // isUtc: true
    );

    var date = DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    isloading(false);

    Get.toNamed(Routes.RECEIPT_MY, arguments: {
      'status': 'Success',
      'statusRemit': 'IN PROCESS',
      'amount': (num.parse(ssSpendingModelVO.spendingDetail!.amount!) / 100)
          .toStringAsFixed(2),
      'txnId': ssSpendingModelVO.transactionId,
      'cardBalance':
          'RM ${(num.parse(ssSpendingModelVO.selectedWalletCard!.cardBalance!) / 100).toStringAsFixed(2)}',
      'date': date,
      'category': 'Biller'
    });
  }
}
