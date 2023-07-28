import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prepaid_topup_form_controller.dart';

class PrepaidTopupFormView extends GetView<PrepaidTopupFormController> {
  const PrepaidTopupFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(250, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          LocaleKeys.biller_prepaid.tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Body(
          controller: controller,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton.rectangle(
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              if (controller.amountTopup == null) {
                AppSnackbar.errorSnackbar(title: 'Please enter amount');
              } else {
                controller.submit();
              }
            }
          },
          title: 'Next',
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });
  final PrepaidTopupFormController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info,
                  color: Colors.amber,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  LocaleKeys.biller_please_ensure_all_information.tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                  border: Border.all(
                      color: Colors.grey.shade200.withOpacity(0.05))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Telco",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '*',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.red),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                  const Divider(
                    height: 26,
                    thickness: 1.2,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: controller.telco,
                    readOnly: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColor.black)
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        errorMaxLines: 2,
                        border: InputBorder.none,
                        // hintText: 'AA',
                        icon: const Icon(Icons.sensors_outlined),
                        // fillColor:
                        //     enabled ?? true ? Colors.white : Colors.grey.shade300,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.formFields.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, String> fields = controller.formFields[index];
                  List<Widget> widgets = [];

                  fields.forEach((key, value) {
                    widgets.add(TextFieldWidget(
                      divider: true,
                      iconData: Icons.phone_android,
                      onChanged: (value) {
                        // logger(controller.formFields[index][key]);
                      },
                      regex: r'[0-9]',
                      keyboardType: value.contains("Numeric")
                          ? const TextInputType.numberWithOptions(
                              decimal: false,
                            )
                          : null,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please enter $key";
                        }
                        if (text.length >= 10 && text.length <= 12) {
                          return null;
                        } else {
                          return "Invalid Mobile Number";
                        }
                      },
                      controller: controller.formController[index],
                      labelText: key,
                      hintText: value,
                    ).paddingOnly(bottom: 20));

                    logger(controller.formController[index].text);
                  });

                  return Column(
                    children: widgets,
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 20, right: 20),
              // margin: const EdgeInsets.only(top: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                  border: Border.all(
                      color: Colors.grey.shade200.withOpacity(0.05))),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        LocaleKeys.amount_text.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '*',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.red),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomRadioButton(
                    // horizontal: true,
                    margin: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    radius: 10,
                    shapeRadius: 10,
                    enableButtonWrap: true,
                    height: Get.height * 0.1,
                    width: Get.width * 0.21,
                    spacing: Get.width * 0.05,
                    enableShape: true,
                    elevation: 0,
                    // absoluteZeroSpacing: true,
                    unSelectedColor: Colors.white,
                    buttonLables: controller.dataPrepaid!.option!,
                    buttonValues: controller.dataPrepaid!.option!,
                    unSelectedBorderColor: Colors.grey.shade300,
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(fontSize: 12)),
                    radioButtonValue: (value) {
                      controller.amountTopup = value;
                      logger(value);
                    },
                    selectedColor: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
