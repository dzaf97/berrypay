import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../controllers/payment_method_my_controller.dart';

class PaymentMethodMyView extends GetView<PaymentMethodMyController> {
  const PaymentMethodMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          LocaleKeys.remittance_payment_method.tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: Body(
        controller: controller,
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: SwipeableButtonView(
      //     buttonText: 'SLIDE TO PAYMENT',
      //     buttonWidget: const Icon(
      //       Icons.arrow_forward_ios_rounded,
      //       color: Colors.grey,
      //     ),
      //     activeColor: AppColor.primary,
      //     isFinished: controller.isFinished.value,
      //     onWaitingProcess: () {
      //       Future.delayed(Duration(seconds: 2), () {
      //         controller.isFinished.value = true;
      //       });
      //     },
      //     onFinish: () async {
      //       if (controller.payment.value == PaymentMethod.wallet) {
      //         logger('sini');
      //         // if (controller.userProfile!.wallet
      //         //     .where(
      //         //         (element) => element.bizSysId == "FASSPYMY")
      //         //     .isEmpty) {
      //         //   AppSnackbar.errorSnackbar(
      //         //       title: LocaleKeys.remittance_error_upgrade.tr);
      //         //   return;
      //         // }
      //         // controller.walletSubmit();
      //         AppSnackbar.comingSoonSnackbar(context: context);
      //       } else {
      //         logger('sini 2');
      //         if (controller.category == "Biller") {
      //           controller.payBiller();
      //           return;
      //         }
      //         controller.onlineBankingSubmit();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final PaymentMethodMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.remittance_payment_method.tr,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            LocaleKeys.remittance_choose_payment.tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.info,
          //       color: Colors.amber,
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       child: Text(
          //         LocaleKeys.disclaimer_payment.tr,
          //         style: Theme.of(context).textTheme.bodySmall,
          //       ),
          //     )
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Obx(() => controller.isloading.value
          //     ? const BerryPayLoading()
          //     : Expanded(
          //         child: ListView(
          //           children: ListTile.divideTiles(context: context, tiles: [
          //             GestureDetector(
          //               onTap: () {
          //                 // if (controller.userProfile!.wallet
          //                 //     .where(
          //                 //         (element) => element.bizSysId == "FASSPYMY")
          //                 //     .isEmpty) {
          //                 //   AppSnackbar.errorSnackbar(
          //                 //       title: LocaleKeys.remittance_error_upgrade.tr);
          //                 //   return;
          //                 // }
          //                 // controller.walletSubmit();
          //                 AppSnackbar.comingSoonSnackbar(context: context);
          //               },
          //               child: ListTile(
          //                 leading: Image.asset(
          //                   'assets/images/logo.png',
          //                   width: 25,
          //                 ),
          //                 title: Text(
          //                   LocaleKeys.remittance_berryPay_wallet.tr,
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .bodyLarge!
          //                       .copyWith(fontWeight: FontWeight.w400),
          //                 ),
          //                 trailing: const Icon(
          //                   Icons.arrow_forward_ios_outlined,
          //                   size: 15,
          //                 ),
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 if (controller.category == "Biller") {
          //                   controller.payBiller();
          //                   return;
          //                 }
          //                 controller.onlineBankingSubmit();
          //               },
          //               child: ListTile(
          //                 leading: Image.asset(
          //                   'assets/images/fpx.png',
          //                   width: 30,
          //                 ),
          //                 title: Text(
          //                   LocaleKeys.remittance_online_banking.tr,
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .bodyLarge!
          //                       .copyWith(fontWeight: FontWeight.w400),
          //                 ),
          //                 trailing: const Icon(
          //                   Icons.arrow_forward_ios_outlined,
          //                   size: 15,
          //                 ),
          //               ),
          //             ),
          //           ]).toList(),
          //         ),
          //       )),
          Obx(
            () => ListTile(
              tileColor: (controller.disableWallet.value)
                  ? Colors.grey.shade200
                  : null,
              title: Text(LocaleKeys.remittance_berryPay_wallet.tr),
              leading: Image.asset(
                'assets/images/logo.png',
                width: 25,
              ),
              trailing: Radio<PaymentMethod>(
                value: PaymentMethod.wallet,
                // fillColor:
                //     MaterialStateColor.resolveWith((states) => Colors.grey),
                groupValue: controller.payment.value,
                fillColor: (controller.disableWallet.value)
                    ? MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.black.withOpacity(.32);
                        }
                        return Colors.black;
                      })
                    : null,
                onChanged: (controller.disableWallet.value)
                    ? null
                    : (PaymentMethod? value) {
                        controller.payment.value = value!;
                      },
              ),
            ),
          ),
          // const Divider(),
          Obx(
            () => ListTile(
              title: Text(LocaleKeys.remittance_online_banking.tr),
              leading: Image.asset(
                'assets/images/fpx.png',
                width: 30,
              ),
              subtitle: controller.category == "Biller"
                  ? Text(
                      LocaleKeys.biller_processing_fee.tr,
                      style: const TextStyle(fontSize: 10),
                    )
                  : const SizedBox(),
              trailing: Radio<PaymentMethod>(
                value: PaymentMethod.fpx,
                groupValue: controller.payment.value,
                onChanged: (PaymentMethod? value) {
                  controller.payment.value = value!;
                },
              ),
            ),
          ),
          const Spacer(),
          Obx(
            () => Center(
              child: SwipeableButtonView(
                buttonText:
                    LocaleKeys.remittance_slide_payment.tr.toUpperCase(),
                buttonWidget: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                activeColor: AppColor.primary,
                isFinished: controller.isloading.value,
                onWaitingProcess: () {
                  Future.delayed(const Duration(seconds: 2), () {
                    controller.isloading.value = true;
                  });
                },
                onFinish: () {
                  if (controller.payment.value == PaymentMethod.wallet) {
                    logger('sini');

                    if (controller.category == "Biller") {
                      // Get.back();
                      controller.payBillerWalet();
                      // AppSnackbar.comingSoonSnackbar(context: context);
                      return;
                    }
                    if (controller.userProfile!.wallet
                        .where((element) => element.bizSysId == "FASSPYMY")
                        .isEmpty) {
                      logger('object');
                      // Get.back();
                      // AppSnackbar.errorSnackbar(
                      //     title: LocaleKeys.remittance_error_upgrade.tr);

                      controller.payBillerWalet();

                      return;
                    }

                    controller.walletSubmit();

                    // Get.back();
                    // AppSnackbar.comingSoonSnackbar(context: context);
                  } else {
                    logger('sini 2');
                    if (controller.category == "Biller") {
                      controller.payBiller();
                      return;
                    }
                    controller.onlineBankingSubmit();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
