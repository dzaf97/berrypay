import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/postpaid_topup_controller.dart';

class PostpaidTopupView extends GetView<PostpaidTopupController> {
  const PostpaidTopupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: const Text(
          'Postpaid Topup',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(child: Body(controller: controller)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton.rectangle(onTap: () {
          if (controller.formKey.currentState!.validate()) {
            controller.submit();
          }
        }),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });
  final PostpaidTopupController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please refer to your bill for account details.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 10,
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

                  fields.forEach(
                    (key, value) {
                      widgets.add(TextFieldWidget(
                        regex: r'[0-9]',
                        controller: controller.formController[index],
                        keyboardType: value.contains("Numeric")
                            ? const TextInputType.numberWithOptions(
                                decimal: false,
                              )
                            : null,
                        divider: true,
                        iconData: Icons.phone_android_outlined,
                        labelText: key,
                        hintText: value,
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
                      ).paddingOnly(bottom: 20));
                    },
                  );

                  return Column(
                    children: widgets,
                  );
                },
              ),
            ),
            TextFieldWidget(
              divider: true,
              controller: controller.amountTopup,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              iconData: Icons.money,
              labelText: 'Amount',
              hintText:
                  '${controller.dataPostpaid?.option?.max}, ${controller.dataPostpaid?.option?.min}',
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter amount";
                }

                if (double.parse(value) < controller.minAmount!) {
                  return "Minimum amount RM${controller.minAmount!.toStringAsFixed(2)}";
                }

                if (double.parse(value) > controller.maxAmount!) {
                  return "Maximum amount RM${controller.maxAmount!.toStringAsFixed(2)}";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
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
                  'Any excess amount paid on top of the bill amount will be auto-deducted from your next bill payment',
                  style: Theme.of(context).textTheme.bodySmall,
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
                  'In the event of bill payment exceeding our amount limit, you may split the payment amount into another checkout.',
                  style: Theme.of(context).textTheme.bodySmall,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
