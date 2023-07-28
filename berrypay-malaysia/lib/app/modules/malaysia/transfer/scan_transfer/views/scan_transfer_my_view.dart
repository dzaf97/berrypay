import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/scan_transfer_my_controller.dart';

class ScanTransferMyView extends GetView<ScanTransferMyController> {
  const ScanTransferMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        elevation: 0,

        title: Text('Scan'),
        // backgroundColor: AppColor.white,
        foregroundColor: AppColor.white,
      ),
      body: ScanBarcodePage(controller: controller),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            color: AppColor.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppButton.rectangle(
              onTap: () {
                Get.back();
              },
              title: 'Show QR Code'),
        ),
      ),
    );
  }
}

class ScanBarcodePage extends StatelessWidget {
  const ScanBarcodePage({super.key, this.controller});
  final ScanTransferMyController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          fit: BoxFit.cover,
          allowDuplicates: false,
          controller: controller!.cameraController,
          onDetect: controller!.onDetect,
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
