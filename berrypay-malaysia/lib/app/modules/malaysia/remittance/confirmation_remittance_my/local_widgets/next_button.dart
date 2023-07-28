import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.tnc,
    this.onConfirm,
  });

  final RxBool tnc;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppButton.rectangle(
        onTap: () {
          if (tnc.isFalse) {
            AppSnackbar.errorSnackbar(
              title: LocaleKeys.remittance_please_agree.tr,
            );
          } else {
            Get.defaultDialog(
              title: LocaleKeys.remittance_receipt_issuance.tr,
              titleStyle: const TextStyle(fontSize: 16),
              titlePadding: const EdgeInsets.only(top: 20),
              content: Text(
                LocaleKeys.remittance_receipt_issuance_desc.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onConfirm: onConfirm,
              textCancel: LocaleKeys.cancel_text.tr,
              confirmTextColor: Colors.white,
            );
          }
        },
        title: LocaleKeys.next_text.tr,
      ),
    );
  }
}
