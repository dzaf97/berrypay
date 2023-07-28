import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/locale_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/modules/register/views/register_view.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:berrypay_global_x/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_second_controller.dart';

class LoginSecondView extends GetView<LoginSecondController> {
  const LoginSecondView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
        ),
        body: Body(controller: controller),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final LoginSecondController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: "logo",
                  child: Image.asset("assets/images/logo.png", width: 50)),

              // Bullet
              const Row(children: [
                Bullet(status: ""),
                SizedBox(width: 5),
                Bullet(status: ""),
                SizedBox(width: 5),
                Bullet(status: "active"),
              ]),

              const SizedBox(
                height: 30,
              ),
              Obx(
                () => Text(
                  '${LocaleKeys.login_page_welcome_back_text.tr} ${controller.name}!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.login_page_log_into_text.tr,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => TextFieldWidget(
                    controller: controller.password,
                    obscureText: controller.toggleEye.value,
                    labelText: LocaleKeys.register_page_password_text.tr,
                    hintText: '********',
                    iconData: Icons.lock,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.toggleEye.value =
                            !controller.toggleEye.value;
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.register_page_enter_password_text.tr;
                      }
                      return null;
                    },
                  )),

              // Container(
              //   margin:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //   alignment: Alignment.bottomRight,
              //   child: InkWell(
              //     onTap: () {
              //       Get.toNamed(Routes.FORGOT_PASSWORD_MY);
              //     },
              //     // onTap: () => Get.toNamed(Routes.OTP, arguments: {
              //     //   "otp": Otp.nexmo,
              //     // }),
              //     child: Text(
              //       LocaleKeys.login_page_forgot_pass_text.tr,
              //       style: const TextStyle(color: Colors.blue),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              // const ForgotPassword(),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: AppButton.roundedIcon(
                            width: 180,
                            height: 48.0,
                            icon: Icons.arrow_forward,
                            title:
                                '${LocaleKeys.sign_in_text.tr}${isStaging ? ' - Staging' : ''}',
                            onTap: () async {
                              if (controller.loginFormKey.currentState!
                                  .validate()) {
                                controller.login(LoginRequest(
                                    login: controller.username.text,
                                    password: controller.password.text
                                    // grantType: "password",
                                    ));
                              }
                            }),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () async {
                  Locale locale;
                  if (Get.find<StorageProvider>().getLanguage() != null) {
                    locale = Locale(
                      Get.find<StorageProvider>().getLanguage()?.language ??
                          "en",
                      Get.find<StorageProvider>().getLanguage()?.countryCode ??
                          "US",
                    );
                  } else {
                    locale = Get.deviceLocale ?? const Locale("en", "US");
                  }

                  Get.find<StorageProvider>().box.erase();
                  await controller.secureStorage.deleteAll();

                  Get.toNamed(Routes.WELCOME,
                      arguments: controller.isJailbreak);

                  Get.updateLocale(locale);
                  Get.find<StorageProvider>().setLanguage(
                    LocaleModel(
                      language: locale.languageCode,
                      countryCode: locale.countryCode ?? "",
                    ),
                  );
                },
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      LocaleKeys.login_page_not_you.tr,
                      style: const TextStyle(color: Colors.blue),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
