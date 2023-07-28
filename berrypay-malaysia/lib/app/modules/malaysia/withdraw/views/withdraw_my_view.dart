import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/topup/topup.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/withdraw_my_controller.dart';

class WithdrawMyView extends GetView<WithdrawMyController> {
  const WithdrawMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          LocaleKeys.home_withdraw.tr,
          style: const TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Message(),
                const SizedBox(
                  height: 20,
                ),
                BankForm(
                  controller: controller,
                  bankDetails: controller.bankDetails,
                  cardBalance: controller.cardBalance,
                  accountNo: controller.accountNo,
                  fullName: controller.fullName,
                  bankName: controller.bankName,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppButton.rounded(
            onTap: () {
              if (controller.bankName.value.isEmpty) {
                controller.bank!.value =
                    LocaleKeys.withdrawal_please_enter_account_number.tr;
              }
              if (controller.formKey.currentState!.validate() &&
                  controller.bankName.value.isNotEmpty) {
                controller.submitWithdrawal();
              }
            },
            title: LocaleKeys.proceed.tr,
          ),
        ),
      ),
    );
  }
}

class BankForm extends StatelessWidget {
  const BankForm(
      {Key? key,
      required this.bankDetails,
      required this.cardBalance,
      required this.accountNo,
      required this.fullName,
      required this.bankName,
      required this.controller})
      : super(key: key);

  final RxList<SSParameterVO> bankDetails;
  final RxNum cardBalance;
  final TextEditingController accountNo;
  final TextEditingController fullName;
  final RxString bankName;
  final WithdrawMyController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            // margin: const EdgeInsets.only(top: 10, bottom: 20),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      LocaleKeys.transaction_page_bank_name_text.tr,
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
                    ),
                  ],
                ),
                RawAutocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    } else {
                      List<String> matches = <String>[];
                      matches.addAll(
                        bankDetails
                            .map((element) => element.paramName!)
                            .toList(),
                      );

                      matches.retainWhere((s) {
                        return s
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                      return matches;
                    }
                  },
                  onSelected: (value) => bankName.value = value,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () => textEditingController.clear(),
                          child: const Icon(Icons.close_rounded),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: LocaleKeys.home_enter_bank_name.tr,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                        border: InputBorder.none,
                        icon: const Icon(Icons.account_balance),
                      ),
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: (value) => bankName.value = value,
                      // onSubmitted: controller.onSelected,
                    );
                  },
                  // onSelected: controller.onSelected,
                  optionsViewBuilder: (BuildContext context,
                      void Function(String) onSelected,
                      Iterable<String> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 16,
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              String option = options.elementAt(index);
                              return ListTile(
                                title: Text(option),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Obx(
                  () => bankName.value.isNotEmpty
                      ? Container()
                      : Text(controller.bank!.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Color.fromARGB(255, 216, 67, 67)))
                          .marginOnly(top: 5)
                          .paddingOnly(left: 40),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            keyboardType: TextInputType.number,
            controller: accountNo,
            textInputAction: TextInputAction.done,
            labelText: LocaleKeys.transaction_page_account_no_text.tr,
            hintText: LocaleKeys.withdrawal_set_account_no.tr,
            iconData: Icons.credit_card,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.withdrawal_please_enter_account_number.tr;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: fullName,
            textInputAction: TextInputAction.done,
            labelText: LocaleKeys.home_full_name.tr,
            hintText: LocaleKeys.kyc_page_enter_fullname.tr,
            iconData: Icons.person,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.edit_profile_page_please_enter_fullname.tr;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: controller.amount,
            textInputAction: TextInputAction.done,
            labelText: LocaleKeys.amount_text.tr,
            hintText: LocaleKeys.enter_amount.tr,
            iconData: Icons.money,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return LocaleKeys.amp_form_page_please_enter_amount.tr;
              } else if (num.parse(value!) > cardBalance.value) {
                return LocaleKeys.withdrawal_balance_not_enough.tr;
              } else if (value == '0.00') {
                return LocaleKeys.amp_form_page_please_enter_amount.tr;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info,
              color: Colors.amber,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(LocaleKeys.withdrawal_withdrawal_disclaimer1.tr,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info,
              color: Colors.amber,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(LocaleKeys.withdrawal_withdrawal_disclaimer.tr,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        )
      ],
    );
  }
}
