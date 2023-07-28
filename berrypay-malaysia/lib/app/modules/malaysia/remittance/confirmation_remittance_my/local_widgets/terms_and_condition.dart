import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({
    super.key,
    required this.tnc,
    this.onTap,
  });

  final RxBool tnc;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => Checkbox(
                activeColor: Colors.red,
                checkColor: Colors.white,
                value: tnc.value,
                onChanged: (bool? value) {
                  logger('tick');
                  logger(tnc.value.toString());

                  tnc.value = value!;
                },
              ),
            ),
            Text(LocaleKeys.user_info_user_agree_text.tr,
                style: const TextStyle(color: Colors.black, fontSize: 13)),

            // Go to Terms & Condition Page
            InkWell(
              onTap: onTap,
              child: Text(LocaleKeys.profile_page_tnc_text.tr,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '*${LocaleKeys.remittance_term_cond1.tr}\n',
              style: Theme.of(context).textTheme.bodySmall,
              children: <TextSpan>[
                TextSpan(
                  text: LocaleKeys.remittance_term_cond2.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColor.primary),
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
