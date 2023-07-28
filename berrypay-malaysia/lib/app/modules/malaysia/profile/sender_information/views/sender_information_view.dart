import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/date.dart';
import 'package:berrypay_global_x/app/data/model/remitx/sender.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dropdown.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/nationality/views/nationality_view.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/modules/register/views/country_view.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sender_information_controller.dart';

class SenderInformationView extends GetView<SenderInformationController> {
  const SenderInformationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CountryController(RegisterRepo()));
    Get.put(NationalityController(RegisterRepo()));
    Get.put(BpgMyProvider());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.red[800]!,
          title: Text(
            LocaleKeys.profile_page_sender_information_text.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
              child:
                  // Get.find<StorageProvider>()
                  //         .getProfileInfoResponse()!
                  //         .wallet
                  //         .where((element) => element.bizSysId == "REMITXMY")
                  //         .isNotEmpty
                  //     ? SenderDetails(
                  //         controller: controller,
                  //       )
                  //     :

                  Obx(
            () => controller.isLoading.value
                ? const BerryPayLoading()
                : Get.find<StorageProvider>()
                        .getProfileInfoResponse()!
                        .wallet
                        .where((element) => element.bizSysId == "REMITXMY")
                        .isNotEmpty
                    ? SenderDetails(
                        controller: controller,
                      )
                    : FormFieldSender(
                        controller: controller,
                        countryController: controller.countryController,
                        nationalityController: controller.nationalityController,
                      ),
          )),
        ),
        bottomNavigationBar: Get.find<StorageProvider>()
                .getProfileInfoResponse()!
                .wallet
                .where((element) => element.bizSysId == "REMITXMY")
                .isNotEmpty
            ? const SizedBox()
            : Obx(
                () => controller.isLoad.value
                    ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : SubmitButton(
                        controller: controller,
                        countryController: controller.countryController,
                        nationalityController: controller.nationalityController,
                      ),
              ));
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.controller,
    required this.countryController,
    required this.nationalityController,
  }) : super(key: key);

  final SenderInformationController controller;
  final CountryController countryController;
  final NationalityController nationalityController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading.value
              ? const BerryPayLoading()
              : AppButton.rectangle(
                  title: LocaleKeys.profile_page_submit_text.tr,
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.registerSender(SenderRegisterRequest(
                        userLoginId: controller.email.text, //letak username
                        senderFirstName: controller.firstName.text,
                        senderMiddleName: "",
                        senderLastName: controller.lastName.text,
                        senderGender: controller.selectedGender.value,
                        senderAddress: controller.address1.text,
                        senderCity: controller.address2.text,
                        senderState: controller.address3.text,
                        senderZipCode: controller.poscode.text,
                        senderCountry:
                            countryController.selectedCountryCode.value,
                        // senderCountry: 'MYS',
                        senderMobile: controller.phone.text,
                        senderNationality:
                            nationalityController.selectedNationalityCode.value,
                        // senderNationality: 'MYS',
                        senderIdType: controller.selectedCustomerType.value,
                        senderIdNumber: controller.id.text,
                        senderIdIssueCountry: '',
                        senderIdIssueDate: '',
                        senderIdExpireDate: '',
                        senderDateOfBirth: controller.dob.text,
                        senderOccupation: controller.selectedOccupation.value,
                        senderSourceOfFund: controller.selectedSourceFund.value,
                        senderCustomerType: 'I',
                        senderEmail: controller.email.text,
                        senderNativeFirstname: '',
                        senderNativeLastname: '',
                        senderBeneficiaryRelationship: "",
                        senderCompanyName: controller.senderCompanyName.text,
                        senderCompanyRegNumber: '',
                        senderCompanyIncorporateDate: '',
                        username: controller.username,
                      ));
                    }
                  }),
        ));
  }
}

