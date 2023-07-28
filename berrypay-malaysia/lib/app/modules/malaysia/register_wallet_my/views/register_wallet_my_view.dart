import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_wallet_my_controller.dart';

class RegisterWalletMyView extends GetView<RegisterWalletMyController> {
  const RegisterWalletMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
      ),
      body: WalletBenefit(
        controller: controller,
      ),
      bottomNavigationBar: UpgradeButton(
        controller: controller,
      ),
    );
  }
}

class UpgradeButton extends StatelessWidget {
  const UpgradeButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterWalletMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColor.primary,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: LocaleKeys.kyc_page_by_upgrading.tr,
                    style: Theme.of(context).textTheme.caption,
                    children: <TextSpan>[
                      TextSpan(
                        text: LocaleKeys.kyc_page_termsofService.tr,
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.launchInBrowser(controller.toLaunch);
                          },
                      ),
                      TextSpan(text: ' ${LocaleKeys.kyc_page_and.tr} '),
                      TextSpan(
                        text: LocaleKeys.kyc_page_privacyPolicy.tr,
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.launchInBrowser(controller.toLaunch);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          controller.type == 'Basic'
              ? Obx(
                  () => controller.isloading.value
                      ? BerryPayLoading()
                      : AppButton.rectangle(
                          title: 'Create',
                          onTap: () {
                            controller.registerFpWallet();
                          }),
                )
              : AppButton.rectangle(
                  title: 'Upgrade',
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.cancel)),
                              ),
                              Image.asset(
                                'assets/icons/scan.png',
                                width: 100,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(LocaleKeys.kyc_page_premium_desc.tr,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(fontSize: 14))
                                  .marginOnly(left: 16, right: 16),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      LocaleKeys.kyc_page_premium_desc1.tr,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Spacer(),
                              AppButton.rectangle(
                                  title: 'Continue',
                                  onTap: () {
                                    Get.toNamed(Routes.KYC_MY);
                                  })
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  })
        ],
      ),
    );
  }
}

class WalletBenefit extends StatelessWidget {
  WalletBenefit({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterWalletMyController controller;

  final List<String> benefitsAdvance = [
    'Increase your wallet limit up to RM 4,999',
    'Flexibility to withdraw your wallet balance back to your bank account',
    'Free upgrade!'
  ];
  final List<String> benefitsPremium = [
    LocaleKeys.kyc_page_premium_desc.tr,
    LocaleKeys.kyc_page_premium_desc1.tr,
    // 'Track your card expenses within wallet',
    // 'Enable multiple wallet accounts',
  ];

  final List<String> benefitBasic = [
    LocaleKeys.kyc_page_basic_desc.tr,
    LocaleKeys.kyc_page_basic_desc1.tr
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/selfie.jpg',
            width: 280,
          ),
          const SizedBox(
            height: 20,
          ),
          controller.type == 'Basic'
              ? AutoSizeText(
                  LocaleKeys.kyc_page_create_basic.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: AppColor.black),
                )
              : controller.type == 'Advance'
                  ? AutoSizeText(
                      'UPGRADE TO ADVANCE ACCOUNT',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColor.black),
                    )
                  : AutoSizeText(
                      LocaleKeys.kyc_page_upgrade_to_premium.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColor.black),
                    ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.type == 'Basic'
                ? benefitBasic.length
                : controller.type == 'Advance'
                    ? benefitsAdvance.length
                    : benefitsPremium.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColor.primary,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      controller.type == 'Basic'
                          ? Expanded(
                              child: AutoSizeText(benefitBasic[index],
                                  style:
                                      TextStyle(color: Colors.grey.shade700)),
                            )
                          : controller.type == 'Advance'
                              ? Expanded(
                                  child: AutoSizeText(benefitsAdvance[index],
                                      style: TextStyle(
                                          color: Colors.grey.shade700)),
                                )
                              : Expanded(
                                  child: AutoSizeText(benefitsPremium[index],
                                      style: TextStyle(
                                          color: Colors.grey.shade700)),
                                ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
