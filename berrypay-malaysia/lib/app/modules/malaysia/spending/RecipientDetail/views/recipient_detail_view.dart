import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/custom_keyboard.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/recipient_detail_controller.dart';

class RecipientDetailMyView extends GetView<RecipientDetailMyController> {
  const RecipientDetailMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.close(2);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: AppColor.black,
          elevation: 0,
          title: const Text(
            'Pay',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      child: Text(controller.spendingDetail!.merchantName![0])),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        controller.spendingDetail!.merchantName!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        controller.spendingDetail!.mid!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Text(
              "How much do you want to pay?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              'Balance: RM${controller.cardBalance!.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Expanded(
              child: CustomKeyBoard(
                onChanged: (value) {
                  logger(value);
                  // if value.isEmpty
                  controller.amount.text = value.isNotEmpty ? value : "0.00";

                  String newValue =
                      value.replaceAll(',', '').replaceAll('.', '');
                  if (value.isEmpty || newValue == '00') {
                    // controller.amount.clear();
                    controller.amount.text == "0.00";
                    // isFirst = true;
                    return;
                  }
                  double value1 = double.parse(newValue);

                  // if (!isFirst) value1 = value1 * 100;
                  value = NumberFormat.currency(customPattern: '######.##')
                      .format(value1 / 100);
                  controller.amount.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                  logger('hello ${controller.amount.text}');
                },
                onbuttonClick: () {
                  if (kDebugMode) {
                    logger('clicked');
                  }
                },
                maxLength: 8,
                amount: controller.amount,
              ),
            )
          ],
        ),
        // body: SingleChildScrollView(child: Body(controller: controller)),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => controller.isLoading.value
              ? const Center(child: BerryPayLoading())
              : AppButton.rectangle(
                  title: 'Pay Now',
                  onTap: () {
                    if (controller.amount.text.isEmpty) {
                      return Get.defaultDialog(
                        title: "Error",
                        titlePadding: const EdgeInsets.only(top: 20),
                        content: const Text(
                          "Please enter amount!",
                          textAlign: TextAlign.center,
                        ),
                        onConfirm: () => Get.back(),
                        confirmTextColor: Colors.white,
                      );
                    } else if (controller.amount.text == "0.00") {
                      return Get.defaultDialog(
                        title: "Error",
                        titlePadding: const EdgeInsets.only(top: 20),
                        content: const Text(
                          "Amount cannot be zero",
                          textAlign: TextAlign.center,
                        ),
                        onConfirm: () => Get.back(),
                        confirmTextColor: Colors.white,
                      );
                    } else if (num.parse(controller.amount.text) >
                        controller.cardBalance!) {
                      return Get.defaultDialog(
                        title: "Error",
                        titlePadding: const EdgeInsets.only(top: 20),
                        content: const Text(
                          "You have insufficient balance to transfer. Please top up to continue",
                          textAlign: TextAlign.center,
                        ),
                        onConfirm: () => Get.back(),
                        confirmTextColor: Colors.white,
                      );
                    } else if (num.parse(controller.amount.text) > 200 &&
                        controller.accountType == ProfileType.Personal) {
                      return Get.defaultDialog(
                        title: "Error",
                        titlePadding: const EdgeInsets.only(top: 20),
                        content: const Text(
                          "Max spending limit per transaction is RM 200.",
                          textAlign: TextAlign.center,
                        ),
                        onConfirm: () => Get.back(),
                        confirmTextColor: Colors.white,
                      );
                    } else if (num.parse(controller.amount.text) > 1500 &&
                        controller.accountType == ProfileType.PersonalAdvance) {
                      return Get.defaultDialog(
                        title: "Error",
                        titlePadding: const EdgeInsets.only(top: 20),
                        content: const Text(
                          "Max spending limit per transaction is RM 1500.",
                          textAlign: TextAlign.center,
                        ),
                        onConfirm: () => Get.back(),
                        confirmTextColor: Colors.white,
                      );
                    } else {
                      controller.payNow();
                    }
                  },
                )),
        ),
      ),
    );
  }
}
