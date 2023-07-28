import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dotted_seperator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_receipt_my_controller.dart';

class RequestReceiptMyView extends GetView<RequestReceiptMyController> {
  const RequestReceiptMyView({Key? key}) : super(key: key);
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
          backgroundColor: Colors.red[800],
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: ReceiptBody(
          controller: controller,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppButton.rounded(
              border: Colors.red, onTap: controller.proceed, title: 'Done'),
        ),
      ),
    );
  }
}

class ReceiptBody extends StatelessWidget {
  const ReceiptBody({super.key, this.controller});
  final RequestReceiptMyController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                          child: Text(
                              'RM ${(int.parse(controller!.walletTransferModelVO!.p2pList![0].amount!) / 100).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.red))),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: MySeparator(),
                      ),
                      Center(
                        child: Text(
                          'Request successful',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextRow(
                          title: 'Name',
                          subtitle: controller!.walletTransferModelVO!
                              .p2pList![0].userProfile!.fullName!),
                      const SizedBox(
                        height: 15,
                      ),
                      TextRow(
                          title: 'Contact',
                          subtitle: controller!.walletTransferModelVO!
                              .p2pList![0].userProfile!.mobileNo!),
                      const SizedBox(
                        height: 15,
                      ),
                      TextRow(
                          title: 'Amount',
                          subtitle:
                              'RM ${(num.parse(controller!.walletTransferModelVO!.p2pList![0].amount!) / 100).toStringAsFixed(2)}'),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const CircleAvatar(radius: 30, child: Icon(Icons.check, size: 40)),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     Text(
      //       'Request successful',
      //       style: Theme.of(context).textTheme.headline6,
      //     ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     TextRow(
      //         title: 'Name',
      //         subtitle: controller!
      //             .walletTransferModelVO!.p2pList![0].userProfile!.fullName!),
      //     const SizedBox(
      //       height: 15,
      //     ),
      //     TextRow(
      //         title: 'Contact',
      //         subtitle: controller!
      //             .walletTransferModelVO!.p2pList![0].userProfile!.mobileNo!),
      //     const SizedBox(
      //       height: 15,
      //     ),
      //     TextRow(
      //         title: 'Amount',
      //         subtitle:
      //             'RM ${controller!.walletTransferModelVO!.p2pList![0].amount!}'),
      //     const SizedBox(
      //       height: 15,
      //     ),
      //   ],
      // ),
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({super.key, required this.subtitle, required this.title});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Expanded(
          child: Text(
            subtitle,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
