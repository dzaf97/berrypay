import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/otp/local_widgets/pin_widget.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.white,
            foregroundColor: AppColor.black,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/envelope.png',
                      width: 150,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      LocaleKeys.otp_otp_verification.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      LocaleKeys.otp_verification.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => FilledButton(
                          onPressed: null,
                          child: Text(controller.otpPacNo!.value)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    PinWidget(controller: controller),
                    const SizedBox(
                      height: 10,
                    ),
                    // controller.otpType == Otp.fasspay
                    //     ?
                    GestureDetector(
                      onTap: () => controller.otpAction("resend"),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          LocaleKeys.otp_resend_otp.tr,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    )
                    // : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => controller.isLoading.value
                ? const BerryPayLoading()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppButton.rectangle(
                      title: LocaleKeys.verify_text.tr,
                      onTap: () {
                        if (controller.otpCode.text.isEmpty) {
                          AppSnackbar.errorSnackbar(
                              title: LocaleKeys.otp_verification.tr);
                          return;
                        }
                        controller.otpAction("verify");
                      },
                    ),
                  ),
          )),
    );
  }
}
