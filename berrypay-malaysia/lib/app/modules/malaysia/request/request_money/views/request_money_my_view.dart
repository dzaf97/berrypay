import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/request_money_my_controller.dart';

class RequestMoneyMyView extends GetView<RequestMoneyMyController> {
  const RequestMoneyMyView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Request Money',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: BerryPayLoading())
              : BodyRequestMoney(
                  controller: controller,
                ),
        ));
  }
}

class BodyRequestMoney extends StatelessWidget {
  const BodyRequestMoney({super.key, required this.controller});

  final RequestMoneyMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Expanded(
                child: ListView(
                  children: controller.contactList
                      .map(
                        (element) => ListTile(
                          leading: const Icon(Icons.wallet),
                          title: Text(element.userProfile?.fullName ?? ""),
                          subtitle: Text(element.userProfile?.mobileNo ?? ""),
                          onTap: () =>
                              controller.selectWallet(element.userProfile!),
                        ),
                      )
                      .toList(),
                ),
              ))
        ],
      ),
    );
  }
}
