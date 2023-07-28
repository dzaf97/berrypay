import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:berrypay_global_x/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/layout_my_controller.dart';

class LayoutMyView extends GetView<LayoutMyController> {
  const LayoutMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async => true,
      // onWillPop: _onWillPop,
      onWillPop: () async {

        Get.dialog(
          CupertinoAlertDialog(
            title: Text(
              LocaleKeys.sign_out.tr,
              textAlign: TextAlign.center,
            ),
            content: Text(
              LocaleKeys.sign_out_desc.tr,
              textAlign: TextAlign.center,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                isDefaultAction: true,
                child: Text(
                  LocaleKeys.close_text.tr,
                  style: TextStyle(color: AppColor.secondary),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  controller.signOut();
                },
                child: Text(LocaleKeys.sign_out.tr),
              ),
            ],
          ),
          barrierDismissible: false,
        );

        return false;
      },
      child: DefaultTabController(
        length: controller.pages.length,
        child: Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Obx(
              () => controller.selectedTab.value == 0
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 32.0,
                          ),
                          Text(isStaging ? ' - Staging' : '', style: const TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        '${controller.titles[controller.selectedTab.value]}${isStaging ? ' - Staging' : ''}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ),
          body: Obx(() => controller.pages[controller.selectedTab.value]),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: SafeArea(
              child: TabBar(
                onTap: controller.handleMyTab,
                controller: controller.tabController,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.red, width: 3.0),
                  insets: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 45.0),
                ),
                labelColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: controller.tabs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
