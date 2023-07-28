import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/shimmer_loading_balance_box.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/exchange_rate_my_controller.dart';

class ExchangeRateMyView extends GetView<ExchangeRateMyController> {
  const ExchangeRateMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topRight,
            end: const Alignment(5.0, 1.0), //Alignment.bottomRight,
            colors: [Colors.red[800]!, Colors.blue[800]!])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.red[800],
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(LocaleKeys.remittance_exchange_rate.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
          ),
          body: Body(
            controller: controller,
          ),
          // bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ExchangeRateMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(
        () => controller.isForExLoading.value
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TransactionShimmerBox(),
                  );
                })
            : controller.exchangeRateResponse == null ||
                    controller.dataExchange.isEmpty
                ? Text(
                    LocaleKeys.remittance_no_exchange_rate.tr,
                    style: const TextStyle(color: AppColor.white),
                  )
                : ListView.builder(
                    itemCount: controller.dataExchange.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () =>
                            Get.toNamed(Routes.REMITTANCE_MY, arguments: {
                          'rate': controller.dataExchange[index].ExchangeRate,
                          'currency':
                              controller.dataExchange[index].ReceiverCurrency,

                          // 'country': controller.getFlagImage(controller
                          //     .dataExchange[index].ReceiveCountry!
                          //     .toLowerCase()),

                          'receiverCountry':
                              controller.dataExchange[index].ReceiveCountry,

                          'country': controller.dataExchange[index].flags?.png
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x04000000),
                                    blurRadius: 10,
                                    spreadRadius: 10,
                                    offset: Offset(0.0, 8.0))
                              ],
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  // Space: 12 width
                                  const SizedBox(
                                    width: 12,
                                  ),

                                  // Circle Icon
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade200,
                                    child: Text(controller
                                        .dataExchange[index].flag!
                                        .toLowerCase()),
                                  ),

                                  // Space 12 width
                                  const SizedBox(width: 12),

                                  // Text Area
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Title
                                      // Text(
                                      //   '${controller.foreignExchanges[index]} ${controller.exchangeRateResponse?.data.[index].value.toStringAsFixed(4)}',
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: const TextStyle(fontSize: 18),
                                      // ),

                                      Text(
                                          '${controller.dataExchange[index].ReceiverCurrency!} ${double.parse(controller.dataExchange[index].ExchangeRate!).toStringAsFixed(4)}'),

                                      // Subtitle
                                      const Text('RM 1.00',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),

                              // Trailing
                              Row(
                                children: const <Widget>[
                                  // Trailing Text

                                  // Space 16 width at the trailing
                                  SizedBox(width: 16)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
