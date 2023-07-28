import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppSnackbar {
  static Future<void> errorSnackbar({
    required String title,
  }) async {
    Get.snackbar(
      icon: const Icon(
        Icons.error,
        color: AppColor.white,
      ),
      'Something went wrong!',
      title,
      titleText: Text(
        LocaleKeys.remittance_something_went_wrong.tr,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: const Alignment(
          1.0,
          5.0,
        ),
        colors: [const Color(0xFFE3242B), Colors.blue[800]!],
      ),
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.black,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Future<void> successSnackbar({
    required String title,
  }) async {
    Get.snackbar(
      icon: const Icon(
        Icons.check,
        color: AppColor.white,
      ),
      'Success',
      title,
      titleText: Text(
        LocaleKeys.success_status.tr,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: const Alignment(
          1.0,
          5.0,
        ),
        colors: [const Color(0xFFE3242B), Colors.blue[800]!],
      ),
      backgroundColor: AppColor.primary,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Future<void> comingSoonSnackbar({
    required BuildContext context,
  }) async {
    Get.defaultDialog(
      title: "Oopps",
      content: Column(
        children: [
          Lottie.asset('assets/lottie/coming-soon.json',
              animate: true,
              repeat: true,
              reverse: true,
              fit: BoxFit.fill,
              // height: 150,
              width: 150),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.coming_soon.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 15),
          Text(
            LocaleKeys.coming_soon_desc.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      onConfirm: () {
        Get.back();
      },
      confirmTextColor: Colors.white,
      textConfirm: "Okay",
    );
  }
}
