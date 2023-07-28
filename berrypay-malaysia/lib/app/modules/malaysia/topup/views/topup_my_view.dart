import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/topup_my_controller.dart';

class TopupMyView extends GetView<TopupMyController> {
  const TopupMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Top Up',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.topUp_page_topup_wallet.tr.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Text(
                //   controller.accountType == ProfileType.ProfileTypePersonal
                //       ? 'Enter amount up to RM200'
                //       : 'Enter amount up to RM10,000',
                //   style: Theme.of(context).textTheme.caption,
                // ),

                FilledButton(
                    onPressed: null,
                    child:
                        Text('RM ${(num.parse(controller.balance!) / 100)}')),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: controller.formKey,
                  child: TextFieldWidget(
                    // onChanged: (value) {
                    //   logger(value);
                    //   // if value.isEmpty
                    //   controller.amount.text =
                    //       value.isNotEmpty ? value : "0.00";

                    //   String newValue =
                    //       value.replaceAll(',', '').replaceAll('.', '');
                    //   if (value.isEmpty || newValue == '00') {
                    //     // controller.amount.clear();
                    //     controller.amount.text == "0.00";
                    //     // isFirst = true;
                    //     return;
                    //   }
                    //   double value1 = double.parse(newValue);

                    //   // if (!isFirst) value1 = value1 * 100;
                    //   value = NumberFormat.currency(customPattern: '######.##')
                    //       .format(value1 / 100);
                    //   controller.amount.value = TextEditingValue(
                    //     text: value,
                    //     selection:
                    //         TextSelection.collapsed(offset: value.length),
                    //   );
                    //   logger('hello ${controller.amount.text}');
                    // },
                    controller: controller.amountTopup,
                    textInputAction: TextInputAction.done,
                    labelText: LocaleKeys.topUp_page_amount.tr,
                    hintText: 'Cash In (RM)',
                    iconData: Icons.money,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      logger(
                          'controller.accountType : ${controller.accountType}');
                      value =
                          value?.replaceAll("\\p{Sc}", "").replaceAll(",", "");
                      logger('controller.accountType : $value');
                      if (value!.isEmpty || value == "0.00") {
                        return LocaleKeys
                            .topUp_page_error_message_enter_amount.tr;
                      } else if (num.parse(controller.balance!) < 190.01 &&
                          controller.accountType == ProfileType.Personal &&
                          num.parse(value) < 10) {
                        return LocaleKeys
                            .topUp_page_error_message_min_amount.tr;
                      } else if (num.parse(controller.balance!) < 1490.01 &&
                          controller.accountType ==
                              ProfileType.PersonalPremium &&
                          num.parse(value) < 10) {
                        return LocaleKeys
                            .topUp_page_error_message_min_amount.tr;
                      } else if (controller.accountType ==
                              ProfileType.Personal &&
                          num.parse(value) > 200) {
                        return LocaleKeys
                            .topUp_page_error_message_max_topup_basic.tr;
                      } else if (controller.accountType ==
                              ProfileType.PersonalPremium &&
                          num.parse(value) > 10000) {
                        return LocaleKeys
                            .topUp_page_error_message_max_topup_premium.tr;
                      }
                      // else if (num.parse(controller.balance!) > 1000 && controller.accountType == ProfileType.Personal) {
                      //   return "You are not allowed to topup";
                      // }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AmountButton(amount: '10', controller: controller),
                    AmountButton(amount: '20', controller: controller),
                    AmountButton(amount: '50', controller: controller),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AmountButton(amount: '100', controller: controller),
                    AmountButton(amount: '300', controller: controller),
                    AmountButton(amount: '200', controller: controller),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Obx(
            () => controller.isLoading.isTrue
                ? const BerryPayLoading()
                : AppButton.rounded(
                    title: LocaleKeys.proceed.tr,
                    border: Colors.red,
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.proceedTopUp();
                      }
                    },
                  ),
          )),
    );
  }
}

class AmountButton extends StatelessWidget {
  const AmountButton({Key? key, required this.amount, required this.controller})
      : super(key: key);

  final String amount;
  final TopupMyController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.onClick(amount);
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
            border: Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
        child: Text('RM $amount', textAlign: TextAlign.center),
      ),
    );
  }
}
