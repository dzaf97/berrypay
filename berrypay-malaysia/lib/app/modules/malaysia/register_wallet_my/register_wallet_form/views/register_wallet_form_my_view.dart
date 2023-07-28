import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/register_wallet_form_my_controller.dart';

class RegisterWalletFormMyView extends GetView<RegisterWalletFormMyController> {
  const RegisterWalletFormMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
        ),
        body: SingleChildScrollView(child: Body(controller: controller)),
        bottomNavigationBar: Obx(
          () => controller.isLoading.value
              ? const BerryPayLoading()
              : SubmitButton(
                  controller: controller,
                ),
        ));
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final RegisterWalletFormMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.kyc_page_by_clicking_continue.tr),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('\u2022'),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: 'BerryPay\'s ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: LocaleKeys.kyc_page_termsofService.tr,
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.launchInBrowser(controller.toLaunch);
                          },
                      ),
                      TextSpan(
                          text: ' ${LocaleKeys.kyc_page_and.tr} BerryPay\'s ',
                          style: const TextStyle(color: Colors.grey)),
                      TextSpan(
                        text: ' ${LocaleKeys.kyc_page_privacyPolicy.tr}',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            logger('masuk');
                            controller.launchInBrowser(controller.toLaunch);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('\u2022'),
              const SizedBox(
                width: 5,
              ),
              // Expanded(
              //   child: Text(
              //     'Fasspay\'s Terms of Service and Fasspay\'s Privacy Policy',
              //     style: Theme.of(context).textTheme.bodySmall,
              //   ),
              // ),
              Expanded(
                child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: 'Fasspay\'s ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: LocaleKeys.kyc_page_termsofService.tr,
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse(
                                "https://public-assets.fasspay.com/ew/partner/berrypay/termsofservice_en.html"));
                          },
                      ),
                      TextSpan(
                          text: ' ${LocaleKeys.kyc_page_and.tr} Fasspay\'s ',
                          style: const TextStyle(color: Colors.grey)),
                      TextSpan(
                        text: ' ${LocaleKeys.kyc_page_privacyPolicy.tr}',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            logger('masuk');
                            launchUrl(Uri.parse(
                                "https://public-assets.fasspay.com/ew/partner/berrypay/privacypolicy_en.html"));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // RichText(
          //   softWrap: true,
          //   textAlign: TextAlign.justify,
          //   text: TextSpan(
          //     text: 'By clicking \'Continue\', you agree to ',
          //     style: Theme.of(context).textTheme.caption,
          //     children: <TextSpan>[
          //       const TextSpan(
          //         text: 'BerryPay\'s Terms of Service',
          //         style: TextStyle(
          //           color: Colors.blue,
          //         ),
          //       ),
          //       const TextSpan(
          //           text: ',', style: TextStyle(color: Colors.black)),
          //       const TextSpan(
          //           text: ' BerryPay\'s Privacy Policy',
          //           style: TextStyle(color: Colors.blue)),
          //       const TextSpan(text: ' and '),
          //       TextSpan(
          //         text: 'Fasspay\'s Terms of Service',
          //         style: TextStyle(color: Colors.blue),
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () {
          //             launchUrl(Uri.parse(
          //                 "https://public-assets.fasspay.com/ew/partner/berrypay/termsofservice_en.html"));
          //           },
          //       ),
          //       const TextSpan(
          //           text: ',', style: TextStyle(color: Colors.black)),
          //       TextSpan(
          //         text: ' Fasspay\'s Privacy Policy',
          //         style: TextStyle(color: Colors.blue),
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () {
          //             logger('masuk');
          //             launchUrl(Uri.parse(
          //                 "https://public-assets.fasspay.com/ew/partner/berrypay/privacypolicy_en.html"));
          //           },
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          AppButton.rectangle(
            onTap: () => controller.registerWallet(
              SSUserProfileVO(
                fullName: controller.fullName.text,
                nickName: controller.nickName.text,
                identificationNo: controller.identificationCard.text,
                identificationType: controller.id.value,
                nationalityCountryCode: controller.nationality?.toUpperCase(),
                mobileNo: controller.mobileNumber.text,
                mobileNoCountryCode: "MY",
                email: controller.email.text,
                dateOfBirth: controller.dateOfBirth.text,
              ),
            ),
            title: LocaleKeys.kyc_page_continue.tr,
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final RegisterWalletFormMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            LocaleKeys.kyc_page_please_fill_in.tr,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFieldWidget(
            readOnly: true,
            labelText: LocaleKeys.phoneNum_field_hint.tr,
            iconData: Icons.contact_page,
            controller: controller.mobileNumber,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys
                    .profile_page_please_enter_phone_number_text.tr;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            readOnly: false,
            labelText: LocaleKeys.edit_profile_page_fullname_text.tr,
            iconData: Icons.person,
            controller: controller.fullName,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.edit_profile_page_please_enter_fullname.tr;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // TextFieldWidget(
          //   readOnly: false,
          //   labelText: 'Nickname',
          //   iconData: Icons.person,
          //   controller: controller.nickName,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            padding:
                const EdgeInsets.only(top: 25, bottom: 14, left: 20, right: 20),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
                border:
                    Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      LocaleKeys.register_page_identity_type_text.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 15),
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
                    ),
                  ],
                ),
                Obx(
                  () => RadioListTile<IdentificationType>(
                    title: Text(
                      LocaleKeys.register_page_identity_no.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    value: IdentificationType.IdentificationTypeNRIC,
                    onChanged: (value) {
                      logger('value: $value');
                      controller.id.value = value as IdentificationType;
                    },
                    groupValue: controller.id.value,
                  ),
                ),
                Obx(
                  () => RadioListTile<IdentificationType>(
                    title: Text(
                      LocaleKeys.kyc_page_passport.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    value: IdentificationType.IdentificationTypePassport,
                    onChanged: (value) {
                      logger('value: $value');
                      controller.id.value = value as IdentificationType;
                    },
                    groupValue: controller.id.value,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFieldWidget(
              controller: controller.identificationCard,
              labelText: controller.id.value ==
                      IdentificationType.IdentificationTypeNRIC
                  ? LocaleKeys.register_page_identity_no.tr
                  : LocaleKeys.register_page_passport_number_text.tr,
              hintText: 'XXXXXXXXXX',
              iconData: Icons.credit_card,
              maxLength: 12,
              keyboardType: TextInputType.number,
              // onChanged: (value) {
              //   if (controller.id.value ==
              //       IdentificationType.IdentificationTypeNRIC) {
              //     var dob = controller.identificationCard.text.toString();

              //     controller.dateOfBirth.text =
              //         '19${dob[0] + dob[1]}-${dob[2] + dob[3]}-${dob[4] + dob[5]}';
              //   }
              // },
              validator: (value) {
                if (value!.isEmpty) {
                  if (controller.id.value ==
                      IdentificationType.IdentificationTypeNRIC) {
                    return LocaleKeys.register_page_enter_identity_number.tr;
                  } else if (controller.id.value ==
                      IdentificationType.IdentificationTypePassport) {
                    return LocaleKeys.register_page_please_enter_passport.tr;
                  }
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => controller.isLoading.value
                ? const BerryPayLoading()
                : TextFieldWidget(
                    controller: controller.dateOfBirth,
                    labelText: LocaleKeys.register_page_date_of_birth_text.tr,
                    hintText: 'xxxx-xx-xx',
                    iconData: Icons.calendar_month,
                    ontap: () async {
                      logger("controller.dateOfBirth.text");
                      logger(controller.dateOfBirth.text);

                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime dateDob = DateTime.now();

                      logger(dateDob);

                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: dateDob,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        // controller.dob.text = date.toIso8601String().split("T")[0];

                        controller.dateOfBirth.text =
                            DateFormat('dd-MM-yyyy').format(date);
                        logger(controller.dateOfBirth.text);
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys
                            .profile_page_date_of_birth_message_text.tr;
                      }
                      return null;
                    },
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            controller: controller.email,
            labelText: LocaleKeys.kyc_page_email.tr,
            hintText: 'xxxxx@xx.com',
            iconData: Icons.email,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.edit_profile_page_please_enter_email.tr;
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                  .hasMatch(value)) {
                return LocaleKeys.register_page_email_validation.tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
