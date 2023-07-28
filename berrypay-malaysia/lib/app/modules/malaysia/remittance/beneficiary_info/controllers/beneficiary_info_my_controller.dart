import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryInfoMyController extends GetxController {
  BeneficiaryInfoMyController(this.remittanceRepo);

  final RemittanceRepo remittanceRepo;

  DataBeneficiary? getBeneficiaryResponse;
  String? amount;
  RxBool isLoading = false.obs;
  String? agentName;
  String? countryName;

  List<DatumResult> paymentModeResponse = [];
  List<DataAgent> agentResponse = [];
  List<DatumResult> bankListResponse = [];
  List<DataAgent> agentFilter = [];
  CountryController countryController = Get.find();

  RxString selectedPaymentMode = "".obs;
  RxString selectedPaymentCode = "".obs;
  RxString selectedAgent = "".obs;

  @override
  void onInit() {
    getBeneficiaryResponse = Get.arguments['data'];
    amount = Get.arguments['amount'];
    logger('amount: $amount');
    super.onInit();
    if (getBeneficiaryResponse!.Addressinfo!.Addresscountrycode!.isNotEmpty) {
      getCountry();
    }
    getPaymentMode();
    // getDocType();
  }

  getBankList() async {
    isLoading(true);

    logger('getBeneficiaryResponse : ${jsonEncode(getBeneficiaryResponse)}');

    if (getBeneficiaryResponse!.Addressinfo!.Addresscountrycode!.isEmpty) {
      logger('empty ni');
      // AppSnackbar.errorSnackbar(title: 'hello');
      // Get.back();
      return;
    }

    var response = await remittanceRepo
        .getBankList(getBeneficiaryResponse!.Addressinfo!.Addresscountrycode!);

    if (verifyResponse(response)) {
      logger('error 2');
      return;
    }

    response as BankListResponse;

    logger('response bank : ${jsonEncode(response)}');

    bankListResponse = response.data ?? [];
    var bankCode = getBeneficiaryResponse!.Beneficiarydetail!.Bankcode;

    logger('bank code xx $bankCode');

    List<DatumResult> filter = bankListResponse
        .where(
          (element) => element.Data!.contains(bankCode!),
        )
        .toList();

    logger(jsonEncode(filter));

    logger('bank ${filter[0].Value}');

    agentFilter = agentResponse
        .where(
          (element) =>
              element.LocationName!.contains(filter[0].Value!.toUpperCase()),
        )
        .toList();

    logger('agentt filter ${jsonEncode(agentFilter)}');

    if (agentFilter.isNotEmpty) {
      agentName = agentFilter[0].LocationId;
      return;
    }

    isLoading(false);
  }

  onSubmit() async {
    Get.toNamed(Routes.CONFIRMATION_REMITTANCE_MY, arguments: {
      'amount': amount,
      'calcBy': Get.arguments['calcBy'],
      'data': getBeneficiaryResponse,
      'paymentMode': selectedPaymentMode.value,
      'agent': agentName
    });
  }

  getPaymentMode() async {
    isLoading(true);

    var response = await remittanceRepo.getPaymentMode(
        getBeneficiaryResponse!.Beneficiarydetail!.Countrycode!);

    if (verifyResponse(response)) {
      logger('error 3');
      return;
    }

    response as PaymentModeResponse;
    paymentModeResponse = response.data ?? [];
    selectedPaymentMode.value = paymentModeResponse[0].Data!;
    selectedPaymentCode.value = paymentModeResponse[0].AdditionalValue!;
    isLoading(false);

    getAgent(AgentRequest(
        paymentMode: paymentModeResponse[0].Data!,
        payoutCountry: getBeneficiaryResponse!.Beneficiarydetail!.Countrycode
            ?.toUpperCase()));
  }

  getAgent(AgentRequest request) async {
    logger('request ${jsonEncode(request)}');
    var response = await remittanceRepo.agent(request);

    if (verifyResponse(response)) {
      logger('error 1');
      return;
    }

    response as AgentResponse;
    agentResponse = response.data!;

    if (agentResponse.isNotEmpty) {
      selectedAgent.value = agentResponse[0].LocationId!;
      logger(selectedAgent.value);
      getBankList();
    }

    logger('agent :: ${jsonEncode(agentResponse)}');
  }

  getCountry() {
    var country = countryController.countries.firstWhere((country) =>
        country.cca3 ==
        getBeneficiaryResponse!.Addressinfo!.Addresscountrycode);

    logger(jsonEncode(country));

    countryName = country.name!.common;
  }

  editBeneficiary() async {
    final result = await Get.toNamed(Routes.REMITTANCE_FORM_MY, arguments: {
      "data": getBeneficiaryResponse,
      "receiverCountry": getBeneficiaryResponse?.Addressinfo?.Addresscountrycode
    });

    logger('viewBeneficiaryDetails $result');

    if (result == true) {
      logger('if (result) $result');

      // Get.back(result: true);
      Navigator.of(Get.context!).pop(true);
    }
  }
}
