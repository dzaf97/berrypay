import 'dart:convert';
import 'dart:developer';
import 'package:berrypay_global_x/app/core/utils/functions/interceptor.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/signature.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/bpg/otp.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/bill.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/model/remitx/sender.dart';
import 'package:berrypay_global_x/app/data/model/remitx/transaction.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class BpgMyProvider extends GetConnect {
  Map<String, String> defaultHeader = {};
  final GenerateSignature generateSignature = GenerateSignature();

  @override
  void onInit() {
    httpClient.baseUrl = dotenv.env['URL'];

    httpClient.addRequestModifier(apisixInterceptor);
    httpClient.addAuthenticator(keycloakInterceptor);
  }

  getVersion(String clientOs) async {
    logger("Starts", name: "BpgMyProvider-getVersion");

    var response =
        await httpClient.get("bpg-my/public/version?clientOs=$clientOs");
    if (response.status.isOk) {
      logger("getVersion: ${response.bodyString}",
          name: "BpgMyProvider-getVersion");
      Version version = Version.fromJson(response.body);

      return version;
    } else {
      logger("Error: ${response.bodyString}", name: "BpgMyProvider-getVersion");
      return AppError(message: "Fetch version failed.");
    }
  }

  getExchangeRate() async {
    logger(Get.find<StorageProvider>().getToken()!);
    var response = await httpClient.get(
      "bpg-my/v1/remit/config/exchange-rate",
      headers: {"Content-Type": "application/json"},
    );

    logger(response.bodyString);
    if (response.status.isOk) {
      ExchangeRateResponse exchangeRateResponse =
          ExchangeRateResponse.fromJson(response.body);

      return exchangeRateResponse;
    } else if (response.status.isUnauthorized) {
      return AppError(message: 'Token expired');
    } else {
      if (response.body != null) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
        return AppError(
            message: errorResponse.data?.message ?? errorResponse.message!);
      }
      return AppError(message: 'Something went wrong');
    }
  }

  transferofFunds() async {
    var response = await httpClient.get("bpg-my/v1/remit/config/source-of-fund",
        headers: {"Content-Type": "application/json"});

    // logger(response.body);

    if (response.status.isOk) {
      TransferOfFundsResponse transferOfFundsResponse =
          TransferOfFundsResponse.fromJson(response.body);

      logger('transferOfFundsResponse ${jsonEncode(transferOfFundsResponse)}');

      return transferOfFundsResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getBeneficiary(String beneficiaryId) async {
    logger('beneficiaryId $beneficiaryId');

    var body = {"customerId": beneficiaryId};

    var response = await httpClient.post(
      "bpg-my/v1/remit/beneficiary/get",
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    logger(response.body);

    if (response.status.isOk) {
      GetBeneficiaryResponse getBeneficiaryResponse =
          GetBeneficiaryResponse.fromJson(response.body);

      return getBeneficiaryResponse;
    } else {
      // ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: 'Something went wrong');
    }
  }

  getBankList(String country) async {
    var response = await httpClient.get("bpg-my/v1/remit/config/bank/$country",
        headers: {"Content-Type": "application/json"});

    logger(response.bodyString);

    if (response.status.isOk) {
      BankListResponse bankListResponse =
          BankListResponse.fromJson(response.body);

      return bankListResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getTransactionPurpose() async {
    var response = await httpClient.get(
      "bpg-my/v1/remit/config/transaction-purpose",
      headers: {"Content-Type": "application/json"},
    );

    logger(response.bodyString);

    if (response.status.isOk) {
      logger('sini getTransactionPurpose');
      TransactionPurposeResponse transactionPurposeResponse =
          TransactionPurposeResponse.fromJson(response.body);

      logger(jsonEncode(transactionPurposeResponse));
      return transactionPurposeResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getAvailableCountry() async {
    var response = await httpClient.get(
      "bpg-my/v1/remit/config/available-country",
      headers: {"Content-Type": "application/json"},
    );

    if (response.status.isOk) {
      AvailableCountryResponse availableCountryResponse =
          AvailableCountryResponse.fromJson(response.body);

      return availableCountryResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getRelationship() async {
    var response = await httpClient.get(
      "bpg-my/v1/remit/config/relationship",
      headers: {"Content-Type": "application/json"},
    );

    if (response.status.isOk) {
      RelationshipResponse relationshipResponse =
          RelationshipResponse.fromJson(response.body);
      return relationshipResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getCustomerDocType() async {
    var response = await httpClient
        .get("bpg-my/v1/remit/config/customer-doc-id", headers: {
      "Content-Type": "application/json",
    });

    logger(response.bodyString);

    if (response.status.isOk) {
      logger('masuk status');
      CustomerDocTypeResponse customerDocTypeResponse =
          CustomerDocTypeResponse.fromJson(response.body);

      return customerDocTypeResponse;
    } else {
      // logger('masuk else');
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getOccupation() async {
    var response = await httpClient.get(
      "bpg-my/v1/remit/config/occupation",
      headers: {"Content-Type": "application/json"},
    );

    if (response.status.isOk) {
      OccupationResponse occupationResponse =
          OccupationResponse.fromJson(response.body);
      return occupationResponse;
    } else {
      logger(response.body);
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  agent(AgentRequest request) async {
    // var signature = generateSignature.generateSignature(request.toJson());

    // logger('signature :: $signature');

    var response = await httpClient.post(
      "bpg-my/v1/remit/config/agent",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );

    if (response.status.isOk) {
      AgentResponse agentResponse = AgentResponse.fromJson(response.body);

      logger('agentResponse signature :: ${agentResponse.signature}');

      return agentResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  transferFee(TransferFeeRequest request) async {
    // var response = await httpClient.post("bpg-my/v1/remit/config/transfer-fee",
    var response = await httpClient.post(
      "bpg-my/v1/remit/config/calculate-fee",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );

    logger(jsonEncode(request));

    // generateSignature.generateSignature(request.toJson(), );

    logger(response.bodyString);

    if (response.status.isOk) {
      TransferFeeResponse transferFeeResponse =
          TransferFeeResponse.fromJson(response.body);

      return transferFeeResponse;
    } else {
      if (response.body != null) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
        return AppError(message: errorResponse.data!.message!);
      }
      return AppError(message: 'Something went wrong');
    }
  }

  registerSender(SenderRegisterRequest request) async {
    var response = await httpClient.post(
      "bpg-my/v1/remit/sender/register",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );

    logger(response.bodyString);
    if (response.status.isOk) {
      SenderRegisterResponse senderRegisterResponse =
          SenderRegisterResponse.fromJson(response.body);

      return senderRegisterResponse;
    } else {
      if (response.body != null) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
        return AppError(
            message: errorResponse.data?.message ??
                errorResponse.message ??
                'Something went wrong');
      }
      return AppError(message: 'Something went wrong');
    }
  }

  getPaymentMode(String country) async {
    var response = await httpClient.get(
      "bpg-my/v1/remit/config/available-payment-method/$country",
      headers: {"Content-Type": "application/json"},
    );

    if (response.status.isOk) {
      PaymentModeResponse paymentModeResponse =
          PaymentModeResponse.fromJson(response.body);
      return paymentModeResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  addBeneficiary(AddBeneficiaryRequest request) async {
    var response = await httpClient.post(
      "bpg-my/v1/remit/beneficiary/add",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );
    logger(response.bodyString);

    if (response.status.isOk) {
      AddBeneficiaryResponse addBeneficiaryResponse =
          AddBeneficiaryResponse.fromJson(response.body);

      return addBeneficiaryResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  initiateTransaction(PayRequest request) async {
    var response = await httpClient.post(
      "bpg-my/v1/transaction/initiate",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );

    logger(response.bodyString);

    if (response.status.isOk) {
      PayResponse payResponse = PayResponse.fromJson(response.body);

      logger('payresponse :: ${jsonEncode(payResponse)}');

      return payResponse;
    } else {
      if (response.body == null) {
        return AppError(message: 'Something went wrong');
      }
      PayResponse payResponse = PayResponse.fromJson(response.body);

      return AppError(
          message: payResponse.initiateMessage ?? 'Something went wrong');
    }
  }

  updateBeneficiary(String beneficiaryId,
      UpdateBeneficiaryRequest updateBeneficiaryRequest) async {
    var response = await httpClient.put(
      "bpg-my/v1/remit/beneficiary/update?id=$beneficiaryId",
      body: updateBeneficiaryRequest.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    // logger('request 1 ${jsonEncode(updateBeneficiaryRequest)}');

    logger('response: ${response.body}');

    if (response.status.isOk) {
      logger('masuk');
      UpdateBeneficiaryResponse updateBeneficiaryResponse =
          UpdateBeneficiaryResponse.fromJson(response.body);
      return updateBeneficiaryResponse;
    } else {
      // ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: 'False to update');
    }
  }

  getFpxTransaction(PaymentRequeryRequest request) async {
    var response = await httpClient.post(
      "bpg-my/v1/transaction/requery",
      body: request.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    logger('get Fpx Transaction ${response.bodyString}');
    if (response.status.isOk) {
      PaymentRequeryResponse paymentRequeryResponse =
          PaymentRequeryResponse.fromJson(response.body);
      return paymentRequeryResponse;
    } else {
      return AppError(message: 'Error');
    }
  }

  getSenderDetails(String senderId) async {
    var body = {"customerId": senderId};
    log('response sender: ${httpClient.baseUrl}');
    var response = await httpClient.post(
      "bpg-my/v1/remit/sender/query",
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    log('response sender: ${response.request!.headers}');

    if (response.status.isOk) {
      QuerySenderResponse querySenderResponse =
          QuerySenderResponse.fromJson(response.body);

      return querySenderResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(
          message: errorResponse.data?.message ?? 'Something went wrong!');
    }
  }

  requestOtp(RequestOtp requestOtp) async {
    var response = await httpClient.post("bpg-my/public/v1/otp/verify-sms",
        body: requestOtp.toJson(),
        headers: {
          "Content-Type": "application/json",
        });

    logger(response.bodyString);

    if (response.status.isOk) {
      RequestOtpResponse requestOtpResponse =
          RequestOtpResponse.fromJson(response.body);
      return requestOtpResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);

      return AppError(message: errorResponse.data!.message!);
    }
  }

  validateOtp(ValidateOtpRequest validateOtpRequest) async {
    var response = await httpClient.post("bpg-my/public/v1/otp/validate-sms",
        headers: {
          "Content-Type": "application/json",
        },
        body: validateOtpRequest.toJson());

    if (response.status.isOk) {
      ValidateOtpResponse validateOtpResponse =
          ValidateOtpResponse.fromJson(response.body);
      return validateOtpResponse;
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(message: errorResponse.data!.message!);
    }
  }

  getBulkOnboardingDetails(String phoneNo) async {
    var response = await httpClient.get(
      // "bpg-my/v1/profile/check-no/$phoneNo",
      "bpg-my/public/v1/profile/check-no/$phoneNo",
      headers: {
        "Content-Type": "application/json",
      },
    );

    logger(httpClient.baseUrl);
    logger(response.body);

    if (response.status.isOk) {
      logger('response ok');
      GetOnboardingDetailsResponse getOnboardingDetailsResponse =
          GetOnboardingDetailsResponse.fromJson(response.body);
      return getOnboardingDetailsResponse;
    } else {
      logger('response tak ok');
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
      return AppError(
          message: errorResponse.data?.message ?? 'Something went wrong.');
    }
  }

  getKycStatus(String phoneNo) async {
    var response = await httpClient.get(
      "bpg-my/v1/profile/check-kyc/$phoneNo",
      headers: {"Content-Type": "application/json"},
    );

    logger(response.body);

    if (response.status.isOk) {
      GetKycStatus getKycStatus = GetKycStatus.fromJson(response.body);
      return getKycStatus;
    } else {
      return AppError(message: "Something went wrong");
    }
  }

  getDocType(String country) async {
    var response = await httpClient.get(
      "bpg-my/public/v1/profile/document-sub-type/$country",
      //  "bpg-my/v1/profile/document-sub-type/$country",
      headers: {
        "Content-Type": "application/json",
      },
    );

    // logger('response id ${response.body}');
    if (response.status.isOk) {
      GetDocType docType = GetDocType.fromJson(response.body);
      return docType;
    } else {
      return AppError(message: 'Something went wrong');
    }
  }

  getState() async {
    var response = await httpClient.get(
      "bpg-my/public/v1/profile/state",
      headers: {"Content-Type": "application/json"},
    );

    if (response.status.isOk) {
      StateResponse stateResponse = StateResponse.fromJson(response.body);
      return stateResponse;
    } else {
      return AppError(message: 'Something went wrong');
    }
  }

  displayTransferFee(String currency, String country) async {
    logger('currency $currency');
    logger('country $country');
    var body = {"country": country, "currency": currency};
    var response = await httpClient.post(
      "bpg-my/v1/remit/transfer-fee",
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    logger(response.bodyString);

    if (response.status.isOk) {
      GetTransferFee getTransferFee = GetTransferFee.fromJson(response.body);
      return getTransferFee;
    } else {
      return AppError(message: 'Something went wrong');
    }
  }

  getPrepaidList() async {
    var response = await httpClient.get(
      "bpg-my/v1/bill/prepaid",
      headers: {"Content-Type": "application/json"},
    );

    logger('response:: ${response.bodyString}');
    if (response.status.isOk) {
      PrepaidListResponse prepaidListResponse =
          PrepaidListResponse.fromJson(response.body);
      return prepaidListResponse;
    } else {
      return AppError(message: "Something went wrong");
    }
  }

  getPostpaidList() async {
    var response = await httpClient.get(
      "bpg-my/v1/bill/postpaid",
      headers: {"Content-Type": "application/json"},
    );

    logger(response.bodyString);

    if (response.status.isOk) {
      PostpaidListResponse postpaidListResponse =
          PostpaidListResponse.fromJson(response.body);
      logger(postpaidListResponse.data?[0].option?.max);
      return postpaidListResponse;
    } else {
      return AppError(message: 'Something went wrong');
    }
  }

  billPurchase(BillPurchaseRequest request) async {
    var response = await httpClient.post(
      "url",
      body: request.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    if (response.status.isOk) {
    } else {
      return AppError(message: 'Something went wrong!');
    }
  }

  commitRemit(ComitRemit request) async {
    var response = await httpClient.post(
      "bpg-my/v1/transaction/commit-remit",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );

    if (response.status.isOk) {
      logger(response.bodyString);
      ComitRemitResponse comitRemit =
          ComitRemitResponse.fromJson(response.body);
      return comitRemit;
    } else {
      ComitRemitResponse comitRemitResponse =
          ComitRemitResponse.fromJson(response.body);

      return AppError(
          message: comitRemitResponse.commitMessage ?? "Something went wrong!");
    }
  }

  initiateBiller(InitiateBillerRequest request) async {
    var response = await httpClient.post(
      "bpg-my/v1/bill/initiate",
      headers: {"Content-Type": "application/json"},
      body: request.toJson(),
    );
    log('response.bodyString! ${response.bodyString!}');

    if (response.status.isOk) {
      InitiateBillerResponse initiateBillerResponse =
          InitiateBillerResponse.fromJson(response.body);
      return initiateBillerResponse;
    } else {
      InitiateBillerResponse initiateBillerResponse =
          InitiateBillerResponse.fromJson(response.body);

      return AppError(
          message: initiateBillerResponse.data?.statusDescription ??
              'Something went wrong!');
    }
  }

  commitBiller(ComitRemit request) async {
    logger('request:: ${jsonEncode(request)}');
    var response = await httpClient.post("bpg-my/v1/transaction/commit-billers",
        body: request.toJson());

    log('response comitBiller :: ${response.bodyString}');

    logger('code:: ${response.statusCode}');

    if (response.status.isOk) {
      ComitRemitResponse comitBillers =
          ComitRemitResponse.fromJson(response.body);
      return comitBillers;
    } else {
      if (response.body == null) {
        return AppError(message: 'Something went wrong!');
      }

      ComitRemitResponse comitBillers =
          ComitRemitResponse.fromJson(response.body);

      return AppError(
          message: comitBillers.commitMessage ?? 'Something went wrong!');
    }
  }

  getBranchCode(String districtName, String bankName, String q) async {
    final queryParam = {
      'district-name': districtName,
      'bank-name': bankName,
      'q': q
    };
    var response = await httpClient.get("bpg-my/v1/remit/config/branch-name",
        query: queryParam);

    logger(response.bodyString);

    if (response.status.isOk) {
      return BranchCodeResponse.fromJson(response.body);
    } else {
      return AppError(message: 'Something went wrong');
    }
  }

  getDistrict(String bankName, String q) async {
    logger(bankName);
    final params = {'bank-name': bankName, 'q': q};

    var response =
        await httpClient.get("bpg-my/v1/remit/config/dist-name", query: params);

    logger(response.bodyString);

    if (response.status.isOk) {
      return DistrictResponse.fromJson(response.body);
    } else {
      return AppError(message: 'Something went wrong');
    }
  }
}
