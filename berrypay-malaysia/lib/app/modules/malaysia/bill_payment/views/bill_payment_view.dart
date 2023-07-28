import 'package:berrypay_global_x/app/modules/malaysia/layout/views/home_my_view.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bill_payment_controller.dart';

class BillPaymentView extends GetView<BillPaymentController> {
  const BillPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          LocaleKeys.biller_bill_payment.tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: ListView(children: [TopupBody(), BillBody()]),
    );
  }
}

class TopupBody extends StatelessWidget {
  const TopupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Topup',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            // mainAxisSpacing: 30.0,
            // childAspectRatio: 1,
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuBox(
                title: 'Prepaid',
                icon: "assets/icons/topup.png",
                onTap: () {
                  Get.toNamed(Routes.PREPAID_TOPUP, arguments: {
                    'route': Routes.PREPAID_TOPUP_FORM,
                    'page': 'prepaid'
                  });
                },
              ),
              // MenuBox(
              //   title: 'Data Package',
              //   icon: "assets/icons/broadcast-tower-flat.png",
              //   onTap: () {},
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class BillBody extends StatelessWidget {
  const BillBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bills',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            // mainAxisSpacing: 30.0,
            // childAspectRatio: 1,
            shrinkWrap: true,
            children: [
              MenuBox(
                title: 'Postpaid',
                icon: "assets/icons/mobile.png",
                onTap: () {
                  Get.toNamed(Routes.PREPAID_TOPUP, arguments: {
                    'route': Routes.POSTPAID_TOPUP,
                    'page': 'postpaid'
                  });
                },
              ),
              // MenuBox(
              //   title: 'Electricity',
              //   icon: "assets/icons/bulb-flat.png",
              //   onTap: () {},
              // ),
              // MenuBox(
              //   title: 'Water',
              //   icon: "assets/icons/water-drop-flat.png",
              //   onTap: () {},
              // ),
              // MenuBox(
              //   title: 'Internet',
              //   icon: "assets/icons/wifi-connection-flat.png",
              //   onTap: () {},
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
