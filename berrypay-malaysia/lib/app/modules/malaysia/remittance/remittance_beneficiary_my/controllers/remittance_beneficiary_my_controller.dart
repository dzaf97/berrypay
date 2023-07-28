import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RemittanceBeneficiaryMyController extends GetxController {
  RemittanceBeneficiaryMyController(this.remittanceRepo);

  final RemittanceRepo remittanceRepo;
  RxList<DataBeneficiary>? getBeneficiaryResponse = <DataBeneficiary>[].obs;
  List<DatumResult> idType = [];
  CountryController countryController = Get.find();

  String? amount;
  String? country;
  String? currency;
  String? remitxId;
  String? receiverCountry;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    amount = Get.arguments["amount"];
    country = Get.arguments["country"];
    currency = Get.arguments["currency"];
    receiverCountry = Get.arguments["receiverCountry"];

    logger('amount: $amount');
    logger('country $receiverCountry');

    if (Get.find<StorageProvider>()
        .getProfileInfoResponse()!
        .wallet
        .where((element) => element.bizSysId == "REMITXMY")
        .isNotEmpty) {
      logger('remitx id::');
      remitxId = Get.find<StorageProvider>()
          .getProfileInfoResponse()!
          .wallet
          .where((element) => element.bizSysId == "REMITXMY")
          .first
          .bizSysUID!;

      logger('remitx id:: $remitxId');
    }

    await getDocType();
    await getBeneficiary();
  }

  getDocType() async {
    isLoading(true);
    var response = await remittanceRepo.getCustomerDocType();

    if (verifyResponse(response)) {
      isLoading(false);
      response as AppError;
      logger(response);
      return;
    }

    response as CustomerDocTypeResponse;

    idType = response.data!;

    logger('doc type: ${jsonEncode(response)}');

    isLoading(false);

    // selectedIdType?.value = customerDocTypeResponse[0].Data!;
    // logger(idType.AdditionalValue);
    // logger(getBeneficiaryResponse!.Beneficiarydetail!.Beneficiaryidtype);
  }

  getBeneficiary() async {
    isLoading(true);
    logger('remit : $remitxId');
    var response = await remittanceRepo.getBeneficiary(remitxId!);

    if (verifyResponse(response)) {
      isLoading(false);
      logger('error getBeneficiary');
      return;
    }

    response as GetBeneficiaryResponse;
    getBeneficiaryResponse?.value = response.data!;

    getBeneficiaryResponse?.value = getBeneficiaryResponse!
        .where((element) =>
            element.Beneficiarydetail!.Receivecurrencycode == currency)
        .toList();

    for (var element in getBeneficiaryResponse!) {
      if (element.Beneficiarydetail!.Beneficiaryidtype!.isNotEmpty) {
        var idDocType = idType.firstWhere(
          (id) => id.Data == element.Beneficiarydetail!.Beneficiaryidtype,
        );

        logger('iddoc ${jsonEncode(idDocType)}');

        var country = countryController.countries.firstWhere((country) =>
            country.cca3 == element.Addressinfo!.Addresscountrycode);

        logger(jsonEncode(country));

        // logger(country.name?.common);

        element.Beneficiarydetail!.Beneficiaryidtype = idDocType.Value;
        // element.Addressinfo?.Addresscountrycode = country.name!.common;
        logger(element.Beneficiarydetail!.Beneficiaryidtype);
        logger(element.Addressinfo?.Addresscountrycode);
      }
    }

    isLoading(false);
  }

  viewDetails(index) async {
    final result = await Get.toNamed(Routes.BENEFICIARY_INFO_MY, arguments: {
      "data": getBeneficiaryResponse![index],
      'amount': amount,
      'calcBy': Get.arguments['calcBy'],
    });
    logger('viewDetails $result ');

    if (result == true) {
      getDocType();
    }
  }
}
