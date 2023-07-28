import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_my_controller.dart';

class ForgotPasswordMyView extends GetView<ForgotPasswordMyController> {
  const ForgotPasswordMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                        controller.checkPhoneNo();
                      }
                    },
                    title: LocaleKeys.proceed.tr),
          )),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.controller});

  final ForgotPasswordMyController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/bp-logo.png',
              width: 60,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            '${LocaleKeys.forgot_pass_page_forgot_password.tr}?'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColor.primary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.forgot_pass_page_forgot_pass_desc.tr,
            textAlign: TextAlign.center,
          ).paddingOnly(left: 8, right: 8),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: controller.formKey,
            child: Container(
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
                        LocaleKeys.phoneNum_field_hint.tr,
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
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.phone_android,
                        color: Colors.black87,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '+60',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: controller.mobileNo,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                              hintText: 'xxxxxxxxx',
                              border: InputBorder.none,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey)),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys
                                  .profile_page_please_enter_phone_number_text
                                  .tr;
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${LocaleKeys.forgot_pass_page_remember_password.tr} ',
              style: Theme.of(context).textTheme.bodySmall,
              children: <TextSpan>[
                TextSpan(
                    text: LocaleKeys.login_page_login.tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
                      },
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColor.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
