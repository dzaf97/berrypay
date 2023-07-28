import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutMyView extends GetView<AboutMyController> {
  const AboutMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(LocaleKeys.profile_page_about_us_text.tr,
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  // height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                )),
            const SizedBox(height: 20),
            const Text("BerryPay Malaysia", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.about_page_notice_cust.tr,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(LocaleKeys.about_page_remittance_service.tr,
                          style: Theme.of(context).textTheme.labelMedium!),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        LocaleKeys.about_page_notice_desc.tr,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )),
            ),
            Text(
              'Our Values and Goals',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 18),
            ),
            const Text(
              'BerryPay is a fintech company offering digital financial solutions that espouse Financial Inclusion and caters to population sectors otherwise neglected by the banking industry (the unbanked, unserved, or underserved), with the flexibility to capture the general markets. This is achieved by bridging the unbanked users through a unique e-banking system of virtual bank accounts to other banked and non-banked recipients and vice-versa. This capability enables BerryPay to achieve a level of integration with the core banking system of our partner banks, resulting in cheaper customer acquisition costs. From another perspective, BerryPay fintech system becomes the enabling solution for conventional banks to embark on digitization with minimum capital. Our current business model focuses on identifying and serving the needs of underserved population of foreign workers in the Asia Pacific region.',
              textAlign: TextAlign.justify,
            ).paddingAll(16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/googleplays.png",
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.7,
            //   child: Image.asset("assets/images/Funds.jpg",
            //       width: double.infinity),
            // ),
            // Container(
            //   color: Colors.red,
            //   height: MediaQuery.of(context).size.height * 2.1,
            //   child: Center(
            //     child: Column(children: <Widget>[
            //       const SizedBox(height: 20),
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.45,
            //         width: MediaQuery.of(context).size.width * 0.85,
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage("assets/images/PayBills.jpg"),
            //             fit: BoxFit.cover,
            //           ),
            //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //         ),
            //       ),
            //       Text(LocaleKeys.about_page_pay_bills_text.tr,
            //           style:
            //               const TextStyle(fontSize: 16, color: Colors.white)),
            //       const SizedBox(height: 20),
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.45,
            //         width: MediaQuery.of(context).size.width * 0.85,
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage("assets/images/PayZakat.jpg"),
            //             fit: BoxFit.cover,
            //           ),
            //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //         ),
            //       ),
            //       Text(LocaleKeys.about_page_pay_zakat_text.tr,
            //           style:
            //               const TextStyle(fontSize: 16, color: Colors.white)),
            //       const SizedBox(height: 20),
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.45,
            //         width: MediaQuery.of(context).size.width * 0.85,
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage("assets/images/ReceiveMoney.jpg"),
            //             fit: BoxFit.cover,
            //           ),
            //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //         ),
            //       ),
            //       Text(LocaleKeys.about_page_receive_money_text.tr,
            //           style:
            //               const TextStyle(fontSize: 16, color: Colors.white)),
            //       const SizedBox(height: 20),
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.45,
            //         width: MediaQuery.of(context).size.width * 0.85,
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage("assets/images/CheckBalance.jpg"),
            //             fit: BoxFit.cover,
            //           ),
            //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //         ),
            //       ),
            //       Text(LocaleKeys.about_page_check_money_text.tr,
            //           style:
            //               const TextStyle(fontSize: 16, color: Colors.white)),
            //     ]),
            //   ),
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.8,
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/Virtual.jpg"),
            //       fit: BoxFit.cover,
            //     ),
            //     borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //   ),
            // ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              child: Center(
                child: Column(
                  children: <Widget>[
                    const Text("© BerryPay All Rights Reserved",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    const SizedBox(height: 30),
                    const Icon(Icons.home, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                        "F-3-6 Centrus CBD Perdana, 3, Jln Perdana, Cyberjaya, 63000 Cyberjaya, Selangor, Malaysia",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    const SizedBox(height: 30),
                    const Icon(Icons.email, color: Colors.white),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async => controller
                          .launchAboutUrl('mailto:servicedesk@berrypay.com'),
                      child: const Text("servicedesk@berrypay.com",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                    const SizedBox(height: 30),
                    const Icon(Icons.phone, color: Colors.white),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async =>
                          controller.launchAboutUrl('tel:+60386855179'),
                      child: const Text("(+603) 8685 5179",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                    const SizedBox(height: 30),
                    const Icon(Icons.sms, color: Colors.white),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () async => controller.launchAboutUrl(
                            'https://wa.me/message/4TQTS3EHJIFQM1'),
                        child: const Text("+60 11-1429 3611",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
