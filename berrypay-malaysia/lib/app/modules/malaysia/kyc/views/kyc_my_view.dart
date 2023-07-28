import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kyc_my_controller.dart';

class KycMyView extends GetView<KycMyController> {
  const KycMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
          automaticallyImplyLeading: false,
        ),
        body: Menu(controller: controller),
        bottomNavigationBar: BottomBar(
          controller: controller,
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KycMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(LocaleKeys.kyc_page_kyc_dislaimer.tr,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(Icons.check_circle),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: LocaleKeys.kyc_page_kyc_dislaimer1.tr,
                    style: Theme.of(context).textTheme.bodySmall,
                    children: <TextSpan>[
                      TextSpan(
                          text: ' ${LocaleKeys.kyc_page_privacyPolicy.tr}',
                          style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AppButton.rectangle(
              onTap: () {
                controller.getStarted();
              },
              title: 'Get Started'),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KycMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AutoSizeText(
              LocaleKeys.kyc_page_verify_few_step.tr,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            BoxMenu(
                step: '${LocaleKeys.kyc_page_step.tr} 1',
                title: controller.ssWalletCardModelVO!.userProfileVO!
                            .identificationType ==
                        IdentificationType.IdentificationTypeNRIC
                    ? LocaleKeys.kyc_page_ic_photo.tr
                    : LocaleKeys.kyc_page_passport.tr,
                subtitle: controller.ssWalletCardModelVO!.userProfileVO!
                            .identificationType ==
                        IdentificationType.IdentificationTypeNRIC
                    ? LocaleKeys.kyc_page_front_ic.tr
                    : LocaleKeys.kyc_page_front_passport.tr,
                image: 'assets/images/card.png'),
            const SizedBox(
              height: 15,
            ),
            BoxMenu(
                step: '${LocaleKeys.kyc_page_step.tr} 2',
                title: LocaleKeys.kyc_page_selfie_video.tr,
                subtitle: LocaleKeys.kyc_page_record_selfie.tr,
                image: 'assets/images/face.png'),
            const SizedBox(
              height: 15,
            ),
            BoxMenu(
                step: '${LocaleKeys.kyc_page_step.tr} 3',
                title: LocaleKeys.kyc_page_complete_application.tr,
                subtitle: LocaleKeys.kyc_page_complete_info.tr,
                image: 'assets/images/completed.png'),
          ],
        ),
      ),
    );
  }
}

class BoxMenu extends StatelessWidget {
  const BoxMenu({
    Key? key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  final String step;
  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 90,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step,
                style: const TextStyle(color: Colors.blue),
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
