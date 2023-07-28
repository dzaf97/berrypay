import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/modules/malaysia/transfer/views/barcode_view.dart';
import 'package:berrypay_global_x/app/modules/malaysia/transfer/views/transfer_contact_view.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transfer_my_controller.dart';

class TransferMyView extends GetView<TransferMyController> {
  const TransferMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          elevation: 0,
          title: Text(LocaleKeys.home_page_transfer.tr),
          // backgroundColor: AppColor.white,
          foregroundColor: AppColor.white,
          bottom: TabBar(
            unselectedLabelColor: AppColor.secondary.withOpacity(0.6),
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black, width: 3)),
            controller: controller.tabController,
            onTap: (value) {
              controller.currentIndex.value = value;
              if (value == 1) {
                controller.verifyP2p();
              }
            },
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  LocaleKeys.transfer_qr_code.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  LocaleKeys.transfer_contact.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => controller.currentIndex.value == 0
              ? controller.isLoading.value
                  ? const Center(child: BerryPayLoading())
                  : const BarcodeView()
              : controller.currentIndex.value == 1
                  ? controller.isLoading.value
                      ? const Center(child: BerryPayLoading())
                      : const TransferContactView()
                  : Container(),
        ),
        bottomNavigationBar: Obx(
          () => controller.currentIndex.value == 0
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton.rectangle(
                    onTap: () {
                      Get.toNamed(Routes.SCAN_TRANSFER_MY);
                    },
                    title: LocaleKeys.transfer_scan.tr,
                  ),
                )
              : const SizedBox(),
        ));
  }
}
