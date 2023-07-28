import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dropdown.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';

import '../controllers/remittance_form_my_controller.dart';

class RemittanceFormMyView extends GetView<RemittanceFormMyController> {
  const RemittanceFormMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CountryController(RegisterRepo()));
    Get.put(NationalityController(RegisterRepo()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(LocaleKeys.remittance_remittance.tr,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
          child: Get.previousRoute == Routes.BENEFICIARY_INFO_MY
              ? EditForm(controller: controller)
              : Body(
                  controller: controller,
                  countryController: controller.countryController,
                )),
      bottomNavigationBar: BottomBar(controller: controller),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RemittanceFormMyController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoad.value
        ? const BerryPayLoading()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton.rectangle(
                onTap: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.onSubmit();
                  }
                },
                title: controller.getBeneficiaryResponse?.BeneficiaryId == null
                    ? LocaleKeys.remittance_next.tr
                    : LocaleKeys.update_text.tr),
          ));
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
    required this.countryController,
  }) : super(key: key);

  final RemittanceFormMyController controller;
  final CountryController countryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.remittance_fill_in_ben.tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              labelText: LocaleKeys.remittance_first_name.tr,
              hintText: 'e.g: Adam',
              iconData: Icons.person_outline,
              controller: controller.firstName,
              validator: (value) {
                final regex = RegExp('[0-9]');

                if (value!.isEmpty) {
                  return '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_first_name.tr}';
                } else if (regex.hasMatch(value)) {
                  return LocaleKeys.remittance_error_contain_num.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            TextFieldWidget(
              labelText: LocaleKeys.remittance_last_name.tr,
              hintText: 'e.g: Sandler',
              iconData: Icons.person_outline,
              controller: controller.lastName,
              validator: (value) {
                final regex = RegExp('[0-9]');
                if (value!.isEmpty) {
                  return '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_last_name.tr}';
                } else if (regex.hasMatch(value)) {
                  return LocaleKeys.remittance_error_contain_num.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            DropdownTextForm(
              isRequired: false,
              controller: controller,
              title: LocaleKeys.remittance_ben_id_type.tr,
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
                              controller.selectedIdType?.value = value!;
                              //   //get value when changed
                              logger("You have selected $value");
                            },
                            // validator: (value) {
                            //   if (value == null) {
                            //     return LocaleKeys
                            //         .remittance_please_select_id_type.tr;
                            //   }
                            //   return null;
                            // },
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 15),

            TextFieldWidget(
              labelText: LocaleKeys.remittance_ben_id.tr,
              hintText: 'XXXXXXXXXX',
              isRequired: false,
              iconData: Icons.co_present_outlined,
              controller: controller.beneficiaryId,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "Please enter beneficiary ID";
              //   }
              //   return null;
              // },
            ),

            const SizedBox(height: 15),

            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => const CountryView());
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.only(
            //         top: 20, bottom: 10, left: 20, right: 20),
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: const BorderRadius.all(Radius.circular(10)),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.grey.shade200,
            //               blurRadius: 10,
            //               offset: const Offset(0, 5)),
            //         ],
            //         border: Border.all(
            //             color: Colors.grey.shade200.withOpacity(0.05))),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: [
            //         Row(
            //           children: [
            //             Text(
            //               'Beneficiary Nationality',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .titleLarge!
            //                   .copyWith(fontSize: 15),
            //               textAlign: TextAlign.start,
            //             ),
            //             const SizedBox(
            //               width: 5,
            //             ),
            //             Text(
            //               '*',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .titleLarge!
            //                   .copyWith(color: Colors.red),
            //               textAlign: TextAlign.start,
            //             )
            //           ],
            //         ),
            //         const SizedBox(height: 10),
            //         Row(
            //           children: [
            //             Obx(
            //               () => Text(
            //                 // 'test',
            //                 countryController.countries
            //                     .where((p0) =>
            //                         p0.cca3 ==
            //                         countryController.selectedCountryCode.value)
            //                     .first
            //                     .flag!,
            //                 style: const TextStyle(fontSize: 24),
            //               ),
            //             ),
            //             const SizedBox(width: 20),
            //             Obx(
            //               () => Text(
            //                 countryController.selectedCountry.value,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodySmall!
            //                     .copyWith(color: Colors.grey),
            //               ),
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            // TextFieldWidget(
            //   controller: controller.dob,
            //   labelText: 'Date of Birth',
            //   hintText: 'xx-xx-xxxx',
            //   iconData: Icons.calendar_month,
            //   ontap: () async {
            //     FocusScope.of(context).requestFocus(FocusNode());
            //     DateTime dateDob = DateTime.now();

            //     logger(dateDob);

            //     DateTime? date = (await showDatePicker(
            //         context: context,
            //         initialDate: dateDob,
            //         firstDate: DateTime(1900),
            //         lastDate: DateTime(2100)));

            //     if (date != null) {
            //       controller.dob.text = date.toIso8601String().split("T")[0];
            //       logger(controller.dob.text);
            //     }
            //   },
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return "Please enter date of birth";
            //     }
            //     return null;
            //   },
            // ),
            // const SizedBox(height: 15),

            // DropdownTextForm(
            //   controller: controller,
            //   title: 'Beneficiary Gender',
            //   widget: DropdownButton(
            //     // Initial Value
            //     value: controller.selectedGender.value,
            //     underline: Container(),
            //     isExpanded: true,
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodySmall!
            //         .copyWith(color: Colors.grey),

            //     // Down Arrow Icon
            //     icon: const Icon(Icons.keyboard_arrow_down),

            //     items: const [
            //       //add items in the dropdown
            //       DropdownMenuItem(
            //         child: Text("Female"),
            //         value: "Female",
            //       ),
            //       DropdownMenuItem(
            //         child: Text("Male"),
            //         value: "Male",
            //       ),
            //     ],

            //     onChanged: (value) {
            //       //   //get value when changed
            //       controller.selectedGender.value = value!;
            //       logger("You have selected $value");
            //     },
            //   ),
            // ),

            // const SizedBox(height: 15),
            TextFieldWidget(
              regex: '[^-.,\\s]',
              labelText: LocaleKeys.remittance_phone_no.tr,
              hintText: 'e.g: 0123456789',
              iconData: Icons.phone,
              keyboardType: TextInputType.number,
              controller: controller.phoneNum,
              validator: (value) {
                // final regex = RegExp('[,-<>.^*()%!+;:/#&"?]');
                var regex = RegExp(r"^[0-9]+$");
                if (value!.isEmpty) {
                  return '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_phone_no.tr}';
                } else if (!value.contains(regex)) {
                  return LocaleKeys.register_page_invalid_format_text.tr;
                }
                return null;
              },
            ),

            const SizedBox(height: 15),
            // TextFieldWidget(
            //   labelText: 'Recipient Email',
            //   hintText: 'Enter recipient email (Optional)',
            //   iconData: Icons.email,
            //   controller: controller.email,
            //   isRequired: false,
            // ),

            // const SizedBox(height: 15),

            DropdownTextForm(
              isRequired: true,
              controller: controller,
              title: LocaleKeys.remittance_relationship.tr,
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

                            items: controller.relationshipResponse
                                .map((e) => DropdownMenuItem(
                                    value: e.Data,
                                    child: Text('${e.Value}'.tr)))
                                .toList(),

                            onChanged: (value) {
                              //   //get value when changed
                              controller.selectedRelationship?.value = value!;
                              logger("You have selected $value");
                            },
                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys
                                    .remittance_please_select_relationship.tr;
                              }
                              return null;
                            },
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 15),
            TextFieldWidget(
              isRequired: false,
              labelText: LocaleKeys.remittance_address.tr,
              hintText: 'e.g: No 1234 Jalan Perdana',
              iconData: Icons.location_on_outlined,
              controller: controller.address1,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "Please enter address";
              //   }
              //   return null;
              // },
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              isRequired: false,
              labelText: LocaleKeys.remittance_city.tr,
              hintText: 'e.g: Surabaya',
              iconData: Icons.location_on_outlined,
              controller: controller.address2,
            ),

            const SizedBox(height: 15),

            TextFieldWidget(
              isRequired: false,
              labelText: LocaleKeys.remittance_state.tr,
              hintText: 'e.g: Jawa Timur',
              iconData: Icons.location_on_outlined,
              controller: controller.address3,
            ),
            const SizedBox(height: 15),

            TextFieldWidget(
              isRequired: false,
              labelText: LocaleKeys.remittance_poscode.tr,
              hintText: 'e.g: 43300',
              iconData: Icons.location_on_outlined,
              controller: controller.poscode,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            Obx(
              () => TextFieldWidget(
                enabled: false,
                // divider: true,
                isRequired: false,
                labelText: LocaleKeys.remittance_country.tr,
                hintText: controller.beneficiaryCountry?.value,
                iconData: Icons.location_on_outlined,
                controller: controller.country,
              ),
            ),

            const SizedBox(height: 15),

            Obx(
              () => controller.agentResponse.isEmpty
                  ? Container()
                  : DropdownTextForm(
                      controller: controller,
                      title: LocaleKeys.remittance_bank_name.tr,
                      widget: Obx(
                        () => controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownButton(
                                // Initial Value

                                value:
                                    "${controller.selectedAgent?.value}_${controller.selectedAgentBank?.value}",
                                underline: Container(),
                                isExpanded: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey),

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                items: controller.agentResponse
                                    .map((e) => DropdownMenuItem(
                                        value:
                                            '${e.LocationId}_${e.LocationName}',
                                        child: Text(
                                            '${e.LocationName?.toUpperCase()}')))
                                    .toList(),

                                onChanged: (value) {
                                  controller.selectedAgent?.value = value!;

                                  controller.selectedAgent?.value =
                                      value!.split('_').first;

                                  controller.selectedAgentBank?.value =
                                      value!.split('_').last;

                                  logger(
                                      'value ${controller.selectedAgent?.value}');

                                  logger(
                                      'value ${controller.selectedAgentBank?.value}');
                                },
                              ),
                      ),
                    ),
            ),

            const SizedBox(height: 15),
            TextFieldWidget(
              labelText: LocaleKeys.remittance_acc_no.tr,
              hintText: LocaleKeys.remittance_enter_bank_no.tr,
              iconData: Icons.credit_card_outlined,
              controller: controller.bankAcc,
              keyboardType: TextInputType.number,
              maxLength: 35,
              validator: (value) {
                if (value!.isEmpty) {
                  return "${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_acc_no.tr}";
                }
                return null;
              },
            ),

            const SizedBox(height: 15),
            controller.receiverCountry == 'BGD' ||
                    controller.receiverCountry == 'IND'
                ? Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : DropdownTextForm(
                            controller: controller.district,
                            title: LocaleKeys.remittance_district.tr,
                            widget: TypeAheadFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys
                                      .remittance_please_select_district.tr;
                                }
                                return null;
                              },
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(),
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Theme.of(context).textTheme.bodySmall,
                                controller: controller.district,
                                decoration: InputDecoration(
                                  suffixIcon:
                                      const Icon(Icons.keyboard_arrow_down),
                                  hintText: LocaleKeys
                                      .remittance_select_branch_name.tr,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                              hideOnEmpty: false,
                              suggestionsCallback: (pattern) async {
                                logger(pattern);

                                // controller.branchName.text = "";
                                // controller.branchCode.text = "";

                                return await controller.getDistrict(
                                    controller.selectedAgentBank!.value,
                                    pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(
                                    suggestion,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                );
                              },
                              noItemsFoundBuilder: (context) =>
                                  Text(LocaleKeys.remittance_not_found.tr),
                              onSuggestionSelected: (String suggestion) {
                                logger(
                                    'suggestion :: ${jsonEncode(suggestion)}');
                                controller.district.text = suggestion;
                              },
                            ),
                          ),
                  ).paddingOnly(bottom: 15)
                : Container(),
            // const SizedBox(
            //   height: 15,
            // ),

            controller.receiverCountry == 'BGD' ||
                    controller.receiverCountry == 'IND'
                ? Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : DropdownTextForm(
                            controller: null,
                            title: LocaleKeys.remittance_branch_name.tr,
                            widget: TypeAheadFormField<DataBranchCode>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys
                                      .remittance_please_select_branch.tr;
                                }
                                return null;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Theme.of(context).textTheme.bodySmall,
                                controller: controller.branchName,
                                decoration: InputDecoration(
                                  floatingLabelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  suffixIcon:
                                      const Icon(Icons.keyboard_arrow_down),
                                  hintText: LocaleKeys
                                      .remittance_select_branch_name.tr,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                              hideOnEmpty: false,
                              errorBuilder: (context, error) =>
                                  const Text("Invalid District"),
                              noItemsFoundBuilder: (context) =>
                                  Text(LocaleKeys.remittance_not_found.tr),
                              suggestionsCallback: (pattern) async {
                                logger(pattern);
                                // controller.branchCode.text = "";

                                return await controller.getBranchCode(
                                    controller.district.text,
                                    controller.selectedAgentBank!.value,
                                    pattern);
                              },
                              itemBuilder:
                                  (context, DataBranchCode suggestion) {
                                return ListTile(
                                  title: Text(
                                      '${suggestion.branchCode!} - ${suggestion.branchName!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                );
                              },
                              onSuggestionSelected:
                                  (DataBranchCode suggestion) {
                                logger(
                                    'suggestion :: ${jsonEncode(suggestion)}');
                                controller.branchName.text =
                                    suggestion.branchName!;
                                controller.branchCode.text =
                                    suggestion.branchCode!;
                              },
                            ),
                          ),
                  ).paddingOnly(bottom: 15)
                : Container(),
            // const SizedBox(
            //   height: 15,
            // ),

            controller.receiverCountry == 'BGD' ||
                    controller.receiverCountry == 'IND'
                ? TextFieldWidget(
                    enabled: false,
                    labelText: LocaleKeys.remittance_branch_code.tr,
                    hintText: 'xxxxxxx',
                    iconData: Icons.account_balance,
                    controller: controller.branchCode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_branch_code.tr}';
                      }
                      return null;
                    },
                  ).marginOnly(bottom: 15)
                : Container(),

            DropdownTextForm(
              isRequired: true,
              controller: controller,
              title: LocaleKeys.remittance_purpose_txn.tr,
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

                            items: controller.transactionPurposeResponse
                                .map((e) => DropdownMenuItem(
                                    value: e.Data,
                                    child: Text('${e.Value}'.tr)))
                                .toList(),

                            onChanged: (value) {
                              controller.selectedTransactionPurpose?.value =
                                  value!;
                              //   //get value when changed
                              logger("You have selected $value");
                            },
                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys
                                    .remittance_please_select_purpose.tr;
                              }
                              return null;
                            },
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 15),

            DropdownTextForm(
              isRequired: true,
              controller: controller,
              title: LocaleKeys.remittance_source_fund.tr,
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
                              controller.selectedSourceFund?.value = value!;

                              //   //get value when changed
                              logger("You have selected $value");
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

            // controller.receiverCountry == 'BGD' ||
            //         controller.receiverCountry == 'IND'
            //     ? TextFieldWidget(
            //         labelText: LocaleKeys.remittance_branch_code.tr,
            //         hintText: 'xxxxxxx',
            //         iconData: Icons.account_balance,
            //         controller: controller.branchCode,
            //         validator: (value) {
            //           if (value!.isEmpty) {
            //             return '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_branch_code.tr}';
            //           }
            //           return null;
            //         },
            //       )
            //     : Container(),

            // DropdownTextForm(
            //   controller: controller,
            //   title: 'Payment Mode',
            //   widget: Obx(
            //     () => controller.isLoading.value
            //         ? const Center(child: CircularProgressIndicator())
            //         : DropdownButton(
            //             // Initial Value
            //             value:
            //                 '${controller.selectedPaymentMode.value}_${controller.selectedPaymentCode.value}',
            //             underline: Container(),
            //             isExpanded: true,
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodySmall!
            //                 .copyWith(color: Colors.grey),

            //             // Down Arrow Icon
            //             icon: const Icon(Icons.keyboard_arrow_down),

            //             items: controller.paymentModeResponse
            //                 .map((e) => DropdownMenuItem(
            //                     value: '${e.Data}_${e.AdditionalValue}',
            //                     child: Text('${e.Data} - ${e.Value}')))
            //                 .toList(),

            //             onChanged: (value) {
            //               controller.selectedPaymentMode.value = value!;

            //               controller.selectedPaymentMode.value =
            //                   value.split('_').first;

            //               controller.selectedPaymentCode.value =
            //                   value.split('_').last;

            //               controller.getAgent(AgentRequest(
            //                 paymentMode: controller.selectedPaymentMode.value,
            //                 payoutCountry:
            //                     controller.receiverCountry?.toUpperCase(),
            //               ));
            //             },
            //           ),
            //   ),
            // ),

            const SizedBox(height: 15),

            // TextFieldWidget(
            //   labelText: 'Purpose',
            //   hintText: 'Enter transfer purpose',
            //   iconData: Icons.assignment,
            //   controller: controller.purpose,
            // ),
            // const SizedBox(height: 15),
            // TextFieldWidget(
            //   labelText: 'Recipient Email',
            //   hintText: 'Enter recipient email (Optional)',
            //   iconData: Icons.email,
            //   controller: controller.email,
            // ),
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class EditForm extends StatelessWidget {
  const EditForm({super.key, required this.controller});

  final RemittanceFormMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.remittance_edit.tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              labelText: LocaleKeys.remittance_beneficiary_name.tr,
              hintText: 'e.g: Adam',
              iconData: Icons.person_outline,
              controller: controller.firstName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_name.tr}";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              labelText: LocaleKeys.remittance_phone_no.tr,
              hintText: 'e.g: 0123456789',
              iconData: Icons.phone,
              keyboardType: TextInputType.number,
              controller: controller.phoneNum,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys
                      .profile_page_please_enter_phone_number_text.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              labelText: LocaleKeys.remittance_email.tr,
              hintText:
                  '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_email.tr} (${LocaleKeys.remittance_optional.tr})',
              iconData: Icons.email,
              controller: controller.email,
              isRequired: false,
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              labelText: LocaleKeys.remittance_acc_no.tr,
              hintText:
                  '${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_acc_no.tr}',
              iconData: Icons.credit_card_outlined,
              controller: controller.bankAcc,
              keyboardType: TextInputType.number,
              maxLength: 35,
              validator: (value) {
                if (value!.isEmpty) {
                  return "${LocaleKeys.remittance_err_please_enter.tr} ${LocaleKeys.remittance_acc_no.tr}";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownTextForm(
              controller: controller,
              title: LocaleKeys.remittance_ben_relationship.tr,
              widget: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton(
                        // Initial Value
                        value: controller.selectedRelationship?.value,
                        underline: Container(),
                        isExpanded: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey),

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        items: controller.relationshipResponse
                            .map((e) => DropdownMenuItem(
                                value: e.Data, child: Text('${e.Value}'.tr)))
                            .toList(),

                        onChanged: (value) {
                          //   //get value when changed
                          controller.selectedRelationship?.value = value!;
                          logger("You have selected $value");
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
