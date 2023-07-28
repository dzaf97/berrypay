import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_mobile_no_controller.dart';

class ChangeMobileNoMyView extends GetView<ChangeMobileNoMyController> {
  const ChangeMobileNoMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Change Mobile Number'),
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
      ),
      body: BodyForm(controller: controller),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppButton.roundedIcon(
          title: 'Submit',
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              // logger(controller.newMobile.text);
              controller.submit();
            }
          },
        ),
      ),
    );
  }
}

class BodyForm extends StatelessWidget {
  const BodyForm({super.key, required this.controller});

  final ChangeMobileNoMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFieldWidget(
              controller: controller.newMobile,
              labelText: 'New Number',
              iconData: Icons.phone_android_outlined,
              hintText: 'xxx xxxxxxx',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your new number';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
