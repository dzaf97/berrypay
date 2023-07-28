import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/local_widgets/input_amount_field.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/local_widgets/rate_summary.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/remittance_my_controller.dart';
import '../local_widgets/bottom_bar.dart';

class RemittanceMyView extends GetView<RemittanceMyController> {
  const RemittanceMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            LocaleKeys.remittance_remittance.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: const Alignment(5.0, 1.0), //Alignment.bottomRight,
              colors: [Colors.red[800]!, Colors.blue[800]!],
            ),
          ),
          child: Obx(
            () => controller.isLoading.value
                ? const BerryPayLoading()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        InputAmountField(
                          onChanged: (value) =>
                              controller.calculcateReceive(value),
                          country: 'MYR',
                          image: 'https://flagcdn.com/w320/my.png',
                          title: LocaleKeys.remittance_you_pay.tr,
                          hintText: '1.00',
                          textController: controller.sendController,
                        ),
                        RateSummary(
                          transferFee: controller.transferFee,
                          payableAmount: controller.payableAmount,
                          rate: controller.rate,
                        ),
                        InputAmountField(
                          onChanged: (value) => controller.calculateSend(value),
                          country: controller.currency.toString().toUpperCase(),
                          image: '${controller.country}',
                          title: LocaleKeys.remittance_estimated.tr,
                          hintText: controller.rate,
                          isChoosable: true,
                          textController: controller.receivedController,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BottomBar(onSubmit: () => controller.getKycStatus()),
        ),
      ),
    );
  }
}