class FormFieldSender extends StatelessWidget {
  const FormFieldSender({
    Key? key,
    required this.controller,
    required this.countryController,
    required this.nationalityController,
  }) : super(key: key);
  final SenderInformationController controller;
  final CountryController countryController;
  final NationalityController nationalityController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.grey.shade300,
            width: double.infinity,
            child: Text(
              LocaleKeys.profile_page_sender_information_text.tr,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Text(
            LocaleKeys.remittance_sender_information_form.tr,
            style: Theme.of(context).textTheme.bodySmall,
          ).paddingSymmetric(horizontal: 16.0, vertical: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              regex: r'^[a-zA-Z\s]+',
              labelText: LocaleKeys.profile_page_sender_first_name_text.tr,
              hintText: LocaleKeys.profile_page_sender_first_name_text.tr,
              controller: controller.firstName,
              // enabled: false,
              validator: (value) {
                // final specialCharacters = RegExp('[^A-Za-z0-9]');
                if (value!.isEmpty) {
                  return LocaleKeys.register_page_enter_first_name_text.tr;
                }
                // else if (value.contains(specialCharacters)) {
                //   return LocaleKeys.register_page_dont_include_number_text.tr;
                // }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              isRequired: false,
              regex: r'^[a-zA-Z\s]+',
              labelText: LocaleKeys.profile_page_sender_last_name_text.tr,
              hintText: LocaleKeys.profile_page_sender_last_name_text.tr,
              controller: controller.lastName,
              // enabled: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              // enabled: false,
              labelText: LocaleKeys.profile_page_sender_email_text.tr,
              hintText: LocaleKeys.profile_page_sender_email_text.tr,
              controller: controller.email,
              isRequired: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.profile_page_sender_phone_number_text.tr,
              hintText: LocaleKeys.profile_page_sender_phone_number_text.tr,
              controller: controller.phone,
              // enabled: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys
                      .profile_page_please_enter_phone_number_text.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: DropdownTextForm(
              controller: controller,
              title: LocaleKeys.profile_page_sender_gender_text.tr,
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
                      child:
                          Text(LocaleKeys.profile_page_dropdown_female_text.tr),
                    ),
                    DropdownMenuItem(
                      value: "Male",
                      child:
                          Text(LocaleKeys.profile_page_dropdown_male_text.tr),
                    ),
                  ],
                  onChanged: (value) {
                    controller.selectedGender.value = value!;
                    logger("You have selected $value");
                  },
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          //   child: TextFieldWidget(
          //     labelText: 'Sender Gender',
          //     hintText: 'Sender Gender',
          //     controller: controller.gender,
          //     enabled: controller.enableForm,
          //     isRequired: false,
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: DropdownTextForm(
              isRequired: true,
              controller: controller,
              title: LocaleKeys.profile_page_sender_id_type_text.tr,
              widget: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            value: null,
                            hint: Text(
                                LocaleKeys.remittance_please_select_value.tr),
                            isExpanded: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            items: controller.customerDocTypeResponse
                                .map((e) => DropdownMenuItem(
                                    value: e.Data,
                                    child: Text('${e.Value}'.tr)))
                                .toList(),

                            onChanged: (value) {
                              controller.selectedCustomerType.value = value!;
                              //   //get value when changed
                              logger("You have selected $value");
                            },
                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys
                                    .remittance_please_select_id_type.tr;
                              }
                              return null;
                            },
                          );
                        },
                      ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.profile_page_sender_id_text.tr,
              hintText: 'Sender ID',
              controller: controller.id,
              suffixIcon: Tooltip(
                message: LocaleKeys.profile_page_sender_id_message_text.tr,
                waitDuration: const Duration(seconds: 1),
                showDuration: const Duration(seconds: 2),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                height: 35,
                textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
                child: const Icon(Icons.info),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              suffixIcon: const Tooltip(
                message: "Please follow format yyyy-mm-dd",
                waitDuration: Duration(seconds: 1),
                showDuration: Duration(seconds: 2),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                height: 35,
                textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
                child: Icon(Icons.info),
              ),
              controller: controller.dob,
              labelText: LocaleKeys.profile_page_date_of_birth_text.tr,
              hintText: 'xx-xx-xxxx',
              iconData: Icons.calendar_month,
              ontap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime dateDob = DateTime.now();

                logger(dateDob);

                DateTime? date = (await showDatePicker(
                    context: context,
                    initialDate: dateDob,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100)));

                if (date != null) {
                  // controller.dob.text = date.toIso8601String().split("T")[0];
                  controller.dob.text = dateOnlyFormat.format(date);
                  logger(controller.dob.text);
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.profile_page_date_of_birth_message_text.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: GestureDetector(
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
                          LocaleKeys.profile_page_nationality_text.tr,
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
                        // Obx(
                        //   () => Text(
                        //     // 'test',
                        //     nationalityController.nationality
                        //         .where((p0) =>
                        //             p0.cca2 ==
                        //             nationalityController
                        //                 .selectedNationality.value)
                        //         .first
                        //         .flag!,
                        //     style: const TextStyle(fontSize: 24),
                        //   ),
                        // ),
                        // const SizedBox(width: 20),
                        Obx(
                          () => Text(
                            nationalityController.selectedNationality.value,
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.profile_page_sender_address_text.tr,
              hintText: 'e.g: No 11, Jalan Persiaran',
              controller: controller.address1,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.profile_page_sender_address_message_text.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.profile_page_sender_city_text.tr,
              hintText: 'e.g: Cyberjaya',
              controller: controller.address2,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.profile_page_sender_city_message_text.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.profile_page_sender_state_text.tr,
              hintText: 'e.g: Selangor',
              controller: controller.address3,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.profile_page_sender_state_message_text.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              keyboardType: TextInputType.number,
              regex: r'[0-9]',
              labelText: LocaleKeys.profile_page_sender_postcode_text.tr,
              hintText: 'e.g: 63000',
              controller: controller.poscode,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys
                      .profile_page_sender_postcode_message_text.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const CountryView());
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
                          LocaleKeys.profile_page_country_text.tr,
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
                      children: [
                        Obx(
                          () => Text(
                            // 'test',
                            countryController.countries
                                .where((p0) =>
                                    p0.cca3 ==
                                    countryController.selectedCountryCode.value)
                                .first
                                .flag!,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Obx(
                          () => Text(
                            countryController.selectedCountry.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: DropdownTextForm(
              isRequired: true,
              controller: controller,
              title: LocaleKeys.profile_page_sender_occupation_text.tr,
              widget: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            value: null,
                            hint: Text(
                                LocaleKeys.remittance_please_select_value.tr),
                            isExpanded: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            items: controller.occupationResponse
                                .map((e) => DropdownMenuItem(
                                    value: e.Data,
                                    child: Text('${e.Value}'.tr)))
                                .toList(),

                            onChanged: (value) {
                              //   //get value when changed
                              controller.selectedOccupation.value = value!;
                              logger("You have selected $value");
                            },

                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys
                                    .remittance_please_select_occupation.tr;
                              }
                              return null;
                            },
                          );
                        },
                      ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: DropdownTextForm(
              isRequired: true,
              controller: controller,
              title: LocaleKeys.profile_page_sender_source_of_fund_text.tr,
              widget: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButtonFormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            value: null,
                            hint: Text(
                                LocaleKeys.remittance_please_select_value.tr),
                            isExpanded: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            items: controller.sourceOfFund
                                .map((e) => DropdownMenuItem(
                                    value: e.Data,
                                    child: Text('${e.Value}'.tr)))
                                .toList(),

                            onChanged: (value) {
                              //   //get value when changed
                              controller.selectedSourceFund.value = value!;
                            },
                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys
                                    .remittance_please_select_source.tr;
                              }
                              return null;
                            },
                          );
                        },
                      ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.remittance_company_name.tr,
              hintText: 'ABC Sdn Bhd',
              controller: controller.senderCompanyName,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.remittance_enter_company_name.tr;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SenderDetails extends StatelessWidget {
  const SenderDetails({super.key, required this.controller});

  final SenderInformationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextRow(
                          title: LocaleKeys.profile_page_name_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.customerName!),
                      TextRow(
                          title: LocaleKeys.profile_page_kyc_status_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.customerKycStatus!),
                      TextRow(
                          title: LocaleKeys.profile_page_contact_no_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.customerContactNo!),
                      TextRow(
                          title: LocaleKeys.profile_page_address_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderAddress!),
                      TextRow(
                          title: LocaleKeys.profile_page_state_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderState!),
                      TextRow(
                          title: LocaleKeys.profile_page_city_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderCity!),
                      TextRow(
                          title: LocaleKeys.profile_page_postcode_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderZipCode!),
                      TextRow(
                          title: LocaleKeys.profile_page_country_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderCountry!),
                      TextRow(
                          title: LocaleKeys.profile_page_email_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderEmail!),
                      TextRow(
                          title: LocaleKeys.profile_page_id_type_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.senderIdType!),
                      TextRow(
                          title:
                              LocaleKeys.profile_page_source_of_income_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.sourceOfIncome!),
                      TextRow(
                          title: LocaleKeys.profile_page_date_of_birth_text.tr,
                          subtitle: controller
                              .senderDetailsResponse!.data!.dateOfBirth!
                              .split(' ')
                              .first),
                      TextRow(
                          title: LocaleKeys.profile_page_gender_text.tr,
                          subtitle: gender(
                              controller.senderDetailsResponse!.data!.gender!)),
                      Row(
                        children: [
                          const Icon(
                            Icons.info,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodySmall,
                                children: [
                                  TextSpan(
                                      text: LocaleKeys
                                          .remittance_dislaimer_sender_info.tr),
                                  TextSpan(
                                    text: "servicedesk@berrypay.com.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
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
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 35,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.red[800]!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          subtitle.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge,
        ).paddingOnly(bottom: 20),
      ],
    );
  }
}

String gender(String gen) {
  switch (gen) {
    case 'F':
      return 'Female';

    case 'M':
      return 'Male';
  }
  return gen;
}
