import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dropdown.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/nationality/views/nationality_view.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_form_controller.dart';

class RegisterFormView extends GetView<RegisterFormController> {
  const RegisterFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CountryController(RegisterRepo()));
    Get.put(NationalityController(RegisterRepo()));
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                FormRegister(
                  controller: controller,
                  countryController: controller.countryController,
                  nationalityController: controller.nationalityController,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => controller.isLoading.value
                ? const BerryPayLoading()
                : AppButton.rectangle(
                    title: LocaleKeys.register_page_create_button_text.tr,
                    onTap: () {
                      if (controller.formKey.currentState!.validate() &&
                          controller.tnc.isTrue) {
                        controller.register(
                          RegisterBpgRequest(
                              DOB: controller.dob.text,
                              username: controller.usernameController.text
                                  .toLowerCase(),
                              password: controller.passwordController.text,
                              fullName: controller.fullNameController.text,
                              mobileNumber: controller.phoneNo!,
                              registerCountry: 'MYS',
                              identificationNo: controller.idNumber.text,
                              identificationType:
                                  controller.selectedIdValue?.value == 'PASS'
                                      ? 'PASS_AI'
                                      : 'IC_AI',
                              identificationSubType:
                                  controller.selectedIdType?.value,
                              docExpirtyDate: controller.docExpiryDate.text,
                              nationality: controller.nationalityController
                                  .selectedNationalityCode.value,
                              email: (controller.email.text == "")
                                  ? null
                                  : controller.email.text,
                              gender: controller.selectedGender.value,
                              idDocVerifyLevel:
                                  controller.data?.isOnboarding == true ? 3 : 0,
                              reregister: false,
                              firstName: controller.firstNameController.text,
                              lastName: controller.lastNameController.text,
                              appName: "BPMY"),
                        );
                      } else if (controller.tnc.isFalse) {
                        AppSnackbar.errorSnackbar(
                            title: LocaleKeys
                                .register_page_agree_tnc_error_text.tr);
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister(
      {Key? key,
      required this.controller,
      required this.countryController,
      required this.nationalityController})
      : super(key: key);

  final RegisterFormController controller;
  final CountryController countryController;
  final NationalityController nationalityController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // BerryPay Logo
              Hero(
                  tag: "logo",
                  child: Image.asset("assets/images/logo.png", width: 50)),

              // Bullet
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                child: Row(children: [
                  Bullet(status: ""),
                  SizedBox(width: 5),
                  Bullet(status: ""),
                  SizedBox(width: 5),
                  Bullet(status: "active"),
                ]),
              ),

              // Create your account
              Text(
                LocaleKeys.user_info_create_acc_text.tr,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),

              // Enter required information below
              Text(
                LocaleKeys.user_info_req_info_text.tr,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                              text: LocaleKeys
                                  .register_page_fill_in_information_message_text
                                  .tr),
                          TextSpan(
                            text: "servicedesk@berrypay.com.",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                logger('tap');
                                controller.launchMailClient();
                              },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Username
              TextFieldWidget(
                // regex: '[^-\\s]',
                regex: "^[a-z0-9]+",
                labelText: LocaleKeys.register_page_username_text.tr,
                controller: controller.usernameController,
                hintText: 'e.g: aliAbu',
                iconData: Icons.person,
                validator: (value) {
                  final regex = RegExp('[,<>.^*()%!+;:/#&"?]');
                  final specialCharacters = RegExp('[^A-Za-z0-9]');

                  if (value!.isEmpty) {
                    return LocaleKeys.register_page_enter_username_text.tr;
                  } else if (regex.hasMatch(value)) {
                    return LocaleKeys.register_page_invalid_format_text.tr;
                  } else if (specialCharacters.hasMatch(value)) {
                    return LocaleKeys
                        .register_page_do_not_include_special_char_text.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFieldWidget(
                labelText: LocaleKeys.register_page_first_name_text.tr,
                // labelText: LocaleKeys.edit_profile_page_fullname_text.tr,
                controller: controller.firstNameController,
                regex: r'^[a-zA-Z\s]+$',
                keyboardType: TextInputType.name,
                hintText: 'e.g: Ali',
                iconData: Icons.person,
                validator: (value) {
                  final numReg = RegExp(r'[0-9]');
                  if (value!.isEmpty) {
                    return LocaleKeys.register_page_enter_first_name_text.tr;
                  } else if (value.contains(numReg)) {
                    return LocaleKeys.register_page_dont_include_number_text.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                isRequired: false,
                labelText: LocaleKeys.register_page_last_name_text.tr,
                controller: controller.lastNameController,
                keyboardType: TextInputType.name,
                regex: r'^[a-zA-Z\s]+$',
                hintText: 'e.g: Abu',
                iconData: Icons.person,
                validator: (value) {
                  final numReg = RegExp(r'[0-9]');
                  if (value!.isNotEmpty) {
                    if (value.contains(numReg)) {
                      return LocaleKeys.register_page_invalid_format_text.tr;
                    }
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFieldWidget(
                labelText: 'Full Name',
                controller: controller.fullNameController,
                regex: r'^[a-zA-Z\s]+$',
                keyboardType: TextInputType.name,
                hintText: 'e.g: Ali Abu bin Adam',
                iconData: Icons.person,
                validator: (value) {
                  final numReg = RegExp(r'[0-9]');
                  if (value!.isEmpty) {
                    return LocaleKeys.register_page_enter_first_name_text.tr;
                  } else if (value.contains(numReg)) {
                    return LocaleKeys.register_page_dont_include_number_text.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.amber,
                    size: 16,
                  ).paddingOnly(right: 10),
                  Text(
                    'Name must be same with your ID card',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // DropdownTextForm(
              //   controller: null,
              //   title: 'Nationality',
              //   widget: FormField<Country>(
              //           builder: (FormFieldState<Country> state) {
              //             return DropdownButtonFormField<String>(
              //               autovalidateMode:
              //                   AutovalidateMode.onUserInteraction,
              //               decoration: const InputDecoration(
              //                 border: InputBorder.none,
              //               ),
              //               value: null,
              //               hint: Text(
              //                   LocaleKeys.remittance_please_select_value.tr),
              //               isExpanded: true,
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodySmall!
              //                   .copyWith(color: Colors.grey),

              //               // Down Arrow Icon
              //               icon: const Icon(Icons.keyboard_arrow_down),

              //               items: controller.nationalityController.nationality.
              //                   .map((e) => DropdownMenuItem(
              //                       value: e.Data,
              //                       child: Text('${e.Value}'.tr)))
              //                   .toList(),

              //               onChanged: (value) {
              //                 //   //get value when changed
              //                 // controller.selectedRelationship?.value = value!;
              //                 logger("You have selected $value");
              //               },
              //               validator: (value) {
              //                 if (value == null) {
              //                   return LocaleKeys
              //                       .remittance_please_select_relationship.tr;
              //                 }
              //                 return null;
              //               },
              //             );
              //           },
              //         ),,
              // ),

              GestureDetector(
                onTap: () {
                  Get.to(() => const NationalityView());
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 10, left: 20, right: 20),
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
                            LocaleKeys.register_page_nationality_text.tr,
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              controller.nationalityController
                                  .selectedNationality.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? const BerryPayLoading()
                    : DropdownTextForm(
                        controller: controller,
                        title: LocaleKeys.register_page_identity_type_text.tr,
                        widget: DropdownButton(
                          // Initial Value
                          value:
                              '${controller.selectedIdType?.value}_${controller.selectedIdValue?.value}',
                          underline: Container(),
                          isExpanded: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          items: controller.dataDocType!
                              .map((e) => DropdownMenuItem(
                                  value: '${e.id}_${e.docType}',
                                  child: Text('${e.name}')))
                              .toList(),

                          onChanged: (value) {
                            //   //get value when changed

                            controller.selectedIdType?.value =
                                value!.split('_').first;

                            controller.selectedIdValue?.value =
                                value!.split('_').last;

                            logger("You have selected $value");
                          },
                        ),
                      ),
              ),

              const SizedBox(height: 20),

              // IC
              Obx(
                () => TextFieldWidget(
                  keyboardType: controller.selectedIdValue?.value == 'IC'
                      ? TextInputType.number
                      : TextInputType.text,
                  controller: controller.idNumber,
                  labelText: controller.selectedIdValue?.value == 'PASS'
                      ? LocaleKeys.register_page_passport_number_text.tr
                      : controller.selectedIdValue?.value == 'IC'
                          ? 'Identity Card Number'
                          : 'Passport Number',
                  hintText: 'XXXXXXXXXX',
                  iconData: Icons.credit_card,
                  maxLength: controller.selectedIdType?.value == 'MY-02'
                      ? 12
                      : controller.selectedIdType?.value == 'ID-02'
                          ? 16
                          : 20,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return LocaleKeys.register_page_enter_identity_number.tr;
                    } else if (controller.selectedIdValue?.value == 'PASS') {
                      final specialCharacters = RegExp('[^A-Za-z0-9]');
                      if (specialCharacters.hasMatch(input)) {
                        return LocaleKeys.register_page_invalid_format_text.tr;
                      }
                    } else if (controller.selectedIdType?.value != 'MY-01') {
                      final invalidCharacters = RegExp('[-,.<>%^-\\s\$]');

                      if (invalidCharacters.hasMatch(input)) {
                        return LocaleKeys.register_page_invalid_format_text.tr;
                      }
                    } else if (controller.selectedIdType?.value == 'MY-01') {
                      final invalidCharacters = RegExp('[^\x00-\x7F]');
                      final regex = RegExp('[,<>.^*()%!-]');
                      if (invalidCharacters.hasMatch(input)) {
                        return LocaleKeys.register_page_invalid_format_text.tr;
                      } else if (regex.hasMatch(input)) {
                        return LocaleKeys.register_page_invalid_format_text.tr;
                      }
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              Obx(() => controller.selectedIdValue?.value == 'PASS'
                  ? TextFieldWidget(
                      controller: controller.docExpiryDate,
                      labelText:
                          LocaleKeys.register_page_document_expiry_date_text.tr,
                      hintText: 'xx-xx-xxxx',
                      iconData: Icons.calendar_month,
                      ontap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime dateDob = DateTime.now();

                        DateTime? date = (await showDatePicker(
                            context: context,
                            initialDate: dateDob,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)));

                        if (date != null) {
                          controller.docExpiryDate.text =
                              date.toIso8601String().split("T")[0];
                          logger(controller.docExpiryDate.text);
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys
                              .register_page_enter_expiry_date_text.tr;
                        }
                        return null;
                      },
                    ).paddingOnly(bottom: 20)
                  : const SizedBox()),

              TextFieldWidget(
                isRequired: false,
                controller: controller.email,
                labelText: LocaleKeys.register_page_email_text.tr,
                hintText: 'xxx@gmail.com',
                keyboardType: TextInputType.emailAddress,
                iconData: Icons.email,
                validator: (value) {
                  final RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );

                  if (value!.isNotEmpty) {
                    if (!emailRegex.hasMatch(value)) {
                      return LocaleKeys.register_page_email_validation.tr;
                    }
                    return null;
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),
              TextFieldWidget(
                controller: controller.dob,
                labelText: LocaleKeys.register_page_date_of_birth_text.tr,
                hintText: 'xx-xx-xxxx',
                iconData: Icons.calendar_month,
                ontap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime dateDob = DateTime.now();

                  DateTime? date = (await showDatePicker(
                      context: context,
                      initialDate: dateDob,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100)));

                  if (date != null) {
                    controller.dob.text = date.toIso8601String().split("T")[0];
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.register_page_enter_date_of_birth_text.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              DropdownTextForm(
                controller: controller,
                title: LocaleKeys.register_page_gender_text.tr,
                widget: Obx(
                  () => DropdownButton(
                    // Initial Value
                    value: controller.selectedGender.value,
                    underline: Container(),
                    isExpanded: true,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey),

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: [
                      //add items in the dropdown
                      DropdownMenuItem(
                        value: "Female",
                        child: Text(LocaleKeys.register_page_female_text.tr),
                      ),
                      DropdownMenuItem(
                        value: "Male",
                        child: Text(LocaleKeys.register_page_male_text.tr),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedGender.value = value!;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password textfield
              Obx(
                () => TextFieldWidget(
                  labelText: LocaleKeys.login_page_pass_field_hint.tr,
                  obscureText: controller.passwordIsClose.value,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.passwordIsClose.value =
                          !controller.passwordIsClose.value;
                    },
                    icon: Icon(
                      controller.passwordIsClose.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  controller: controller.passwordController,
                  hintText: LocaleKeys.register_page_enter_password_text.tr,
                  iconData: Icons.lock,
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

              // DropdownTextForm(
              //   controller: null,
              //   title: 'Password',
              //   widget: FancyPasswordField(
              //     controller: controller.passwordController,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     hasStrengthIndicator: false,
              //     decoration: InputDecoration(
              //         icon: const Icon(Icons.lock),
              //         hintText: 'Password',
              //         border: InputBorder.none,
              //         hintStyle: Theme.of(context)
              //             .textTheme
              //             .bodySmall!
              //             .copyWith(color: Colors.grey)),
              //     showPasswordIcon: const Icon(Icons.visibility_off_outlined),
              //     hidePasswordIcon: const Icon(Icons.visibility_outlined),
              //     validationRules: {
              //       DigitValidationRule(customText: 'At least 1 number'),
              //       UppercaseValidationRule(customText: 'At least 1 uppercase'),
              //       LowercaseValidationRule(customText: 'At least 1 lowercase'),
              //       SpecialCharacterValidationRule(
              //           customText: 'At least 1 special character'),
              //       MinCharactersValidationRule(8,
              //           customText: 'At least 8 character'),
              //       // MaxCharactersValidationRule(12),
              //     },

              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return LocaleKeys.kyc_page_enter_password.tr;
              //       }
              //       return null;
              //     },
              //     // strengthIndicatorBuilder: (strength) => Text(
              //     //   strength.toString(),
              //     // ),
              //     validationRuleBuilder: (rules, value) {
              //       if (value.isEmpty) {
              //         return const SizedBox.shrink();
              //       }
              //       return ListView(
              //         shrinkWrap: true,
              //         children: rules
              //             .map(
              //               (rule) => rule.validate(value)
              //                   ? Row(
              //                       children: [
              //                         const Icon(
              //                           Icons.check,
              //                           color: Colors.green,
              //                         ),
              //                         const SizedBox(width: 12),
              //                         Text(
              //                           rule.name,
              //                           style: const TextStyle(
              //                             color: Colors.green,
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   : Row(
              //                       children: [
              //                         const Icon(
              //                           Icons.close,
              //                           color: Colors.red,
              //                         ),
              //                         const SizedBox(width: 12),
              //                         Text(
              //                           rule.name,
              //                           style: const TextStyle(
              //                             color: Colors.red,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //             )
              //             .toList(),
              //       );
              //     },
              //   ),
              // ),

              const SizedBox(height: 20),

              // Confirm Password Textfield
              Obx(
                () => TextFieldWidget(
                  labelText: LocaleKeys.kyc_page_Reenter_password.tr,
                  obscureText: controller.cPasswordIsClose.value,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.cPasswordIsClose.value =
                          !controller.cPasswordIsClose.value;
                    },
                    icon: Icon(
                      controller.cPasswordIsClose.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  controller: controller.confirmPasswordController,
                  hintText: LocaleKeys.register_page_reenter_password_text.tr,
                  iconData: Icons.lock,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.kyc_page_enter_password.tr;
                    } else if (controller.passwordController.text != value) {
                      return LocaleKeys
                          .register_page_password_dont_match_text.tr;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 30),

              // TnC checkbox
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Obx(
                      () => Checkbox(
                        activeColor: Colors.red,
                        checkColor: Colors.white,
                        value: controller.tnc.value,
                        onChanged: (bool? value) {
                          controller.tnc.value = value!;
                        },
                      ),
                    ),
                    Text(LocaleKeys.register_page_agree_tnc_text.tr,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13)),

                    // Go to Terms & Condition Page

                    InkWell(
                      onTap: () {
                        // controller.launchURL();
                        controller.launchInBrowser(controller.toLaunch);
                        // logger('tap ni');
                      },
                      child: Text(LocaleKeys.profile_page_tnc_text.tr,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    )
                  ]),
              const SizedBox(height: 30),

              // Submit Button

              // SubmitButton(controller: controller),
            ]),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.controller,
    required this.countryController,
  }) : super(key: key);

  final RegisterFormController controller;
  final CountryController countryController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppButton.roundedIcon(
        icon: Icons.arrow_forward,
        width: 180.0,
        height: 48.0,
        title: LocaleKeys.create_text.tr,
        onTap: () {
          controller.register(
            RegisterBpgRequest(
                username: controller.usernameController.text,
                password: controller.passwordController.text,
                fullName:
                    "${controller.firstNameController.text} ${controller.lastNameController.text}",
                firstName: controller.firstNameController.text,
                lastName: controller.lastNameController.text,
                mobileNumber: controller.phoneNo!,
                registerCountry: countryController.selectedCountryCode.value,
                identificationNo: controller.idNumber.text,
                identificationType: controller.id.toString()),
          );
        },
      ),
    );
  }
}

enum IdType { PASSPORT, NRIC }

class Bullet extends StatelessWidget {
  const Bullet({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: status == "active" ? 12 : 6,
      height: 6,
      decoration: BoxDecoration(
          color: status == "active" ? Colors.black38 : Colors.black12,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
