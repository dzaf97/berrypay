import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:berrypay_global_x/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SafeArea(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(height: GetPlatform.isAndroid ? 30 : 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Hero(
                        tag: "logo",
                        child:
                            Image.asset("assets/images/logo.png", width: 50)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                    child: AutoSizeText(
                      LocaleKeys.login_page_welcome_back_text.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      maxLines: 1,
                      minFontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 30, 16),
                    child: Text(
                      LocaleKeys.login_page_log_into_text.tr,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // TextFieldWidget(
                  //   labelText: 'Phone Number',
                  //   iconData: Icons.phone_android,
                  //   hintText: 'xxxxxxxx',
                  // ).paddingSymmetric(horizontal: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 20),
                    // margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              LocaleKeys.phone_num.tr,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.username,
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
                                  if (value!.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  if (value[0] == '0') {
                                    return "Please do not input '0'";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => TextFieldWidget(
                      controller: controller.password,
                      obscureText: controller.toggleEye.value,
                      labelText: LocaleKeys.login_page_pass_field_hint.tr,
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
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  // PhoneField(
                  //   username: controller.username,
                  //   selectedCode: controller.selectedCode,
                  //   focusNode: controller.fnOne,
                  // ),
                  // PasswordField(
                  //     controller: controller, focusNode: controller.fnTwo),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.FORGOT_PASSWORD_MY);
                      },
                      // onTap: () => Get.toNamed(Routes.OTP, arguments: {
                      //   "otp": Otp.nexmo,
                      // }),
                      child: Text(
                        LocaleKeys.login_page_forgot_pass_text.tr,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
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
                                title: '${LocaleKeys.sign_in_text.tr}${isStaging ? ' - Staging' : ''}',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
