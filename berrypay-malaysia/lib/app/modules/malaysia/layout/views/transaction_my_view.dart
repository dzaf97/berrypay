import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/transaction/transaction_model.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/shimmer.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/local_widgets/transaction_tile.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
// import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class TransactionMyView extends GetView<TransactionMyController> {
  const TransactionMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          toolbarHeight: 1,
          foregroundColor: AppColor.white,
          bottom: TabBar(
            labelColor: AppColor.black,
            unselectedLabelColor: Colors.grey,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.red, width: 3)),
            controller: controller.tabController,
            onTap: (value) {
              controller.currentIndex.value = value;
              if (value == 1) {
                logger('masuk');
                controller.getFpxTransaction();
              } else if (value == 2) {
                logger('masuk value 2');
                controller.getFpxTransaction();
              }
            },
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AutoSizeText(
                  LocaleKeys.transaction_page_wallet_text.tr,
                  style: const TextStyle(
                    // color: Colors.black,
                    fontSize: 16.5,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: AutoSizeText(
                  'Remittance',
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 16.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AutoSizeText(
                  LocaleKeys.home_page_billers_text.tr,
                  style: const TextStyle(
                    // color: Colors.black,
                    fontSize: 16.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() => controller.currentIndex.value == 0
            ? controller.walletId == null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                          LocaleKeys.transaction_page_empty_record_text.tr),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => controller.pagingController.refresh(),
                    ),
                    child: PagedListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 0,
                      ),
                      pagingController: controller.pagingController,
                      shrinkWrap: true,
                      builderDelegate:
                          PagedChildBuilderDelegate<SSTransactionVO>(
                        itemBuilder: (context, item, index) => TransactionTile(
                          transaction: item,
                        ),
                        newPageErrorIndicatorBuilder: (context) => Container(),
                      ),
                    ),
                  )
            : controller.currentIndex.value == 1
                ? controller.isLoading.value
                    ? const BerryPayLoading()
                    : FPXTransaction(
                        controller: controller,
                      )
                : controller.currentIndex.value == 2
                    ? controller.isLoading.value
                        ? const BerryPayLoading()
                        : BillerTransaction(
                            controller: controller,
                          )
                    : Container())
        // body: Obx(
        //   () => controller.isLoading.value
        //       ? const BerryPayLoading()
        //       : FPXTransaction(
        //           controller: controller,
        //         ),
        // )

        // body: controller.walletId == null
        //     ? const Padding(
        //         padding: EdgeInsets.all(16.0),
        //         child: Text('No transaction'),
        //       )
        //     : PagedListView(
        //         pagingController: controller.pagingController,
        //         shrinkWrap: true,
        //         builderDelegate: PagedChildBuilderDelegate<SSTransactionVO>(
        //           itemBuilder: (context, item, index) => TransactionTile(
        //             transaction: item,
        //           ),
        //         ),
        //       ),
        );
  }
}

class TransactionLoading extends StatelessWidget {
  const TransactionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ShimmerSingle(
            height: 100,
            width: double.infinity,
          ),
        );
      },
    );
  }
}

class FPXTransaction extends StatelessWidget {
  const FPXTransaction({super.key, required this.controller});

  final TransactionMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: controller.remittanceList!.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(LocaleKeys.transaction_page_empty_record_text.tr),
            )
          : ListView.builder(
              itemCount: controller.remittanceList?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REMITTANCE_RECEIPT_MY, arguments: {
                      'id': controller.remittanceList![index].bpgTxnId
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 24.0),
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
                                controller.remittanceList![index].paymentType!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                // '${DateFormat("yyyy-MM-dd hh:mm").parse(controller.paymentRequery![index].txn_date!)}',
                                // DateFormat("yyyy-MM-dd hh:mm")
                                //     .parse(controller
                                //         .paymentRequery![index].txn_date!)
                                //     .toString()
                                //     .substring(0, 16),
                                DateFormat('yyyy-MM-dd hh:mm a').format(
                                    DateTime.parse(controller
                                        .remittanceList![index].txnDate!)),
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
                              Text(
                                  'RM ${controller.remittanceList![index].bizSysAmount!.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  controller
                                      .remittanceList![index].bizSysStatus!
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorStatus(controller
                                        .remittanceList![index].bizSysStatus!
                                        .toUpperCase()),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

class BillerTransaction extends StatelessWidget {
  const BillerTransaction({super.key, required this.controller});

  final TransactionMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: controller.billerList!.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(LocaleKeys.transaction_page_empty_record_text.tr),
            )
          : ListView.builder(
              itemCount: controller.billerList?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REMITTANCE_RECEIPT_MY, arguments: {
                      'id': controller.billerList![index].bpgTxnId
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 24.0),
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
                                controller.billerList![index].paymentType!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                // '${DateFormat("yyyy-MM-dd hh:mm").parse(controller.paymentRequery![index].txn_date!)}',
                                // DateFormat("yyyy-MM-dd hh:mm")
                                //     .parse(controller
                                //         .paymentRequery![index].txn_date!)
                                //     .toString()
                                //     .substring(0, 16),
                                DateFormat('yyyy-MM-dd hh:mm a').format(
                                    DateTime.parse(controller
                                        .billerList![index].txnDate!)),
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
                              Text(
                                  'RM ${controller.billerList![index].bizSysAmount!.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  controller.billerList![index].bizSysStatus!
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorStatus(controller
                                        .billerList![index].bizSysStatus!
                                        .toUpperCase()),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

Color colorStatus(String status) {
  switch (status) {
    case "PENDING":
      return Colors.orange;

    case "IN PROCESS":
      return Colors.orange;

    case "FAILED":
      return Colors.red;

    case "SUCCESS":
      return Colors.green;

    default:
      return Colors.black;
  }
}
