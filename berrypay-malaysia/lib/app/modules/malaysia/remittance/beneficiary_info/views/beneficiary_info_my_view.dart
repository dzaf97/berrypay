import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/beneficiary_info_my_controller.dart';

class BeneficiaryInfoMyView extends GetView<BeneficiaryInfoMyController> {
  const BeneficiaryInfoMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Beneficiary Info',
            onPressed: controller.editBeneficiary,
          ),
        ],
        backgroundColor: AppColor.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Beneficiary',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Body(
        controller: controller,
      ),
      bottomNavigationBar: BottomBar(controller: controller),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });
  final BeneficiaryInfoMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 8, top: 8),
                child: Text(
                  LocaleKeys.remittance_ben_detail.tr.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  right: BorderSide(color: Colors.grey.shade300),
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ColumnTitle(
                          title1: LocaleKeys.remittance_first_name.tr,
                          title2: LocaleKeys.remittance_last_name.tr,
                          title3: LocaleKeys.remittance_ben_id.tr,
                          title4: LocaleKeys.remittance_ben_id_type.tr,
                          title5: LocaleKeys.remittance_phone_no.tr,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ColumnSubtitle(
                          subtitle1: controller
                              .getBeneficiaryResponse!.Nameenglish!.Firstname!,
                          subtitle2: controller
                              .getBeneficiaryResponse!.Nameenglish!.Lastname!,
                          subtitle3: controller.getBeneficiaryResponse!
                              .Beneficiarydetail!.Beneficiaryidnumber!,
                          subtitle4: controller.getBeneficiaryResponse!
                              .Beneficiarydetail!.Beneficiaryidtype,
                          subtitle5:
                              controller.getBeneficiaryResponse!.Mobilenumber!,
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     const ColumnTitle(
                    //       title1: 'Birthday',
                    //       title2: 'Gender',
                    //       title3: 'Phone Number',
                    //       title4: 'Email',
                    //     ),
                    //     const SizedBox(
                    //       width: 20,
                    //     ),
                    //     ColumnSubtitle(
                    //       subtitle1:
                    //           controller.getBeneficiaryResponse!.Birthday!,
                    //       subtitle2: controller.getBeneficiaryResponse!.Gender!,
                    //       subtitle3:
                    //           controller.getBeneficiaryResponse!.Mobilenumber!,
                    //       subtitle4:
                    //           controller.getBeneficiaryResponse!.Emailaddress,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 8, top: 8),
                child: Text(
                  LocaleKeys.remittance_address_detail.tr.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  right: BorderSide(color: Colors.grey.shade300),
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ColumnTitle(
                          title1: LocaleKeys.remittance_address.tr,
                          title2: LocaleKeys.remittance_city.tr,
                          title3: LocaleKeys.remittance_state.tr,
                          title4: LocaleKeys.remittance_poscode.tr,
                          title5: LocaleKeys.remittance_country.tr,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ColumnSubtitle(
                          subtitle1: controller.getBeneficiaryResponse!
                              .Addressinfo!.Addressstreet!,
                          subtitle2: controller.getBeneficiaryResponse!
                              .Addressinfo!.Addresscitytown!,
                          subtitle3: controller.getBeneficiaryResponse!
                              .Addressinfo!.Addressstateprovince!,
                          subtitle4: controller
                              .getBeneficiaryResponse!.Addressinfo!.Zipcode,
                          subtitle5: controller.countryName,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 8, top: 8),
                child: Text(
                  LocaleKeys.remittance_bank_detail.tr.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  right: BorderSide(color: Colors.grey.shade300),
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ColumnTitle(
                          title1: LocaleKeys.remittance_acc_no.tr,
                          title2: LocaleKeys.remittance_bank_name.tr,
                          title3: LocaleKeys.remittance_bank_code.tr,
                          title4: LocaleKeys.remittance_branch_code.tr,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ColumnSubtitle(
                          subtitle1: controller.getBeneficiaryResponse!
                              .Beneficiarydetail!.Accountnumber!,
                          subtitle2: controller.getBeneficiaryResponse!
                              .Beneficiarydetail!.Bankname!,
                          subtitle3: controller.getBeneficiaryResponse!
                              .Beneficiarydetail!.Bankcode!,
                          subtitle4: controller.getBeneficiaryResponse
                              ?.Beneficiarydetail?.Branchcode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 8, top: 8),
                child: Text(
                  LocaleKeys.remittance_txn_detail.tr.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  right: BorderSide(color: Colors.grey.shade300),
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ColumnTitle(
                          title1: LocaleKeys.remittance_relationship.tr,
                          title2: LocaleKeys.remittance_payment_mode.tr,
                          title3: LocaleKeys.remittance_transfer_nick_name.tr,
                          // title4: 'Transaction Purpose',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ColumnSubtitle(
                          subtitle1: controller.getBeneficiaryResponse!
                              .Relationshipwithbeneficiaryvalue!,
                          subtitle2: 'Bank Transfer',
                          subtitle3: controller.getBeneficiaryResponse!
                              .Beneficiarydetail!.Transfernickname!,
                          // subtitle4: '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Row(
            //   children: [
            //     const Icon(Icons.info),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: Text(
            //         'Please select Payment Mode and Agent before proceed to transfer to the same beneficiary',
            //         style: Theme.of(context).textTheme.bodySmall,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
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
            //                 payoutCountry: controller.getBeneficiaryResponse!
            //                     .Beneficiarydetail!.Countrycode
            //                     ?.toUpperCase(),
            //               ));
            //             },
            //           ),
            //   ),
            // ),
            // const SizedBox(height: 15),
            // Obx(
            //   () => controller.agentResponse.isEmpty
            //       ? Container()
            //       : DropdownTextForm(
            //           controller: controller,
            //           title: 'Agent',
            //           widget: Obx(
            //             () => controller.isLoading.value
            //                 ? const Center(child: CircularProgressIndicator())
            //                 : DropdownButton(
            //                     // Initial Value
            //                     value: controller.selectedAgent.value,
            //                     underline: Container(),
            //                     isExpanded: true,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodySmall!
            //                         .copyWith(color: Colors.grey),

            //                     // Down Arrow Icon
            //                     icon: const Icon(Icons.keyboard_arrow_down),

            //                     items: controller.agentResponse
            //                         .map((e) => DropdownMenuItem(
            //                             value: e.LocationId,
            //                             child: Text(
            //                                 '${e.LocationId} - ${e.LocationName}')))
            //                         .toList(),

            //                     onChanged: (value) {
            //                       controller.selectedAgent.value = value!;
            //                     },
            //                   ),
            //           ),
            //         ),
            // ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnSubtitle extends StatelessWidget {
  const ColumnSubtitle({
    super.key,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle3,
    this.subtitle4,
    this.subtitle5,
  });
  final String subtitle1;
  final String subtitle2;
  final String subtitle3;
  final String? subtitle4;
  final String? subtitle5;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle1,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500, color: Colors.grey.shade800),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitle2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500, color: Colors.grey.shade800),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitle3,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500, color: Colors.grey.shade800),
          ),
          const SizedBox(
            height: 10,
          ),
          subtitle4 != null
              ? Text(
                  subtitle4!,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.grey.shade800),
                )
              : const SizedBox(),
          subtitle5 != null
              ? Text(
                  subtitle5!,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.grey.shade800),
                ).paddingOnly(top: 10)
              : const SizedBox(),
        ],
      ),
    );
  }
}

