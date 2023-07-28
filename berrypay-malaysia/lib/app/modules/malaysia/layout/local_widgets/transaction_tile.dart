import 'package:berrypay_global_x/app/core/utils/helpers/date.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_receipt_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/views/transaction_receipt_my_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final SSTransactionVO transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => const TransactionReceiptMyView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<TransactionReceiptMyController>(
                  () => TransactionReceiptMyController());
            }),
            arguments: {"transaction": transaction, "page": 1},
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.transactionType
                          .toString()
                          .split(".")
                          .last
                          .split(RegExp(r"(?=(?!^)[A-Z])"))
                          .reduce(
                            (value, element) => "$value $element",
                          ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      dateTimeFormat.format(DateTime.fromMillisecondsSinceEpoch(
                          int.parse(transaction.transactionDateTime!))),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("RM ${amount(transaction)}",
                        style: const TextStyle(fontSize: 16)),
                    Text(
                        transaction.transactionStatus
                            .toString()
                            .split(".")
                            .last
                            .split(RegExp(r"(?=(?!^)[A-Z])"))
                            .reduce(
                              (value, element) => "$value $element",
                            ),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String amount(SSTransactionVO transaction) {
    switch (transaction.transactionType) {
      case TransactionType.Spending:
        return (num.parse(transaction.spendingDetail?.amountAuthorized ?? "0") /
                100)
            .toStringAsFixed(2);
      case TransactionType.Withdrawal:
        return (num.parse(
                    transaction.withdrawalDetail?.amountAuthorized ?? "0") /
                100)
            .toStringAsFixed(2);
      case TransactionType.WithdrawalCharges:
        return (num.parse(
                    transaction.withdrawalDetail?.amountAuthorized ?? "0") /
                100)
            .toStringAsFixed(2);
      case TransactionType.FundTransfer:
        return (num.parse(transaction.p2pDetail?.amountAuthorized ?? "0") / 100)
            .toStringAsFixed(2);
      case TransactionType.TopUp:
        return (num.parse(transaction.topUpDetail?.amountAuthorized ?? "0") /
                100)
            .toStringAsFixed(2);
      default:
        return "";
    }
  }
}
