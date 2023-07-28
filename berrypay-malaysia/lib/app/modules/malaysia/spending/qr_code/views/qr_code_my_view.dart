import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/qr_code_my_controller.dart';

class QrCodeMyView extends GetView<QrCodeMyController> {
  const QrCodeMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(elevation: 0, title: const Text('Scan QR')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: BerryPayLoading())
          : QrCode(controller: controller)),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppButton.rectangle(
              onTap: () {
                Get.back();
              },
              title: 'Back to Scanner'),
        ),
      ),
    );
  }
}

class QrCode extends StatelessWidget {
  const QrCode({
    Key? key,
    this.controller,
  }) : super(key: key);
  final QrCodeMyController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            // height: 80,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Text(
                'Show code at cashier to pay',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              QrImage(
                data:
                    controller!.ssSpendingModelVO!.spendingDetail!.barcodeData!,
                size: 250.0,
                embeddedImage: AssetImage('assets/images/icon.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(80, 80),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const AutoSizeText(
                'Refresh every 60 seconds automatically',
              ),
              TweenAnimationBuilder<Duration>(
                  duration: const Duration(minutes: 1),
                  tween: Tween(
                      begin: const Duration(minutes: 1), end: Duration.zero),
                  onEnd: () {
                    logger('Timer ended');
                    controller!.qrCode();
                  },
                  builder:
                      (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text('$minutes:$seconds',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)));
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
