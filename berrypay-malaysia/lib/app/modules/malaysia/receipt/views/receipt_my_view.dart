import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dotted_seperator.dart';
import 'package:berrypay_global_x/app/global_widgets/text_info.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/remittance_receipt_my/views/remittance_receipt_my_view.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/receipt_my_controller.dart';

class ReceiptMyView extends GetView<ReceiptMyController> {
  const ReceiptMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: const Alignment(5.0, 1.0),
          colors: [Colors.red[800]!, Colors.blue[800]!],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.red[800],
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            title: Text(
              LocaleKeys.transaction_page_receipt_text.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 3.0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Image.asset(
                                    "assets/images/bp-logo.png",
                                    width: 50,
                                  ),
                                ),
                              ),
                              const Center(child: Text("BerryPay Malaysia")),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: MySeparator(),
                              ),
                              Center(
                                  child: Text('RM ${controller.amount}',
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.red))),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: MySeparator(),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextInfo(
                                      title: LocaleKeys
                                          .transaction_page_transaction_type_text
                                          .tr,
                                      subtitle: controller.txnType.value,
                                    ),
                                    const SizedBox(height: 16),
                                    transactionType(controller.txnType.value),

                                    TextInfo(
                                        title: LocaleKeys
                                            .transaction_page_date_time_text.tr,
                                        subtitle: controller.dateTime ?? "-"),
                                    const SizedBox(height: 16),
                                    TextInfo(
                                        title: LocaleKeys
                                            .transaction_page_transaction_id_text
                                            .tr,
                                        subtitle: controller.txnId ?? "-"),
                                    const SizedBox(height: 16),
                                    TextInfo(
                                      title: LocaleKeys
                                          .transaction_page_payment_status_text
                                          .tr,
                                      subtitle: controller.status ?? "-",
                                      subtitleColor: colorStatus(
                                          controller.status ?? "FAILED"),
                                    ),

                                    const SizedBox(height: 16),

                                    controller.txnType.value == 'Remittance'
                                        ? TextInfo(
                                            title: LocaleKeys
                                                .transaction_page_remittance_status_text
                                                .tr,
                                            subtitleColor: colorStatus(
                                                controller.statusRemit!),
                                            subtitle:
                                                controller.statusRemit ?? "-",
                                          ).marginOnly(bottom: 16)
                                        : Container(),

                                    controller.txnType.value == 'Biller'
                                        ? TextInfo(
                                            title: LocaleKeys
                                                .biller_biller_status.tr,
                                            subtitleColor: colorStatus(
                                                controller.statusRemit!),
                                            subtitle:
                                                controller.statusRemit ?? "-",
                                          ).marginOnly(bottom: 16)
                                        : Container(),

                                    // controller.paymentMode == 'Payment Gateway'
                                    //     ? TextInfo(
                                    //         title: "Processing Fee",
                                    //         subtitle: LocaleKeys
                                    //             .disclaimer_payment.tr,
                                    //       ).marginOnly(bottom: 16)
                                    //     : Container(),

                                    // controller.txnType.value == 'Remittance'
                                    //     ? TextInfo(
                                    //         title: 'Description',
                                    //         subtitle:
                                    //             controller.description ?? "-",
                                    //       ).marginOnly(bottom: 16)
                                    //     : Container(),

                                    controller.status == "Failed" &&
                                            controller.txnType.value == "Topup"
                                        ? TextInfo(
                                            title: LocaleKeys
                                                .transaction_page_description_text
                                                .tr,
                                            subtitle:
                                                controller.description ?? "-",
                                          )
                                        : TextInfo(
                                            title: LocaleKeys
                                                .transaction_page_card_balance_text
                                                .tr
                                                .tr,
                                            subtitle:
                                                controller.cardBalance ?? "-",
                                          ),
                                    // const SizedBox(height: 16),

                                    // TextInfo(
                                    //   title: 'Card Balance',
                                    //   subtitle: controller.cardBalance ?? "-",
                                    // ),
                                    controller.txnType.value == 'Remittance' &&
                                            controller.status == 'SUCCESS' &&
                                            controller.statusRemit != 'SUCCESS'

                                        //  &&  controller.status != 'Failed'
                                        ? Text(
                                            LocaleKeys
                                                .transaction_page_payment_success_message_text
                                                .tr,
                                            textAlign: TextAlign.justify,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ).paddingOnly(top: 20)
                                        : const SizedBox()
                                  ])
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: AppButton.rounded(
              title: LocaleKeys.transaction_page_done_text.tr,
              border: Colors.red,
              onTap: controller.proceed,
            ),
          )),
    );
  }

  Widget transactionType(String txnType) {
    switch (txnType) {
      case "Pay":
        return TextInfo(
                title: LocaleKeys.transaction_page_merchant_name_text.tr,
                subtitle: controller.merchant ?? "-")
            .marginOnly(bottom: 16);

      case "Transfer":
        return TextInfo(
                title: LocaleKeys.transaction_page_name_text.tr,
                subtitle: controller.name!)
            .marginOnly(bottom: 16);
      case "Withdrawal":
        return TextInfo(
                title: LocaleKeys.transaction_page_account_name_text.tr,
                subtitle: controller.txnMethod!)
            .marginOnly(bottom: 16);
      case "Topup":
        return TextInfo(
                title: LocaleKeys.transaction_page_topup_method_text.tr,
                subtitle: controller.txnMethod!)
            .marginOnly(bottom: 16);
      default:
        return const SizedBox();
    }
  }
}

class TextInfoModel {
  final String title;
  final String subtitle;

  TextInfoModel(this.title, this.subtitle);
}

Color colorStatus(String status) {
  switch (status) {
    case "PENDING":
      return Colors.orange;
    case "Pending":
      return Colors.orange;

    case "FAILED":
      return Colors.red;

    case "Failed":
      return Colors.red;

    case "SUCCESS":
      return Colors.green;

    case "Success":
      return Colors.green;

    default:
      return Colors.black;
  }
}