class ColumnTitle extends StatelessWidget {
  const ColumnTitle({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    this.title4,
    this.title5,
  });

  final String title1;
  final String title2;
  final String title3;
  final String? title4;
  final String? title5;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title1:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$title2:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$title3:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 10,
        ),
        title4 != null
            ? Text(
                '$title4:',
                style: Theme.of(context).textTheme.bodySmall,
              )
            : const SizedBox(),
        title5 != null
            ? Text(
                '$title5:',
                style: Theme.of(context).textTheme.bodySmall,
              ).paddingOnly(top: 10)
            : const SizedBox(),
      ],
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BeneficiaryInfoMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppButton.rectangle(
          onTap: () {
            if (controller.getBeneficiaryResponse!.Addressinfo!
                .Addresscountrycode!.isEmpty) {
              logger('aaa');

              Get.dialog(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 30,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  LocaleKeys.remittance_something_went_wrong.tr,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  LocaleKeys.remittance_detail_not_complete.tr,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                //Buttons
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );

              logger('vv');
            } else if (controller.agentFilter.isEmpty) {
              Get.dialog(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 30,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  LocaleKeys.remittance_something_went_wrong.tr,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  LocaleKeys.remittance_location_not_exist.tr,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                //Buttons
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              controller.onSubmit();
            }
          },
          title: LocaleKeys.next_text.tr),
    );
  }
}
