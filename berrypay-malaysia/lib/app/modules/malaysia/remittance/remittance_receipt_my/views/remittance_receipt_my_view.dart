import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dotted_seperator.dart';
import 'package:berrypay_global_x/app/global_widgets/text_info.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/remittance_receipt_my_controller.dart';

class RemittanceReceiptMyView extends GetView<RemittanceReceiptMyController> {
  const RemittanceReceiptMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
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
              title: const Text(
                'Receipt',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            body: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      heightFactor: 10,
                      child: CircularProgressIndicator(
                        color: AppColor.white,
                      ))
                  : Body(controller: controller),
            ),
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: AppButton.rounded(
                  title: 'Done',
                  border: Colors.red,
                  onTap: () {
                    controller.proceed();
                  }),
            )),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final RemittanceReceiptMyController controller;

  @override
  Widget build(BuildContext context) {
    return controller.paymentRequery == null
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Try again',
              style: TextStyle(color: AppColor.white),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                child: controller.paymentRequery?.paymentType == "Billers"
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                child: Text(
                                    'RM ${(controller.paymentRequery!.bizSysAmount! + controller.paymentRequery!.bizSysFee!).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.red))),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: MySeparator(),
                            ),
                            TextInfo(
                                    title: LocaleKeys
                                        .transaction_page_transaction_type_text
                                        .tr,
                                    subtitle:
                                        controller.paymentRequery!.paymentType!)
                                .paddingOnly(bottom: 16),
                            TextInfo(
                                    title: LocaleKeys
                                        .transaction_page_transaction_id_text
                                        .tr,
                                    subtitle:
                                        controller.paymentRequery!.bpgTxnId!)
                                .paddingOnly(bottom: 16),
                            TextInfo(
                                    title: LocaleKeys
                                        .detail_transactions_page_transaction_date
                                        .tr,
                                    subtitle: DateFormat('yyyy-MM-dd, hh:mm a')
                                        .format(DateTime.parse(controller
                                            .paymentRequery!.txnDate!)))
                                .paddingOnly(bottom: 16),
                            TextInfo(
                              title: LocaleKeys
                                  .transaction_page_payment_status_text.tr,
                              subtitle:
                                  controller.paymentRequery!.paymentModeStatus!,
                              subtitleColor: colorStatus(controller
                                  .paymentRequery!.paymentModeStatus!),
                            ).paddingOnly(bottom: 16),
                            TextInfo(
                              title: LocaleKeys.biller_biller_status.tr,
                              subtitle:
                                  controller.paymentRequery!.bizSysStatus!,
                              subtitleColor: colorStatus(
                                  controller.paymentRequery!.bizSysStatus!),
                            ).paddingOnly(bottom: 16),
                            TextInfo(
                                    title: LocaleKeys.messages_text.tr,
                                    subtitle: controller
                                        .paymentRequery!.bizSysStatusMsg!)
                                .paddingOnly(bottom: 16),
                            TextInfo(
                                    title: LocaleKeys.amount_text.tr,
                                    subtitle:
                                        'RM ${controller.paymentRequery!.bizSysAmount!.toStringAsFixed(2)}')
                                .paddingOnly(bottom: 16),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(
                                  "F-3-6, Blok F, Centrus, CBD Perdana 3, Jalan Perdana, 63000 Cyberjaya, Selangor, Malaysia",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                                const SizedBox(
                                  height: 4,
                                ),
                                Center(
                                  child: Text(
                                    'Phone No: +60102439419',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: MySeparator(),
                                ),
                                Center(
                                    child: Text(
                                        'RM ${(controller.paymentRequery!.bizSysAmount! + controller.paymentRequery!.bizSysFee!).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.red))),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: MySeparator(),
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),

                                Center(
                                  child: Text(
                                      controller.paymentRequery!.bizSysStatus!
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              fontSize: 20,
                                              color: colorStatus(controller
                                                  .paymentRequery!
                                                  .bizSysStatus!))),
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),

                                const SizedBox(
                                  height: 16,
                                ),

                                // GestureDetector(
                                //   onTap: () {
                                //     controller.generatePDF2();
                                //   },
                                //   child: Text('Generate PDF'),
                                // ),

                                // GestureDetector(
                                //     onTap: () {
                                //       controller.shareImage();
                                //     },
                                //     child: Container(
                                //         color: Colors.amber,
                                //         child: Text('test'))),
                                // Screenshot(
                                //   controller: controller.screenshotController,
                                //   child: Container(
                                //     color: Colors.amber,
                                //     height: 100,
                                //     child: Text(
                                //         "This text will be captured as image"),
                                //   ),
                                // ),

                                Center(
                                  child: Text(
                                      LocaleKeys
                                          .transaction_page_transaction_amount_text
                                          .tr
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // TextRow(
                                //     title: 'Destination',
                                //     subtitle: 'IDR 136,807.75'),
                                // const SizedBox(
                                //   height: 16,
                                // ),
                                TextRow(
                                    title: LocaleKeys
                                        .transaction_page_payment_amount_text
                                        .tr,
                                    subtitle:
                                        'RM ${controller.paymentRequery!.bizSysAmount!.toStringAsFixed(2)}'),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextRow(
                                    title:
                                        LocaleKeys.transaction_page_fee_text.tr,
                                    subtitle:
                                        'RM ${controller.paymentRequery!.bizSysFee!.toStringAsFixed(2)}'),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextRow(
                                    title: LocaleKeys
                                        .transaction_page_exchange_rate_text.tr,
                                    subtitle: double.parse(controller
                                            .paymentRequery!.exchangeRate!)
                                        .toStringAsFixed(4)),
                                const SizedBox(
                                  height: 16,
                                ),

                                controller.paymentRequery!.payoutAmount!.isEmpty
                                    ? const SizedBox()
                                    : TextRow(
                                            title: LocaleKeys
                                                .transaction_page_beneficiary_get_text
                                                .tr,
                                            subtitle:
                                                '${controller.paymentRequery!.payoutCurrency} ${double.parse(controller.paymentRequery!.payoutAmount!).toStringAsFixed(2)}')
                                        .paddingOnly(bottom: 16),

                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: Text(
                                      LocaleKeys
                                          .transaction_page_sender_detail_text
                                          .tr
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                  title:
                                      LocaleKeys.transaction_page_name_text.tr,
                                  subtitle: controller.paymentRequery!
                                      .memberDetails!.customerName!,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                  title: LocaleKeys
                                      .transaction_page_customer_id.tr,
                                  subtitle: controller.paymentRequery
                                          ?.memberDetails?.customerId ??
                                      '-',
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                  title: LocaleKeys
                                      .transaction_page_country_text.tr,
                                  subtitle: controller.paymentRequery!
                                      .memberDetails!.senderCountry!,
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_address_text.tr,
                                    subtitle:
                                        '${controller.paymentRequery!.memberDetails!.senderAddress!}, ${controller.paymentRequery!.memberDetails!.senderZipCode}, ${controller.paymentRequery!.memberDetails!.senderCity}, ${controller.paymentRequery!.memberDetails!.senderState!}, ${controller.paymentRequery!.memberDetails!.senderCountry}'
                                            .toUpperCase()),

                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_phone_no_text.tr,
                                    subtitle: controller.paymentRequery!
                                        .memberDetails!.customerContactNo!),

                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: Text(
                                      LocaleKeys
                                          .transaction_page_beneficiary_details_text
                                          .tr
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_name_text.tr,
                                    subtitle: controller
                                            .paymentRequery!
                                            .beneficiaryDetails!
                                            .beneficiaryName ??
                                        '-'),

                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_country_text.tr,
                                    subtitle: controller.paymentRequery!
                                            .beneficiaryDetails!.countryName ??
                                        '-'),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_address_text.tr,
                                    subtitle: controller.paymentRequery!
                                            .beneficiaryDetails!.address ??
                                        ''.toUpperCase()),

                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_phone_no_text.tr,
                                    subtitle: controller.paymentRequery!
                                            .beneficiaryDetails?.mobileNumber ??
                                        ''),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_bank_name_text.tr,
                                    subtitle: controller.paymentRequery!
                                            .beneficiaryDetails!.bankName ??
                                        ''),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_account_no_text.tr,
                                    subtitle: controller
                                            .paymentRequery!
                                            .beneficiaryDetails!
                                            .accountNumber ??
                                        ''),

                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: Text(
                                      LocaleKeys
                                          .transaction_page_transaction_info_text
                                          .tr
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_transaction_id_text
                                        .tr,
                                    subtitle:
                                        controller.paymentRequery!.bpgTxnId!),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_payment_status_text
                                        .tr,
                                    subtitleColor: colorStatus(controller
                                        .paymentRequery!.paymentModeStatus!
                                        .toUpperCase()),
                                    subtitle: controller
                                        .paymentRequery!.paymentModeStatus!),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_remittance_status_text
                                        .tr,
                                    subtitleColor: colorStatus(controller
                                        .paymentRequery!.bizSysStatus!
                                        .toUpperCase()),
                                    subtitle: controller
                                        .paymentRequery!.bizSysStatus!),

                                controller.paymentRequery!.bizSysStatusMsg!
                                        .isNotEmpty
                                    ? TextColumn(
                                            title: LocaleKeys
                                                .transaction_page_message_text
                                                .tr,
                                            subtitle: controller.paymentRequery!
                                                .bizSysStatusMsg!)
                                        .paddingOnly(top: 16)
                                    : const SizedBox(),

                                // TextRow(
                                //   title: 'Source of Funds',
                                //   subtitle:
                                //       controller.paymentRequery!.sourceOfFunds!,
                                // ),
                                // const SizedBox(
                                //   height: 16,
                                // ),
                                // TextRow(
                                //     title: 'Purpose',
                                //     subtitle:
                                //         controller.paymentRequery!.purpose!),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_payment_method_text
                                        .tr,
                                    subtitle: controller
                                        .paymentRequery!.paymentMode!),
                                const SizedBox(
                                  height: 16,
                                ),

                                TextColumn(
                                    title: LocaleKeys
                                        .transaction_page_date_time_text.tr,
                                    subtitle: DateFormat('yyyy-MM-dd, hh:mm a')
                                        .format(DateTime.parse(controller
                                            .paymentRequery!.txnDate!))),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  });

  final String title;
  final String subtitle;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(subtitle.toUpperCase(),
            style: TextStyle(
              color: subtitleColor ?? Colors.black,
            )),
      ],
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  });

  final String title;
  final String subtitle;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}

Color colorStatus(String status) {
  switch (status) {
    case "PENDING":
      return Colors.orange;

    case "FAILED":
      return Colors.red;

    case "SUCCESS":
      return Colors.green;

    case "IN PROCESS":
      return Colors.orange;

    default:
      return Colors.black;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 20;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
