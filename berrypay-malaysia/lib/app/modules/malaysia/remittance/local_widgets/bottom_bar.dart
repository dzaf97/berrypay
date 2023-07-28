import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    this.onSubmit,
  }) : super(key: key);

  final Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                LocaleKeys.remittance_rate_disclaimer.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColor.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        AppButton.outlinedBorder(
          onTap: onSubmit,
          // onTap: () =>Get.toNamed(Routes.REMITTANCE_FORM_MY),
          title: LocaleKeys.remittance_submit.tr,
        ),
      ],
    );
  }
}
