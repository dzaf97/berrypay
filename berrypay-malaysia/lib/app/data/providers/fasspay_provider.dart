import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/cdcvm/cdcvm_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/otp/otp_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/change_mobile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/register/register.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/spending/spending_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/topup/topup.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transfer/transfer_model.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const channel = "com.berrypay.malaysia.channel";

class FasspayProvider {
  static const platform = MethodChannel(channel);

  Future<void> initSdk() async {
    logger("initSdk start", name: 'FasspayRepo');
    String response = await platform.invokeMethod("/init");
    FasspayBase.fromJson(jsonDecode(response));
    logger("initSdk end", name: 'FasspayRepo');
  }

  Future<FasspayBase> performInit(String? walletId) async {
    logger("performInit start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod("/perform-init", walletId ?? "");
    logger("performInit response :: $raw", name: 'FasspayRepo');
    logger("performInit end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performInitialMyInfo() async {
    logger("performInitialMyInfo start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod("/perform-initial-my-info");
    logger("performInitialMyInfo response :: $raw", name: 'FasspayRepo');
    logger("performInitialMyInfo end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performLogin(String walletId) async {
    logger("performLogin start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod("/perform-login", walletId);
    logger("performLogin response :: $raw", name: 'FasspayRepo');
    logger("performLogin end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performSetupCdcvmPin(String walletId) async {
    logger("performSetupCdcvmPin start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-setup-cdcvm-pin", walletId);
    logger("performSetupCdcvmPin response :: $raw", name: 'FasspayRepo');
    logger("performSetupCdcvmPin end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performCdcvmValidation(
      CdcvmValidationRequest request) async {
    logger("performCdcvmValidation start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-cdcvm-validation", request.toJson());
    logger("performCdcvmValidation response :: $raw", name: 'FasspayRepo');
    logger("performCdcvmValidation end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performChangeCdcvmPin(String walletId) async {
    logger("performChangeCdcvmPin start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-change-cdcvm-pin", walletId);
    logger("performChangeCdcvmPin response :: $raw", name: 'FasspayRepo');
    logger("performChangeCdcvmPin end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performLogout(String walletId) async {
    logger("performLogout start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod("/perform-logout", walletId);
    logger("performLogout response :: $raw", name: 'FasspayRepo');
    logger("performLogout end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performRegister(RegisterRequest request) async {
    logger("performRegister start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-register", request.toJson());
    logger("performRegister response :: $raw", name: 'FasspayRepo');
    logger("performRegister end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performOTPValidation(SSOtpModelVO request) async {
    logger("performOTPValidation start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-otp-validation", request.toJson());
    logger("performOTPValidation response :: $raw", name: 'FasspayRepo');
    logger("performOTPValidation end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performRegisterContinue(SSUserProfileVO request) async {
    logger("performRegisterContinue start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-register-continue", request.toJson());
    logger("performRegisterContinue response :: $raw", name: 'FasspayRepo');
    logger("performRegisterContinue end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performSyncData(String walletId) async {
    logger("performSyncData start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod("/perform-sync-data", walletId);
    logger("performSyncData response :: $raw", name: 'FasspayRepo');
    logger("performSyncData end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performTopUpCheckStatus(
      TopUpCheckStatusRequest request) async {
    logger("performTopUpCheckStatus start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-topup-check-status", request.toJson());
    logger("performTopUpCheckStatus response :: $raw", name: 'FasspayRepo');
    logger("performTopUpCheckStatus end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performTopUp(TopUpRequest request) async {
    logger("performTopUp start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-topup", request.toJson());

    logger("performTopUp response :: $raw", name: 'FasspayRepo');
    logger("performTopUp end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performOtpResend(SSOtpModelVO request) async {
    logger("performOtpResend start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-otp-resend", request.toJson());
    logger("performOtpResend response :: $raw", name: 'FasspayRepo');
    logger("performOtpResend end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performSpending(SpendingRequest request) async {
    logger("performSpending start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-spending", request.toJson());
    logger("performSpending response :: $raw", name: 'FasspayRepo');
    logger("performSpending end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performConfirmSpending(SpendingRequest request) async {
    logger("performConfirmSpending start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-confirm-spending", request.toJson());
    logger("performConfirmSpending response :: $raw", name: 'FasspayRepo');
    logger("performConfirmSpending end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performValidateProfile(
      SSUserProfileVO request, String walletId) async {
    logger("performValidateProfile start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-validate-profile", [request.toJson(), walletId]);
    logger("performValidateProfile response :: $raw", name: 'FasspayRepo');
    logger("performValidateProfile end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performUpdateProfile(
      SSUserProfileVO request, String walletId) async {
    logger("performUpdateProfile start", name: 'FasspayRepo');
    String raw = await platform
        .invokeMethod("/perform-update-profile", [request.toJson(), walletId]);
    logger("performUpdateProfile response :: $raw", name: 'FasspayRepo');
    logger("performUpdateProfile end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performSpendingQrRequest(
      SpendingQrRequest request) async {
    logger("performSpendingQrRequest start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-spending-qr-request", request.toJson());
    logger("performSpendingQrRequest response :: $raw", name: 'FasspayRepo');
    logger("performSpendingQrRequest end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performSpendingQRCheckStatus(
      SpendingQrRequest request) async {
    logger("performSpendingQRCheckStatus start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-spending-qr-check-status", request.toJson());
    logger("performSpendingQRCheckStatus response :: $raw",
        name: 'FasspayRepo');
    logger("performSpendingQRCheckStatus end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performWithdrawalCheck(
      String walletId, String cardId) async {
    logger("performWithdrawalCheck start", name: 'FasspayRepo');
    String raw = await platform
        .invokeMethod("/perform-withdrawal-check", [walletId, cardId]);
    logger("performWithdrawalCheck response :: $raw", name: 'FasspayRepo');
    logger("performWithdrawalCheck end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performWithdrawal(
      String walletId, String cardId, SSWithdrawalDetailVO request) async {
    logger("performWithdrawal start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-withdrawal", [walletId, cardId, request.toJson()]);
    logger("performWithdrawal response :: $raw", name: 'FasspayRepo');
    logger("performWithdrawal end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performConfirmWithdrawal(
      String walletId, String cardId, String transactionRequestId) async {
    logger("performConfirmWithdrawal start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod("/perform-confirm-withdrawal",
        [walletId, cardId, transactionRequestId]);
    logger("performConfirmWithdrawal response :: $raw", name: 'FasspayRepo');
    logger("performConfirmWithdrawal end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performVerifyP2P(
      String walletId, List<String> phoneNumbers) async {
    logger("performVerifyP2P start", name: 'FasspayRepo');
    String raw = await platform
        .invokeMethod("/perform-verify-p2p", [walletId, phoneNumbers]);
    logger("performVerifyP2P response :: $raw", name: 'FasspayRepo');
    logger("performVerifyP2P end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performVerifyP2PBarcode(
      VerifyP2PBarcodeRequest request) async {
    logger("performVerifyP2PBarcode start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-verify-p2p-barcode", request.toJson());
    logger("performVerifyP2PBarcode response :: $raw", name: 'FasspayRepo');
    logger("performVerifyP2PBarcode end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performTransferP2P(TransferP2PRequest request) async {
    logger("performTransferP2P start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-transfer-p2p", request.toJson());
    logger("performTransferP2P response :: $raw", name: 'FasspayRepo');
    logger("performTransferP2P end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performChangeMobileNo(
      ChangeMobileNoRequest request) async {
    logger("performChangeMobileNo start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-change-mobile-no", request.toJson());
    logger("performChangeMobileNo response :: $raw", name: 'FasspayRepo');
    logger("performChangeMobileNo end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performGetProfileBarcode(String walletId) async {
    logger("performGetProfileBarcode start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-get-profile-barcode", walletId);
    logger("performGetProfileBarcode response :: $raw", name: 'FasspayRepo');
    logger("performGetProfileBarcode end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performInAppPurchase(InAppPurchaseRequest request) async {
    logger("performInAppPurchase start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-in-app-purchase", request.toJson());
    logger("performInAppPurchase response :: $raw", name: 'FasspayRepo');
    logger("performInAppPurchase end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performRequestHistory(
      String walletId, String cardId) async {
    logger("performRequestHistory start", name: 'FasspayRepo');
    String raw = await platform
        .invokeMethod("/perform-request-history", [walletId, cardId]);
    logger("performRequestHistory response :: $raw", name: 'FasspayRepo');
    logger("performRequestHistory end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performRequestP2P(Requestp2p request) async {
    logger("performRequestP2P start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-request-p2p", request.toJson());
    logger("performRequestP2P response :: $raw", name: 'FasspayRepo');
    logger("performRequestP2P end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performGetTransactionHistory(
      String walletId, String cardId, String pagingNo) async {
    // logger("performGetTransactionHistory start", name: 'FasspayRepo');
    String raw = await platform.invokeMethod(
        "/perform-get-transaction-history", [walletId, cardId, pagingNo]);
    // logger("performGetTransactionHistory response :: $raw", name: 'FasspayRepo');
    // logger("performGetTransactionHistory end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> performResetCdcvmPIN(String walletId) async {
    logger("performResetCdcvmPIN start", name: 'FasspayRepo');
    String raw =
        await platform.invokeMethod("/perform-reset-cdcvm-pin", walletId);
    logger("performResetCdcvmPIN response :: $raw", name: 'FasspayRepo');
    logger("performResetCdcvmPIN end", name: 'FasspayRepo');
    return FasspayBase.fromJson(jsonDecode(raw));
  }

  Future<FasspayBase> test(Map<String, dynamic> request) async {
    String raw = await platform.invokeMethod("/test", request);

    return FasspayBase.fromJson(jsonDecode(raw));
  }

  handleError(String code) {
    if (code == "80000") {
      Get.offNamedUntil(Routes.SPLASH, ModalRoute.withName(Routes.SPLASH));
    }
  }
}
