import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/locale_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/profile_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/local_widgets/account_link.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileMyView extends GetView<ProfileMyController> {
  const ProfileMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Body(controller: controller),

      body: Column(
        children: [
          Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: const Alignment(
                    5.0,
                    1.0,
                  ),
                  colors: [const Color(0xFFE3242B), Colors.blue[800]!],
                ),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
              ),
              margin: const EdgeInsets.only(bottom: 70),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(controller.userProfile!.fullName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColor.white)),
                    Obx(
                      () => Text(
                        controller.email!.value,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColor.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                  border: Border.all(color: Colors.grey.withOpacity(0.05)),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(controller.userProfile!.fullName[0],
                        style: const TextStyle(
                            fontSize: 60, color: AppColor.primary)),
                  ),
                )),
          ]),
          Expanded(
            child: ListView(
              primary: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5)),
                    ],
                    border: Border.all(color: Colors.grey.withOpacity(0.05)),
                  ),
                  child: Column(
                    children: [
                      // AccountLinkWidget(
                      //     icon: const Icon(Icons.edit, color: AppColor.primary),
                      //     text: const Text("Edit Profile"),
                      //     onTap: () {
                      //       Get.toNamed(Routes.EDIT_PROFILE_MY,
                      //           arguments: controller.userProfile);
                      //     }),
                      // AccountLinkWidget(
                      //     icon: const Icon(Icons.fact_check_outlined,
                      //         color: Color(0xFFE3242B)),
                      //     text: const Text("KYC Verification"),
                      //     onTap: () {
                      //       // Get.toNamed(Routes.MANUAL_KYC);
                      //       Get.to(() => VerifyKYC());
                      //     }),
                      AccountLinkWidget(
                          icon: const Icon(Icons.assignment_outlined,
                              color: AppColor.primary),
                          text: Text(LocaleKeys
                              .profile_page_sender_information_text.tr),
                          onTap: () {
                            Get.toNamed(Routes.SENDER_INFORMATION);
                          }),
                      controller.walletId == null
                          ? Container()
                          : AccountLinkWidget(
                              icon: const Icon(Icons.card_giftcard_outlined,
                                  color: AppColor.primary),
                              text: Text(LocaleKeys.profile_page_my_benefit.tr),
                              onTap: () {
                                Get.toNamed(Routes.WALLET_BENEFIT);
                              }),
                      // AccountLinkWidget(
                      //     icon:
                      //         const Icon(Icons.phone, color: AppColor.primary),
                      //     text: const Text("Change Mobile Number"),
                      //     onTap: () {
                      //       Get.toNamed(Routes.CHANGE_MOBILE_NO_MY);
                      //     }),
                      AccountLinkWidget(
                          icon: const Icon(Icons.pin_outlined,
                              color: AppColor.primary),
                          text: Text(LocaleKeys.profile_page_change_pin.tr),
                          onTap: () {
                            controller.changePin();
                          }),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5)),
                    ],
                    border: Border.all(color: Colors.grey.withOpacity(0.05)),
                  ),
                  child: Column(
                    children: [
                      AccountLinkWidget(
                          icon: const Icon(Icons.info_outline,
                              color: AppColor.primary),
                          text: Text(LocaleKeys.profile_page_about_us_text.tr),
                          onTap: () {
                            Get.toNamed(Routes.ABOUT_MY);
                          }),
                      AccountLinkWidget(
                          icon: const Icon(Icons.help_outline,
                              color: AppColor.primary),
                          text:
                              Text(LocaleKeys.profile_page_contact_us_text.tr),
                          onTap: () {
                            Get.toNamed(Routes.CONTACT_MY);
                          }),
                      AccountLinkWidget(
                          icon: const Icon(Icons.language,
                              color: AppColor.primary),
                          text: Text(LocaleKeys.profile_page_language_text.tr),
                          onTap: () {
                            Get.bottomSheet(
                              SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                        leading: Text(LocaleKeys
                                            .profile_page_select_lang_text.tr)),
                                    ListTile(
                                        title: const Text('Bahasa Indonesia'),
                                        onTap: () async {
                                          controller.language.value =
                                              'Bahasa Indonesia';

                                          Get.updateLocale(
                                              const Locale('id', 'ID'));
                                          Get.find<StorageProvider>()
                                              .setLanguage(
                                            LocaleModel(
                                                language: 'id',
                                                countryCode: 'ID'),
                                          );
                                          Get.back();
                                        }),
                                    ListTile(
                                        title: const Text('Bahasa Melayu'),
                                        onTap: () async {
                                          controller.language.value =
                                              'Bahasa Melayu';

                                          Get.updateLocale(
                                              const Locale('ms', 'MS'));

                                          Get.find<StorageProvider>()
                                              .setLanguage(
                                            LocaleModel(
                                                language: 'ms',
                                                countryCode: 'MS'),
                                          );
                                          Get.back();
                                        }),
                                    ListTile(
                                        title: const Text('English'),
                                        onTap: () async {
                                          controller.language.value = 'English';

                                          Get.updateLocale(
                                              const Locale('en', 'US'));

                                          Get.find<StorageProvider>()
                                              .setLanguage(
                                            LocaleModel(
                                                language: 'en',
                                                countryCode: 'US'),
                                          );
                                          Get.back();
                                        }),
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.white,
                            );
                          }),
                      AccountLinkWidget(
                          icon: const Icon(Icons.exit_to_app,
                              color: AppColor.primary),
                          text: Text(LocaleKeys.profile_page_sign_out_text.tr),
                          onTap: () {
                            Get.dialog(
                              CupertinoAlertDialog(
                                title: Text(
                                  LocaleKeys.sign_out.tr,
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  LocaleKeys.sign_out_desc.tr,
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    isDefaultAction: true,
                                    child: Text(
                                      LocaleKeys.close_text.tr,
                                      style:
                                          TextStyle(color: AppColor.secondary),
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      controller.signOut();
                                    },
                                    child: Text(LocaleKeys.sign_out.tr),
                                  ),
                                ],
                              ),
                              barrierDismissible: false,
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: Colors.lightBlue[50],
        child: Wrap(
          children: <Widget>[
            const Icon(
              Icons.help_outline,
              color: Colors.black,
              size: 15,
            ),
            const SizedBox(width: 10.0),
            InkWell(
              // onTap: () => messageBerryPay(),
              child: FittedBox(
                child: Text(LocaleKeys.profile_page_question_text.tr),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileMyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: [
        Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(
                  5.0,
                  1.0,
                ),
                colors: [const Color(0xFFE3242B), Colors.blue[800]!],
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5)),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 70),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(controller.userProfile!.fullName.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AppColor.white)),
                  Obx(
                    () => Text(
                      controller.email!.value,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: AppColor.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
                border: Border.all(color: Colors.grey.withOpacity(0.05)),
              ),
              child: Container(
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(controller.userProfile!.fullName[0],
                      style: const TextStyle(
                          fontSize: 60, color: AppColor.primary)),
                ),
              )),
        ]),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
            border: Border.all(color: Colors.grey.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              AccountLinkWidget(
                  icon: const Icon(Icons.edit, color: AppColor.primary),
                  text: const Text("Edit Profile"),
                  onTap: () {
                    Get.toNamed(Routes.EDIT_PROFILE_MY,
                        arguments: controller.userProfile);
                  }),
              AccountLinkWidget(
                  icon: const Icon(Icons.phone, color: AppColor.primary),
                  text: const Text("Change Mobile Number"),
                  onTap: () {
                    Get.toNamed(Routes.CHANGE_MOBILE_NO_MY);
                  }),
              AccountLinkWidget(
                  icon: const Icon(Icons.pin_outlined, color: AppColor.primary),
                  text: const Text("Change Pin"),
                  onTap: () {
                    controller.changePin();
                  }),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
            border: Border.all(color: Colors.grey.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              AccountLinkWidget(
                  icon: const Icon(Icons.info_outline, color: AppColor.primary),
                  text: const Text("About Us"),
                  onTap: () {
                    Get.toNamed(Routes.ABOUT_MY);
                  }),
              AccountLinkWidget(
                  icon: const Icon(Icons.help_outline, color: AppColor.primary),
                  text: const Text("Contact Us"),
                  onTap: () {
                    Get.toNamed(Routes.CONTACT_MY);
                  }),
              AccountLinkWidget(
                  icon: const Icon(Icons.language, color: AppColor.primary),
                  text: const Text("Languange"),
                  onTap: () {
                    Get.bottomSheet(
                      SafeArea(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                                leading: Text(LocaleKeys
                                    .profile_page_select_lang_text.tr)),
                            ListTile(
                                title: const Text('Bahasa Indonesia'),
                                onTap: () async {
                                  controller.language.value =
                                      'Bahasa Indonesia';

                                  Get.updateLocale(const Locale('id', 'ID'));
                                  Get.find<StorageProvider>().setLanguage(
                                    LocaleModel(
                                        language: 'id', countryCode: 'ID'),
                                  );

                                  Get.back();
                                }),
                            ListTile(
                                title: const Text('Bahasa Melayu'),
                                onTap: () async {
                                  controller.language.value = 'Bahasa Melayu';

                                  Get.updateLocale(const Locale('ms', 'MS'));
                                  Get.find<StorageProvider>().setLanguage(
                                    LocaleModel(
                                        language: 'ms', countryCode: 'MS'),
                                  );
                                  Get.back();
                                }),
                            ListTile(
                                title: const Text('English'),
                                onTap: () async {
                                  controller.language.value = 'English';

                                  Get.updateLocale(const Locale('en', 'US'));
                                  Get.find<StorageProvider>().setLanguage(
                                    LocaleModel(
                                        language: 'en', countryCode: 'MS'),
                                  );
                                  Get.back();
                                }),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                    );
                  }),
              AccountLinkWidget(
                  icon: const Icon(Icons.exit_to_app, color: AppColor.primary),
                  text: const Text("Sign Out"),
                  onTap: () {
                    controller.signOut();
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
