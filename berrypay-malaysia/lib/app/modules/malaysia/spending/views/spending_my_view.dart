import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/spending_my_controller.dart';

class SpendingMyView extends GetView<SpendingMyController> {
  const SpendingMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        title: const Text(
          'Pay',
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),

      // body: Obx(() => controller.pages[controller.selectedTab.value]),
      body: Body(
        controller: controller,
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(16),
      //   decoration: const BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //           topRight: Radius.circular(40), topLeft: Radius.circular(40)),
      //       color: AppColor.white),
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: AppButton.rectangle(
      //         onTap: () {
      //           controller.showQR();
      //         },
      //         title: 'Show QR Code'),
      //   ),
      // ),

      //     : const QrCode())),
      // bottomNavigationBar: Toggle(controller: controller),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SpendingMyController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          fit: BoxFit.cover,
          allowDuplicates: false,
          controller: controller.cameraController,
          onDetect: controller.onDetect,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.primary, width: 3)),
            height: 300,
            width: 300,
          ),
        ),
      ],
    );
  }
}

// class QrCode extends StatelessWidget {
//   const QrCode({
//     Key? key,
//   }) : super(key: key);

//   final int index = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Center(
//           child: Container(
//             height: 80,
//             width: MediaQuery.of(context).size.width * 0.8,
//             padding: const EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               color: AppColor.primary,
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//           ),
//         ),
//         Center(
//           child: Column(
//             children: [
//               QrImage(
//                 data: '0',
//                 size: 250.0,
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               AutoSizeText(
//                 'Refresh every 60 seconds automatically',
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

