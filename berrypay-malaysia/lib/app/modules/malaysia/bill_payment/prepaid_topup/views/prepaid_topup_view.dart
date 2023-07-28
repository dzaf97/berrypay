import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prepaid_topup_controller.dart';

class PrepaidTopupView extends GetView<PrepaidTopupController> {
  const PrepaidTopupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          controller.page == 'prepaid'
              ? LocaleKeys.biller_prepaid.tr
              : LocaleKeys.biller_postpaid.tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const BerryPayLoading()
            : SingleChildScrollView(
                child: controller.page == 'prepaid'
                    ? Body(
                        controller: controller,
                      )
                    : PrepaidBody(
                        controller: controller,
                      )),
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //         padding: const EdgeInsets.all(8),
      //         width: double.infinity,
      //         color: Colors.grey.shade200,
      //         child: const Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text('Notes'),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               children: [
      //                 Text(
      //                   '•',
      //                   style: TextStyle(fontSize: 20),
      //                 ),
      //                 SizedBox(
      //                   width: 10,
      //                 ),
      //                 Expanded(
      //                   child: Text(
      //                       'Select direct topup to reload directly to your phone number'),
      //                 )
      //               ],
      //             ),
      //             SizedBox(
      //               height: 15,
      //             ),
      //             Row(
      //               children: [
      //                 Text(
      //                   '•',
      //                   style: TextStyle(fontSize: 20),
      //                 ),
      //                 SizedBox(
      //                   width: 10,
      //                 ),
      //                 Expanded(
      //                   child: Text(
      //                       'Select Reload Pin Topup to purchase a reload PIN and reload anytime to your phone number by yourself.'),
      //                 )
      //               ],
      //             )
      //           ],
      //         )),
      //   ],
      // ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final PrepaidTopupController controller;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getPrepaidList(),
      child: Column(
        children: [
          controller.dataPrepaid!.isEmpty
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(16),
                      child: Text(LocaleKeys.biller_error.tr),
                    ),
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.dataPrepaid!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(controller.routes!, arguments: {
                          'dataPrepaid': controller.dataPrepaid?[index]
                        });
                      },
                      child: ListTile(
                        // leading: Icon(Icons.wifi)
                        title:
                            Text('${controller.dataPrepaid![index].product}'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
        ],
      ),
    );
  }
}

class PrepaidBody extends StatelessWidget {
  const PrepaidBody({super.key, required this.controller});

  final PrepaidTopupController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getPostpaidList(),
      child: Column(
        children: [
          controller.dataPostpaid.isEmpty
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(16),
                        child: Text(LocaleKeys.biller_error.tr)),
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.dataPostpaid.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(controller.routes!, arguments: {
                          'dataPostpaid': controller.dataPostpaid[index]
                        });
                      },
                      child: ListTile(
                        // leading: Icon(Icons.wifi)
                        title:
                            Text('${controller.dataPostpaid[index].product}'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
        ],
      ),
    );
  }
}
