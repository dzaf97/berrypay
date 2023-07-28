import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/views/home_my_view.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/request_my_controller.dart';

class RequestMyView extends GetView<RequestMyController> {
  const RequestMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          LocaleKeys.request_request.tr,
          style: const TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyRequest(),
          RequestHistory(
            controller: controller,
          )
        ],
      )),
    );
  }
}

class BodyRequest extends StatelessWidget {
  const BodyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          MenuBox(
            icon: "assets/icons/refund-flat.png",
            title: "Request Money",
            onTap: () {
              Get.toNamed(Routes.REQUEST_MONEY_MY);
            },
          ),
          const SizedBox(
            width: 20,
          ),
          MenuBox(
            icon: "assets/icons/bill (1).png",
            title: "Split",
            onTap: () {
              Get.defaultDialog(
                title: "Oopps",
                content: Column(
                  children: [
                    Lottie.asset('assets/lottie/coming-soon.json',
                        animate: true,
                        repeat: true,
                        reverse: true,
                        fit: BoxFit.fill,
                        // height: 150,
                        width: 150),
                    const SizedBox(height: 10),
                    Text(
                      "Coming Soon!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "We'll let you know when new features are available!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onConfirm: () {
                  Get.back();
                },
                confirmTextColor: Colors.white,
                textConfirm: "Okay",
              );
            },
          ),
        ],
      ),
    );
  }
}

class RequestHistory extends StatelessWidget {
  const RequestHistory({super.key, required this.controller});

  final RequestMyController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(heightFactor: 5, child: BerryPayLoading())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Text(
                    'Request History',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                controller.ssWalletTransferModelVO?.p2pList?.isEmpty ??
                        [].isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No requested money history'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.ssWalletTransferModelVO!.p2pList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var millis = controller
                              .ssWalletTransferModelVO!
                              .p2pList![index]
                              .transferRequestDetail!
                              .transferRequestDateTime;
                          var dt = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(millis!),
                            // isUtc: true
                          );

