import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_form_controller.dart';

class ForgotPasswordFormView extends GetView<ForgotPasswordFormController> {
  const ForgotPasswordFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(LocaleKeys.forgot_pass_page_forgot_password.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Body(
          controller: controller,
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => controller.isLoading.value
                  ? const BerryPayLoading()
                  : AppButton.rectangle(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.resetPassword();
                        }
                      },
                      title: LocaleKeys.submit_text.tr),
            )),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final ForgotPasswordFormController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/bp-logo.png',
                  width: 60,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                LocaleKeys.forgot_pass_page_please_enter_new_password.tr,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.forgot_pass_page_fill_in_details.tr,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFieldWidget(
                  obscureText: controller.toggleEye.value,
                  controller: controller.password,
                  suffix: IconButton(
                    onPressed: () {
                      logger('ontap');
                      controller.toggleEye.value = !controller.toggleEye.value;
                    },
                    icon: Obx(
                      () => controller.toggleEye.value
                          ? const Icon(
                              Icons.visibility,
                              size: 16,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              size: 16,
                            ),
                    ),
                  ),
                  labelText: LocaleKeys.forgot_pass_page_new_pass_hint.tr,
                  iconData: Icons.phone_android_outlined,
                  hintText: LocaleKeys.forgot_pass_page_new_pass_hint.tr,
                  validator: (value) {
                    final validCharacters = RegExp('[^A-Za-z0-9]');
                    final lowerCharacter = RegExp(r'[a-z]');
                    final lenReg = RegExp(r'^.{8,}$');
                    final upperCaseReg = RegExp(r'[A-Z]');
                    final numReg = RegExp(r'[0-9]');
                    if (value!.isEmpty) {
                      return LocaleKeys.kyc_page_enter_password.tr;
                    } else if (!lenReg.hasMatch(value)) {
                      return LocaleKeys
                          .register_page_enter_password_more_than_8_character_text
                          .tr;
                    } else if (!validCharacters.hasMatch(value)) {
                      return LocaleKeys
                          .register_page_enter_one_special_character_text.tr;
                    } else if (!value.contains(upperCaseReg)) {
                      return LocaleKeys
                          .register_page_enter_one_uppercase_character_text.tr;
                    } else if (!value.contains(numReg)) {
                      return LocaleKeys.register_page_enter_one_number_text.tr;
                    } else if (!lowerCharacter.hasMatch(value)) {
                      LocaleKeys
                          .register_page_enter_one_lowercase_character_text.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFieldWidget(
                  obscureText: controller.toggleEye2.value,
                  controller: controller.confirmPassword,
                  labelText:
                      LocaleKeys.forgot_pass_page_confirm_password_hint.tr,
                  iconData: Icons.phone_android_outlined,
                  hintText:
                      LocaleKeys.forgot_pass_page_confirm_password_hint.tr,
                  suffix: IconButton(
                    onPressed: () {
                      logger('ontap');
                      controller.toggleEye2.value =
                          !controller.toggleEye2.value;
                    },
                    icon: Obx(
                      () => controller.toggleEye2.value
                          ? const Icon(
                              Icons.visibility,
                              size: 16,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              size: 16,
                            ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.kyc_page_enter_password.tr;
                    } else if (controller.password.text != value) {
                      return LocaleKeys
                          .register_page_password_dont_match_text.tr;
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
