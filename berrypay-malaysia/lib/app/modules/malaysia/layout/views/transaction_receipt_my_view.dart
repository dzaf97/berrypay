import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/dotted_seperator.dart';
import 'package:berrypay_global_x/app/global_widgets/text_info.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_receipt_my_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TransactionReceiptMyView extends GetView<TransactionReceiptMyController> {
  const TransactionReceiptMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                              child: Obx(
                                () => Text(
                                  controller.amount.value,
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.red),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: MySeparator(),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.textInfoModelList.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextInfo(
                                            title: controller
                                                .textInfoModelList[i].title,
                                            subtitle: controller
                                                .textInfoModelList[i].subtitle),
                                        const SizedBox(height: 16),
                                      ]);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // extendBody: true,
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: AppButton.rounded(
              title: 'Done',
              border: Colors.red,
              onTap: controller.proceed,
            ),
          ),
        ),
      ),
    );
  }
}
