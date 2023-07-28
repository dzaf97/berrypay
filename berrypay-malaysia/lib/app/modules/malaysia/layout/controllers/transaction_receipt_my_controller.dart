import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/layout_my_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionReceiptMyController extends GetxController {
  List<TextInfoModel> textInfoModelList = [];

  late SSTransactionVO transaction;
  RxString amount = RxString('RM -');

  @override
  void onInit() {
    logger(Get.arguments, name: "TransactionReceipt");
    transaction = Get.arguments["transaction"];

    logger(jsonEncode(transaction));

    textInfoModelList.addAll([
      TextInfoModel(
        'Transaction Status',
        transaction.transactionStatus
            .toString()
            .split(".")
            .last
            .split(RegExp(r"(?=(?!^)[A-Z])"))
            .reduce(
              (value, element) => "$value $element",
            ),
      ),
      TextInfoModel(
        'Transaction Type',
        transaction.transactionType
            .toString()
            .split(".")
            .last
            .split(RegExp(r"(?=(?!^)[A-Z])"))
            .reduce(
              (value, element) => "$value $element",
            ),
      ),
      TextInfoModel(
        'Transaction Id',
        transaction.transactionId.toString(),
      ),
      TextInfoModel(
        'Transaction Date',
        DateFormat('yyyy-MM-dd, hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(transaction.transactionDateTime!))),
      ),
    ]);

    switch (transaction.transactionType) {
      case TransactionType.Spending:
        amount.value =
            "RM ${(double.parse(transaction.spendingDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}";
        textInfoModelList.addAll([
          TextInfoModel(
            'Channel Type',
            transaction.spendingDetail!.channelType
                .toString()
                .split(".")
                .last
                .split(RegExp(r"(?=(?!^)[A-Z])"))
                .reduce(
                  (value, element) => "$value $element",
                ),
          ),
          TextInfoModel(
            'Amount',
            "RM ${(double.parse(transaction.spendingDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}",
          ),
          TextInfoModel(
              "Merchant Name", transaction.spendingDetail?.merchantName ?? "-"),
          TextInfoModel(
              "Approval Code", transaction.spendingDetail?.approvalCode ?? "-")
        ]);
        break;

      case TransactionType.FundTransfer:
        logger(transaction.toJson());
        amount.value =
            "RM ${(double.parse(transaction.p2pDetail?.amountAuthorized ?? "0.00") / 100).toStringAsFixed(2)}";

        if (transaction.p2pDetail != null) {
          textInfoModelList.addAll([
            TextInfoModel(
              'Channel Type',
              transaction.p2pDetail!.channelType
                  .toString()
                  .split(".")
                  .last
                  .split(RegExp(r"(?=(?!^)[A-Z])"))
                  .reduce(
                    (value, element) =>
                        "$value ${(element == "P2p") ? "P2P" : element}",
                  ),
            ),
            TextInfoModel(
              'Receiver Name',
              transaction.p2pDetail!.userProfile!.fullName ?? "",
            ),
            TextInfoModel(
              'Receiver Mobile No',
              transaction.p2pDetail!.userProfile!.mobileNo ?? "",
            ),
            TextInfoModel(
              'Amount',
              "RM ${(double.parse(transaction.p2pDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}",
            ),
          ]);
        } else {
          textInfoModelList.addAll([
            TextInfoModel(
              'Channel Type',
              transaction.transferDetail!.channelType
                  .toString()
                  .split(".")
                  .last
                  .split(RegExp(r"(?=(?!^)[A-Z])"))
                  .reduce(
                    (value, element) =>
                        "$value ${(element == "P2p") ? "P2P" : element}",
                  ),
            ),
            // TextInfoModel(
            //   'Receiver Name',
            //   transaction.transferDetail!.userProfile!.fullName ?? "",
            // ),
            // TextInfoModel(
            //   'Receiver Mobile No',
            //   transaction.transferDetail!.userProfile!.mobileNo ?? "",
            // ),
            TextInfoModel(
              'Amount',
              "RM ${(double.parse(transaction.transferDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}",
            ),
          ]);
        }

        break;

      case TransactionType.Withdrawal:
        // transaction.withdrawalDetail!.toJson().forEach((key, value) {
        //   if (value != null) {
        //     textInfoModelList.add(
        //       TextInfoModel(
        //           key.split(".").last.split(RegExp(r"(?=(?!^)[A-Z])")).reduce(
        //                 (value, element) => "${value.capitalizeFirst} $element",
        //               ),
        //           value.runtimeType.toString()),
        //     );
        //   }
        // });
        amount.value =
            "RM ${(double.parse(transaction.withdrawalDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}";
        textInfoModelList.addAll([
          TextInfoModel(
            'Channel Type',
            transaction.withdrawalDetail!.channelType
                .toString()
                .split(".")
                .last
                .split(RegExp(r"(?=(?!^)[A-Z])"))
                .reduce(
                  (value, element) =>
                      "$value ${(element == "Casa") ? "CASA" : element}",
                ),
          ),
          TextInfoModel(
            'Amount',
            "RM ${(double.parse(transaction.withdrawalDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}",
          ),
          TextInfoModel(
            'Account Name',
            transaction.withdrawalDetail!.accountName!,
          ),
          TextInfoModel(
            'Account No',
            transaction.withdrawalDetail!.accountNo!,
          ),
          TextInfoModel(
            'Bank Name',
            transaction.withdrawalDetail!.bankName!,
          ),
        ]);
        break;
      case TransactionType.Unknown:
        // Not Available
        break;
      case TransactionType.TopUp:
        amount.value =
            "RM ${(double.parse(transaction.topUpDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}";
        textInfoModelList.addAll([
          TextInfoModel(
            'Channel Type',
            transaction.topUpDetail!.channelType
                .toString()
                .split(".")
                .last
                .split(RegExp(r"(?=(?!^)[A-Z])"))
                .reduce(
                  (value, element) =>
                      "$value ${(element == "P2p") ? "P2P" : element}",
                ),
          ),
          TextInfoModel(
            'Gateway Type',
            transaction.topUpDetail!.gatewayType.toString().split(".").last,
          ),
          TextInfoModel(
            'Amount',
            "RM ${(double.parse(transaction.topUpDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}",
          ),
        ]);
        break;
      case TransactionType.WithdrawalCharges:
        amount.value =
            "RM ${(double.parse(transaction.withdrawalDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}";
        textInfoModelList.addAll([
          TextInfoModel(
            'Channel Type',
            transaction.withdrawalDetail!.channelType
                .toString()
                .split(".")
                .last
                .split(RegExp(r"(?=(?!^)[A-Z])"))
                .reduce(
                  (value, element) =>
                      "$value ${(element == "Casa") ? "CASA" : element}",
                ),
          ),
          TextInfoModel(
            'Amount',
            "RM ${(double.parse(transaction.withdrawalDetail!.amountAuthorized!) / 100).toStringAsFixed(2)}",
          ),
        ]);
        break;
      case TransactionType.Cashback:
        // Not Available
        break;
      case TransactionType.Refund:
        // TODO: Handle this case.
        break;
      case TransactionType.AuthCapture:
        // Not Available
        break;

      default:
    }

    // textInfoModelList.addAll([
    //   TextInfoModel(
    //     'Transaction Type',
    //     transaction.transactionType
    //         .toString()
    //         .split(".")
    //         .last
    //         .split(RegExp(r"(?=(?!^)[A-Z])"))
    //         .reduce(
    //           (value, element) => "$value $element",
    //         ),
    //   ),
    //   TextInfoModel(
    //     "Channel Type",
    //     transaction.spendingDetail!.channelType
    //         .toString()
    //         .split(".")
    //         .last
    //         .split(RegExp(r"(?=(?!^)[A-Z])"))
    //         .reduce(
    //           (value, element) => "$value $element",
    //         ),
    //   )
    //   // TextInfoModel('Payment Details',
    //   //     'Withdraw to personal bank account (The Hongkong and Shanghai Banking Berhad - HSBC)'),
    //   // TextInfoModel('Payment Method', 'eWallet Balance'),
    //   // TextInfoModel('Date/Time', '16-11-2022 17:53:00'),
    //   // TextInfoModel('Transaction No.', 'WITH913N414014K3134H1293'),
    //   // TextInfoModel('Wallet Ref. No', '9021J8F012KEH1'),
    //   // TextInfoModel('Status', 'Successful'),
    //   // TextInfoModel('Notes', 'Withdraw'),
    // ]);
    super.onInit();
  }

  dynamic proceed() {
    // Get page from previous class
    int? page = Get.arguments["page"];

    // Set the selectedTab value to page
    // This is to show the selected page
    Get.find<LayoutMyController>().selectedTab.value = page ?? 0;

    // Set the tabController value to page
    // This is to show the selected tab
    Get.find<LayoutMyController>().tabController.index = page ?? 0;

    // Go to layout with the configuration setup above
    // Get.offAndToNamed(Routes.LAYOUT_MY);
    Get.back();
  }
}

class TextInfoModel {
  final String title;
  final String subtitle;

  TextInfoModel(this.title, this.subtitle);
}
