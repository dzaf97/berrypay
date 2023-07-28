import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/remitx/bill.dart';
import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class PostpaidTopupController extends GetxController {
  final BillRepo billRepo;

  PostpaidTopupController(this.billRepo);

  // TextEditingController amountTopup = TextEditingController();
  MoneyMaskedTextController amountTopup =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: '');
  TextEditingController phoneNo = TextEditingController();
  TextEditingController telco = TextEditingController();

  RxList<Map<String, String>> formFields = <Map<String, String>>[].obs;
  final List<TextEditingController> formController = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DataPostpaid? dataPostpaid;

  double? maxAmount;
  double? minAmount;

  @override
  void onInit() {
    dataPostpaid = Get.arguments['dataPostpaid'];
    telco.text = dataPostpaid!.product!;

    formFields.value = dataPostpaid!.formField!.obs;

    maxAmount = double.tryParse(
        dataPostpaid!.option!.max!.split("pattern").last.split("RM").last);
    minAmount = double.tryParse(
        dataPostpaid!.option!.min!.split("pattern").last.split("RM").last);
    logger(maxAmount);
    for (int i = 0; i < formFields.length; i++) {
      formController.add(TextEditingController());
    }

    logger(jsonEncode(dataPostpaid));
    super.onInit();
  }

  submit() async {
    if (formFields.length > 1) {
      // submit model with keyValues

      List<Item> item = [];
      for (int i = 0; i < formFields.length; i++) {
        item.add(Item(
          value: formController[i].text,
          key: formFields[i].entries.first.key,
        ));
      }

      KeyValues keyValues = KeyValues(item: item);

      BillPurchaseRequest request = BillPurchaseRequest(
          msisdn: phoneNo.text,
          // msisdn: "06171102082",
          productCode: dataPostpaid?.productCode,
          // productCode: "PMSPS",
          value: formController[0].text,
          keyValues: keyValues);

      logger(jsonEncode(request));

      var response = await billRepo.billPurchase(request);
      if (verifyResponse(response)) {
        AppSnackbar.errorSnackbar(title: 'Try again');
        return;
      }
    } else {
      DataRequest data = DataRequest(
          amount: (num.parse(amountTopup.text)),
          msisdn: formController[0].text,
          paymentMode: 'Payment Gateway',
          paymentModeSubCat: 'FPX',
          paymentModeTxnRef: '',
          paymentModeStatus: '',
          productAmount: num.parse(amountTopup.text),
          productCode: dataPostpaid?.productCode);

      InitiateBillerRequest initiateBillerRequest =
          InitiateBillerRequest(data: data);

      logger(jsonEncode(initiateBillerRequest));

      Get.toNamed(Routes.PAYMENT_METHOD_MY, arguments: {
        'initiateBillerRequest': initiateBillerRequest,
        'category': 'Biller'
      });

      // normal
    }
  }
}
