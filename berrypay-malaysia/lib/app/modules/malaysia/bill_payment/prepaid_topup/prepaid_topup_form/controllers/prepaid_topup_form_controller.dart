import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/remitx/bill.dart';
import 'package:berrypay_global_x/app/data/repositories/bill_repo.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrepaidTopupFormController extends GetxController {
  final BillRepo billRepo;
  PrepaidTopupFormController(this.billRepo);

  String? amountTopup;
  TextEditingController phoneNo = TextEditingController();
  TextEditingController telco = TextEditingController();
  RxList<Map<String, String>> formFields = <Map<String, String>>[].obs;
  RxBool selected = false.obs;
  final List<TextEditingController> formController = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DataPrepaid? dataPrepaid;

  @override
  void onInit() {
    dataPrepaid = Get.arguments['dataPrepaid'];

    // formFields.value = [
    //   {"Mobile Number": "Numeric 10"},
    //   {"Mobile ": "Numeric 0"},
    //   {" Number": "Numeric 30"},
    // ].obs;

    formFields.value = dataPrepaid!.formField!.obs;
    telco.text = dataPrepaid!.product!;

    for (int i = 0; i < formFields.length; i++) {
      formController.add(TextEditingController());
    }
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

      // KeyValues keyValues = KeyValues(item: item);

      // BillPurchaseRequest request = BillPurchaseRequest(
      //     msisdn: phoneNo.text,
      //     productCode: dataPrepaid?.productCode,
      //     value: formController[0].text,
      //     keyValues: keyValues);

      // logger(jsonEncode(request));

      // var response = await billRepo.billPurchase(request);
      // if (verifyResponse(response)) {
      //   AppSnackbar.errorSnackbar(title: 'Try again');
      //   return;
      // }
    } else {
      // normal

      DataRequest data = DataRequest(
          amount: (num.parse(amountTopup!)),
          msisdn: formController[0].text,
          paymentMode: 'Payment Gateway',
          paymentModeSubCat: 'FPX',
          paymentModeTxnRef: '',
          paymentModeStatus: '',
          productAmount: num.parse(amountTopup!),
          productCode: dataPrepaid?.productCode);

      InitiateBillerRequest initiateBillerRequest =
          InitiateBillerRequest(data: data);

      logger(jsonEncode(initiateBillerRequest));

      Get.toNamed(Routes.PAYMENT_METHOD_MY, arguments: {
        'initiateBillerRequest': initiateBillerRequest,
        'category': 'Biller'
      });
    }
  }
}
