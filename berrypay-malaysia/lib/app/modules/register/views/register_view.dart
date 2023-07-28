import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BpgMyProvider());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              // SizedBox(height: Platform.isAndroid ? 30 : 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Hero(
                    tag: "logo",
                    child: Image.asset("assets/images/logo.png", width: 50)),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Row(
                        children: [
                          Bullet(status: "active"),
                          SizedBox(width: 5),
                          Bullet(status: ""),
                          SizedBox(width: 5),
                          Bullet(status: ""),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        LocaleKeys.select_country_acc_welcome_text.tr,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        LocaleKeys
                            .forgot_phone_page_enter_mobile_number_text.tr,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 30),
                      PhoneField(
                        controller: controller,
                        selectedCode: controller.code,
                      ),
                      const SizedBox(height: 30),

                      ///Message
                      // Center(
                      //     child: Text("$message",
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(color: Colors.red))),
                      // SizedBox(height: 30),
                      //Submit Button

                      Obx(
                        () => controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : Center(
                                child: AppButton.roundedIcon(
                                    width: 180.0,
                                    height: 48.0,
                                    icon: Icons.arrow_forward,
                                    title: LocaleKeys.verify_text.tr,
                                    onTap: () => controller.verify()),
                              ),
                      )
                    ]),
              )
            ])),
      ),
    );
  }
}

class Bullet extends StatelessWidget {
  const Bullet({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: status == "active" ? 12 : 6,
      height: 6,
      decoration: BoxDecoration(
          color: status == "active" ? Colors.black38 : Colors.black12,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField(
      {super.key, required this.controller, required this.selectedCode});

  final RegisterController controller;
  final RxString selectedCode;

  final List<DropdownMenuItem> countryCodes = const [
    DropdownMenuItem<String>(
      value: "+60",
      child: Text("+60"),
    ),
    DropdownMenuItem<String>(
      value: "+971",
      child: Text("+971"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      // margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.register_page_phone_number_text.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '*',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.red),
                textAlign: TextAlign.start,
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.phone_android,
                color: Colors.black87,
                size: 20,
              ),
              const SizedBox(width: 16),
              Text(
                '+60',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodySmall,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.phoneNoCtrl,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'xxxxxxxxx',
                      border: InputBorder.none,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
