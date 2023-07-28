import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/remittance_beneficiary_my/controllers/remittance_beneficiary_my_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemittanceFormMyController extends GetxController {
  RemittanceFormMyController(this.remittanceRepo);

  final RemittanceRepo remittanceRepo;

  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController bankAcc = TextEditingController();
  TextEditingController purpose = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController beneficiaryId = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController poscode = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController branchCode = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController branchName = TextEditingController();
  //  Get.put(CountryController(RegisterRepo()));

  CountryController countryController = Get.find();

  String? amount;
  RxBool isLoading = false.obs;
  RxBool isLoad = false.obs;

  TransferOfFundsResponse? transferOfFundsResponse;

  String? remitxId;

  DataBeneficiary? getBeneficiaryResponse;

  List<DatumResult> sourceOfFund = [];
  List<DatumResult> bankListResponse = [];
  List<DatumResult> transactionPurposeResponse = [];
  List<DatumResult> availableCountryResponse = [];
  List<DatumResult> relationshipResponse = [];
  List<DatumResult> paymentModeResponse = [];
  List<DatumResult> customerDocTypeResponse = [];
  RxList<DataAgent> agentResponse = <DataAgent>[].obs;
  List<DataBranchCode> branchCodeResponse = [];

  RxString? selectedSourceFund = "".obs;
  RxString? selectedRelationship = "".obs;
  RxString? selectedIdType = "".obs;
  RxString? selectedOccupation = "".obs;
  RxString? selectedBankList = "".obs;
  RxString? selectedTransactionPurpose = "".obs;
  RxString? selectedPaymentMode = "".obs;
  RxString? selectedPaymentCode = "".obs;
  RxString? selectedAgent = "".obs;
  RxString? selectedAgentBank = "".obs;
  RxString? selectedId = "".obs;
  String? selectedBankName;

  String? receiverCountry;
  String? currency;
  RxString? beneficiaryCountry = "".obs;

  // Initial Selected Value
  RxString selectedGender = 'Female'.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    branchName.addListener(() {
      branchCode.clear();
    });

    district.addListener(() {
      branchName.clear();
    });

    getBeneficiaryResponse = Get.arguments['data'];
    getCustomerDocType();

    remitxId = Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "REMITXMY")
        .first
        .bizSysUID!;

    amount = Get.arguments['amount'];
    receiverCountry = Get.arguments['receiverCountry'];
    logger('receiverCountry $receiverCountry');
    currency = Get.arguments['currency'];

    if (Get.previousRoute == Routes.BENEFICIARY_INFO_MY) {
      firstName = TextEditingController(
          text:
              '${getBeneficiaryResponse?.Nameenglish?.Firstname} ${getBeneficiaryResponse?.Nameenglish?.Lastname}');

      lastName = TextEditingController(
          text: getBeneficiaryResponse?.Nameenglish?.Lastname ?? '');

      beneficiaryId = TextEditingController(
          text:
              getBeneficiaryResponse?.Beneficiarydetail?.Beneficiaryidnumber ??
                  '');

      phoneNum = TextEditingController(
          text: getBeneficiaryResponse?.Mobilenumber ?? '');

      address1 = TextEditingController(
          text: getBeneficiaryResponse?.Addressinfo?.Addressstreet ?? '');

      address2 = TextEditingController(
          text: getBeneficiaryResponse?.Addressinfo?.Addresscitytown ?? '');

      address3 = TextEditingController(
          text:
              getBeneficiaryResponse?.Addressinfo?.Addressstateprovince ?? '');

      poscode = TextEditingController(
          text: getBeneficiaryResponse?.Addressinfo?.Zipcode ?? '');

      bankAcc = TextEditingController(
          text: getBeneficiaryResponse?.Beneficiarydetail?.Accountnumber ?? '');

      selectedIdType?.value =
          getBeneficiaryResponse?.Beneficiarydetail?.Beneficiaryidtype ?? '';

      selectedRelationship?.value =
          getBeneficiaryResponse?.Relationshipwithbeneficiarycode ?? '';
    }
  }

  onSubmit() async {
    isLoad(true);
    String? idBeneficiary = getBeneficiaryResponse?.BeneficiaryId;

    if (idBeneficiary == null) {
      isLoad(true);
      logger('selectedPaymentMode?.value');
      BeneficiaryDetail beneficiaryDetail = BeneficiaryDetail(
        Countrycode: receiverCountry?.toUpperCase(),
        Countryname: beneficiaryCountry?.value,
        // Remittancemethodcode:
        //     selectedPaymentCode?.value,
        Remittancemethodcode:
            selectedPaymentCode?.value, //payment mode bank transfer
        Bankname: selectedAgentBank?.value,
        Branchname: branchName.text,
        Accountnumber: bankAcc.text,
        Bankcode: selectedAgent?.value,
        Branchcode: branchCode.text,
        Receivecurrencycode: currency?.toUpperCase(),
        Beneficiaryidnumber: beneficiaryId.text,
        Beneficiaryidtype: selectedIdType?.value,
        Beneficiaryidissuedcountrycode: '',
      );

      NameEnglish nameEnglish = NameEnglish(
          Firstname: firstName.text,
          Middlename: middleName.text,
          Lastname: lastName.text,
          Lastname2: '');

      AddressInfo addressInfo = AddressInfo(
          Zipcode: poscode.text,
          Addresscountrycode: receiverCountry?.toUpperCase(),
          Addressstateprovince: address3.text,
          Addresscitytown: address2.text,
          Addressstreet: address1.text);

      BeneficiaryInfo beneficiaryinfo = BeneficiaryInfo(
        Birthday: "",
        Gender: "",
        Telephonenumber: "",
        Mobilenumber: phoneNum.text,
        Emailaddress: "",
        Relationshipwithbeneficiarycode: selectedRelationship?.value,
        Remittancereasoncode: selectedTransactionPurpose?.value,
        Beneficiarydetail: beneficiaryDetail,
        Nameenglish: nameEnglish,
        Addressinfo: addressInfo,
        Sourceoffundscode: selectedSourceFund?.value,
      );

      AddBeneficiaryRequest request = AddBeneficiaryRequest(
          CustomerId: remitxId,
          Requiredtradepassword: false,
          Beneficiaryinfo: beneficiaryinfo);

      logger(jsonEncode(request));
      var response = await remittanceRepo.addBeneficiary(request);

      if (verifyResponse(response)) {
        response as AppError;
        isLoad(false);
        AppSnackbar.errorSnackbar(title: response.message);
        return;
      }

      Get.find<RemittanceBeneficiaryMyController>().getBeneficiary();

      // AppSnackbar.successSnackbar(title: 'Success');

      AddBeneficiaryResponse addBeneficiaryResponse = response;

      DataBeneficiary dataBeneficiary = addBeneficiaryResponse.data!;

      logger('dataBeneficiary ${jsonEncode(dataBeneficiary)}');
      isLoad(false);

      Get.offAndToNamed(Routes.CONFIRMATION_REMITTANCE_MY, arguments: {
        'amount': amount,
        'calcBy': Get.arguments['calcBy'],
        'data': dataBeneficiary,
        'paymentMode': selectedPaymentMode?.value,
        'agent': selectedAgent!.value
      });
    } else {
      isLoad(true);
      logger('masuk else');
      UpdateBeneficiaryRequest updateBeneficiaryRequest =
          UpdateBeneficiaryRequest(
        customerId: remitxId,
        beneficiaryId: idBeneficiary,
        beneficiaryName: firstName.text,
        countryCode: getBeneficiaryResponse?.Addressinfo?.Addresscountrycode,
        currencyCode:
            getBeneficiaryResponse?.Beneficiarydetail?.Receivecurrencycode,
        mobileNumber: phoneNum.text,
        emailAddress: email.text,
        telNo: '',
        relationship: selectedRelationship!.value,
        accountNo: bankAcc.text,
        remittanceMethodCode:
            selectedPaymentCode?.value, //payment mode bank transfer
      );

      logger(
          'updateBeneficiaryRequest : ${jsonEncode(updateBeneficiaryRequest)}');

      var response = await remittanceRepo.updateBeneficary(
          idBeneficiary, updateBeneficiaryRequest);

      if (verifyResponse(response)) {
        isLoad(false);
        AppSnackbar.errorSnackbar(
            title: LocaleKeys.remittance_error_edit_ben.tr);
        return;
      }

      isLoad(false);
      response as UpdateBeneficiaryResponse;
      Get.back(result: true);
      // Get.offAndToNamed(Routes.REMITTANCE_BENEFICIARY_MY);

      // Get.offAndToNamed(Routes.BENEFICIARY_INFO_MY,
      //     arguments: {'data': response.data});
      // Get.offNamed(Routes.REMITTANCE_BENEFICIARY_MY);
      // Get.back(result: {'data': response.data});

      // Get.offAndToNamed(Routes.REMITTANCE_BENEFICIARY_MY);
      // Get.toNamed(Routes.REMITTANCE_BENEFICIARY_MY);

      AppSnackbar.successSnackbar(title: LocaleKeys.remittance_success_edit.tr);
    }
  }

  getCustomerDocType() async {
    isLoading(true);
    var response = await remittanceRepo.getCustomerDocType();

    if (verifyResponse(response)) {
      isLoading(false);
      response as AppError;
      logger(response);

      // AppSnackbar.errorSnackbar(title: '');
      return;
    }

    response as CustomerDocTypeResponse;

    customerDocTypeResponse = response.data ?? [];

    for (var element in customerDocTypeResponse) {
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }

    // selectedIdType?.value = customerDocTypeResponse[0].Data!;

    isLoading(false);
    getTransferOfFund();
    // getBankList();
  }

  getBankList() async {
    isLoading(true);

    var response = await remittanceRepo.getBankList(receiverCountry!);

    if (verifyResponse(response)) {
      logger('error');
      response as AppError;
      return;
    }

    response as BankListResponse;

    bankListResponse = response.data ?? [];
    selectedBankList?.value = bankListResponse[0].Value!;
    isLoading(false);

    getTransferOfFund();
  }

  getTransferOfFund() async {
    isLoading(true);

    var response = await remittanceRepo.transferOfFunds();

    if (verifyResponse(response)) {
      logger('error');
      return;
    }

    response as TransferOfFundsResponse;

    sourceOfFund = response.data ?? [];
    selectedSourceFund?.value = sourceOfFund[0].Data!;

    for (var element in sourceOfFund) {
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }

    isLoading(false);
    getTransactionPurpose();
  }

  getTransactionPurpose() async {
    isLoading(true);

    TransactionPurposeResponse transactionPurpose =
        await remittanceRepo.getTransactionPurpose();
    transactionPurposeResponse = transactionPurpose.data ?? [];

    selectedTransactionPurpose?.value = transactionPurposeResponse[0].Data!;

    for (var element in transactionPurposeResponse) {
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }

    logger('getTransactionPurpose ${jsonEncode(transactionPurposeResponse)}');

    isLoading(false);

    getRelationship();
  }

  getAvailableCountry() async {
    isLoading(true);
    AvailableCountryResponse availableCountry =
        await remittanceRepo.getAvailableCountry();
    availableCountryResponse = availableCountry.data ?? [];
    isLoading(false);
  }

  getRelationship() async {
    isLoading(true);
    RelationshipResponse relationship = await remittanceRepo.getRelationship();
    relationshipResponse = relationship.data ?? [];

    selectedRelationship?.value = relationshipResponse[0].Data!;

    if (Get.previousRoute == Routes.BENEFICIARY_INFO_MY) {
      var relationship = relationshipResponse.firstWhere((element) =>
          element.Data ==
          getBeneficiaryResponse?.Relationshipwithbeneficiarycode);

      selectedRelationship?.value = relationship.Data!;
    }

    for (var element in relationshipResponse) {
      final regex = RegExp('[^A-Za-z0-9]');
      element.Value = element.Value!.replaceAll(regex, "");
    }

    isLoading(false);
    getPaymentMode();
    getCountry();
  }

  getPaymentMode() async {
    isLoading(true);

    var response = await remittanceRepo.getPaymentMode(receiverCountry ??
        getBeneficiaryResponse!.Addressinfo!.Addresscountrycode!);

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

    selectedPaymentMode?.value = paymentModeResponse[0].Data!;
    logger('selectedPaymentMode?.value ${selectedPaymentMode?.value}');
    selectedPaymentCode?.value = paymentModeResponse[0].AdditionalValue!;

    isLoading(false);

    getAgent(AgentRequest(
        paymentMode: selectedPaymentMode?.value,
        payoutCountry: receiverCountry?.toUpperCase() ??
            getBeneficiaryResponse?.Addressinfo?.Addresscountrycode));
  }

  getAgent(AgentRequest request) async {
    var response = await remittanceRepo.agent(request);

    if (verifyResponse(response)) {
      logger('error ke');
      return;
    }

    response as AgentResponse;
    agentResponse.value = response.data!;
    selectedAgent?.value = agentResponse[0].LocationId!;
    selectedAgentBank?.value = agentResponse[0].LocationName!;
  }

  getCountry() {
    logger('masuk je tak');
    if (receiverCountry != null) {
      Country ccaCountry = countryController.countries
          .firstWhere((element) => element.cca3 == receiverCountry);

      beneficiaryCountry?.value = ccaCountry.name!.common!;
    }

    // return cca;
  }

  getBranchCode(String districtName, String bankName, String q) async {
    var response =
        await remittanceRepo.getBranchCode(districtName, bankName, q);

    if (verifyResponse(response)) {
      logger('Cannot get branch Code');
      return [];
    }

    response as BranchCodeResponse;

    logger(jsonEncode(response));

    return response.data!;
  }

  getDistrict(String bankName, String q) async {
    var response = await remittanceRepo.getDistrict(bankName, q);

    if (verifyResponse(response)) {
      logger('Cannot get district');
      return [];
    }
    response as DistrictResponse;
    return response.data;
  }
}