                          var date =
                              DateFormat('dd MMM yyyy, hh:mm a').format(dt);
                          return GestureDetector(
                            onTap: () => GetPlatform.isAndroid
                                ? actionPayRequest(
                                    controller
                                        .ssWalletTransferModelVO!
                                        .p2pList![index]
                                        .transferRequestDetail!
                                        .transferRequestStatus!,
                                    controller
                                        .ssWalletTransferModelVO!
                                        .p2pList![index]
                                        .transferRequestDetail!
                                        .transferRequestType!,
                                    index,
                                  )
                                : actionPayRequest(
                                    controller
                                        .ssWalletTransferModelVO!
                                        .p2pList![index]
                                        .transferRequestDetail!
                                        .transferRequestStatusId!,
                                    controller
                                        .ssWalletTransferModelVO!
                                        .p2pList![index]
                                        .transferRequestDetail!
                                        .transferRequestTypeId!,
                                    index,
                                  ),
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFE0E0E0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(-20, -20),
                                    blurRadius: 60,
                                    color: Colors.white,
                                  ),
                                  BoxShadow(
                                    offset: Offset(20, 20),
                                    blurRadius: 60,
                                    color: Color(0xFFBEBEBE),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 12),
                                          backgroundColor: GetPlatform.isAndroid
                                              ? requestStatusColor(
                                                  controller
                                                      .ssWalletTransferModelVO!
                                                      .p2pList![index]
                                                      .transferRequestDetail!
                                                      .transferRequestStatus!,
                                                )
                                              : requestStatusColor(
                                                  controller
                                                      .ssWalletTransferModelVO!
                                                      .p2pList![index]
                                                      .transferRequestDetail!
                                                      .transferRequestStatusId!,
                                                ),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        ),
                                        onPressed: null,
                                        child: Text(
                                          GetPlatform.isAndroid
                                              ? requestStatus(
                                                  controller
                                                      .ssWalletTransferModelVO!
                                                      .p2pList![index]
                                                      .transferRequestDetail!
                                                      .transferRequestStatus!,
                                                )
                                              : requestStatus(
                                                  controller
                                                      .ssWalletTransferModelVO!
                                                      .p2pList![index]
                                                      .transferRequestDetail!
                                                      .transferRequestStatusId!,
                                                ),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      GetPlatform.isAndroid
                                          ? resent(
                                              controller
                                                  .ssWalletTransferModelVO!
                                                  .p2pList![index]
                                                  .transferRequestDetail!
                                                  .transferRequestStatus!,
                                              controller
                                                  .ssWalletTransferModelVO!
                                                  .p2pList![index]
                                                  .transferRequestDetail!
                                                  .transferRequestType!,
                                              index,
                                            )
                                          : resent(
                                              controller
                                                  .ssWalletTransferModelVO!
                                                  .p2pList![index]
                                                  .transferRequestDetail!
                                                  .transferRequestStatusId!,
                                              controller
                                                  .ssWalletTransferModelVO!
                                                  .p2pList![index]
                                                  .transferRequestDetail!
                                                  .transferRequestTypeId!,
                                              index)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),

                                  Text(GetPlatform.isAndroid
                                      ? requestTitle(
                                          controller
                                              .ssWalletTransferModelVO!
                                              .p2pList![index]
                                              .transferRequestDetail!
                                              .transferRequestType!,
                                          controller
                                              .ssWalletTransferModelVO!
                                              .p2pList![index]
                                              .userProfile!
                                              .fullName!,
                                          (num.parse(controller
                                                      .ssWalletTransferModelVO!
                                                      .p2pList![index]
                                                      .amount!) /
                                                  100)
                                              .toStringAsFixed(2))
                                      : requestTitle(
                                          controller
                                              .ssWalletTransferModelVO!
                                              .p2pList![index]
                                              .transferRequestDetail!
                                              .transferRequestTypeId!,
                                          controller
                                              .ssWalletTransferModelVO!
                                              .p2pList![index]
                                              .userProfile!
                                              .fullName!,
                                          (num.parse(controller
                                                      .ssWalletTransferModelVO!
                                                      .p2pList![index]
                                                      .amount!) /
                                                  100)
                                              .toStringAsFixed(2))),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Created at $date',
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                  // Text('Dzaf rejected RM10 requested from you '),
                                ],
                              ),
                            ),
                          );
                        },
                      )
              ],
            ),
    );
  }

  actionPayRequest(TransferRequestStatus transferRequestStatus,
      TransferRequestType transferRequestType, int index) {
    if (transferRequestStatus == TransferRequestStatus.Pending &&
        transferRequestType == TransferRequestType.TransferRequestTypePayer) {
      controller
          .requestAction(controller.ssWalletTransferModelVO!.p2pList![index]);
    }
  }

  String requestStatus(TransferRequestStatus status) {
    switch (status) {
      case TransferRequestStatus.Pending:
        return "Pending";
      case TransferRequestStatus.Approve:
        return "Approve";
      case TransferRequestStatus.Decline:
        return "Decline";
      case TransferRequestStatus.Void:
        return "Void";
    }
  }

  Color requestStatusColor(TransferRequestStatus status) {
    switch (status) {
      case TransferRequestStatus.Pending:
        return Colors.yellow;
      case TransferRequestStatus.Approve:
        return Colors.green;
      case TransferRequestStatus.Decline:
        return Colors.red;
      case TransferRequestStatus.Void:
        return Colors.grey;
    }
  }

  String requestTitle(TransferRequestType type, String name, String amount) {
    switch (type) {
      case TransferRequestType.TransferRequestTypePayee:
        return "You requested RM$amount from $name";
      case TransferRequestType.TransferRequestTypePayer:
        return "$name requested RM$amount from you";

      case TransferRequestType.TransferRequestTypeSplitBill:
        return "Approve";
      case TransferRequestType.TransferRequestTypeUnknown:
        return "Approve";
    }
  }

  Widget resent(
      TransferRequestStatus status, TransferRequestType type, int index) {
    if (status == TransferRequestStatus.Decline &&
        type == TransferRequestType.TransferRequestTypePayee) {
      return TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 12),
            backgroundColor: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onPressed: () {
            controller.resendRequest(
                controller.ssWalletTransferModelVO!.p2pList![index]);
          },
          child: const Text('Resend request',
              style: TextStyle(color: Colors.black)));
    } else {
      return Container();
    }
  }
}
