import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/text_info.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/wallet_info_my_controller.dart';

class WalletInfoMyView extends GetView<WalletInfoMyController> {
  const WalletInfoMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: WillPopScope(
        onWillPop: () async {
          if (Get.previousRoute == Routes.SCAN_TRANSFER_MY) {
            Get.close(2);
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            title: Text(
              LocaleKeys.request_wallet_info.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.request_recipient_wallet_info.tr.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    LocaleKeys.request_recipient_wallet_info.tr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    // margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                              offset: const Offset(0, 5)),
                        ],
                        border: Border.all(
                            color: Colors.grey.shade200.withOpacity(0.05))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInfo(
                            title: LocaleKeys.kyc_page_name.tr,
                            subtitle: controller.userProfileVO?.fullName ?? "",
                          ),
                          const SizedBox(height: 20),
                          TextInfo(
                            title: LocaleKeys.phoneNum_field_hint.tr,
                            subtitle: controller.userProfileVO?.mobileNo ?? "",
                          ),
                          const SizedBox(height: 20),
                          TextInfo(
                            title: 'Wallet ID',
                            subtitle: controller
                                    .userProfileVO?.profileSettings?.walletId ??
                                "",
                          ),
                          Obx(
                            () => controller.isConfirmAmount.value
                                ? Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      TextInfo(
                                        title: LocaleKeys.amount_text.tr,
                                        subtitle:
                                            'RM ${controller.amount.text}',
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          )
                        ]),
                  ),
                  Obx(() => !controller.isConfirmAmount.value
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: controller.formKey,
                              child: TextFieldWidget(
                                keyboardType: TextInputType.number,
                                controller: controller.amount,
                                textInputAction: TextInputAction.done,
                                labelText: LocaleKeys.amount_text.tr,
                                hintText: LocaleKeys.enter_amount.tr,
                                iconData: Icons.money,
                                isRequired: true,
                                onChanged: (value) {
                                  logger(value);
                                  // if value.isEmpty
                                  controller.amount.text =
                                      value.isNotEmpty ? value : "0.00";

                                  String newValue = value
                                      .replaceAll(',', '')
                                      .replaceAll('.', '');
                                  if (value.isEmpty || newValue == '00') {
                                    // controller.amount.clear();
                                    controller.amount.text == "0.00";
                                    // isFirst = true;
                                    return;
                                  }
                                  double value1 = double.parse(newValue);
                                  // if (!isFirst) value1 = value1 * 100;
                                  value = NumberFormat.currency(
                                          customPattern: '######.##')
                                      .format(value1 / 100);
                                  controller.amount.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: value.length),
                                  );
                                  logger('hello ${controller.amount.text}');
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.enter_amount.tr;
                                  } else if (value == "0.0") {
                                    return LocaleKeys.enter_amount.tr;
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox())
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Obx(() => controller.isLoading.value
                    ? const BerryPayLoading()
                    : Row(
                        children: [
                          Obx(
                            () => controller.isConfirmAmount.value
                                ? Expanded(
                                    child: AppButton.rounded(
                                      onTap: controller.setIsConfirmAmount,
                                      title: LocaleKeys.back.tr,
                                      type: ButtonType.secondary,
                                      border: Colors.red.withOpacity(0.8),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          Obx(() => controller.isConfirmAmount.value
                              ? const SizedBox(width: 8)
                              : const SizedBox()),
                          Expanded(
                              flex: 3,
                              child: Obx(
                                () => AppButton.rounded(
                                  onTap: controller.isConfirmAmount.value
                                      ? controller.onProceed
                                      : controller.setIsConfirmAmount,
                                  // onTap: () {
                                  //   controller.formKey.currentState!.validate()
                                  //       ? controller.isConfirmAmount.value
                                  //           ? controller.onProceed
                                  //           : controller.setIsConfirmAmount
                                  //       : null;
                                  // },
                                  title: controller.isConfirmAmount.value
                                      ? LocaleKeys.proceed.tr
                                      : LocaleKeys.confirm_text.tr,
                                ),
                              )),
                        ],
                      ))),
          ),
        ),
      ),
    );
  }
}
