import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneLastStep extends StatelessWidget {
  const OneLastStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            LocaleKeys.remittance_one_last_step.tr,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            LocaleKeys.remittance_review.tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
