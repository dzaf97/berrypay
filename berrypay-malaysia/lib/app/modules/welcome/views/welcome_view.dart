import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:berrypay_global_x/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';
import '../local_widgets/bubble.dart';
import '../local_widgets/language_tile.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0, toolbarHeight: 0, automaticallyImplyLeading: false),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: const Alignment(5.0, 1.0),
              colors: [const Color(0xFFE3242B), Colors.blue[800]!],
            ),
          ),
          child: Stack(
            children: [
              Bubble(
                animatedCircle: controller.animatedCircle,
                top: -70,
                left: -70,
              ),
              Bubble(
                animatedCircle: controller.animatedCircle,
                top: 10,
                left: -160,
              ),
              Bubble(
                animatedCircle: controller.animatedCircle,
                bottom: -100,
                right: -70,
              ),
              Bubble(
                animatedCircle: controller.animatedCircle,
                bottom: 0,
                right: -160,
              ),
              GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => Get.bottomSheet(
                            LanguageTile(language: controller.language)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Icon(
                                Icons.language,
                                color: Colors.white,
                                size: 23.0,
                              ),
                            ),
                            Text(
                              Get.locale!.languageCode.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 100),
                        height: 250,
                        width: 150,
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset('assets/images/bp_logo_white.png'),
                        ),
                      ),
                      controller.isJailbreak
                          ? const AutoSizeText(
                              'Your device has been rooted/jailbroken.\nPlease reset your device to factory reset before proceed.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              minFontSize: 12,
                              maxFontSize: 17,
                              textAlign: TextAlign.center,
                            )
                          : Container(),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              LocaleKeys.welcome_page_intro_text.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          AppButton.rounded(
                            title: LocaleKeys.sign_in_text.tr,
                            onTap: () => controller.login(),
                            fontSize: 18,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          AppButton.outlinedBorder(
                              title: LocaleKeys.welcome_page_start_text.tr,
                              onTap: () => Get.toNamed(Routes.REGISTER),
                              fontSize: 18),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text('Version $appVersion${isStaging ? ' - Staging' : ''}',
                                style: const TextStyle(color: Colors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
