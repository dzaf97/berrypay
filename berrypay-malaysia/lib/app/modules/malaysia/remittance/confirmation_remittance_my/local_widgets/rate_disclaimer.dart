import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RateDisclaimer extends StatelessWidget {
  const RateDisclaimer({
    super.key,
    required this.currentDate,
  });

  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.info),
            const SizedBox(width: 10),
            Text(
              LocaleKeys.remittance_exchange_rate_change.tr.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Text(
              '${LocaleKeys.remittance_exchange_disclaimer1.tr} $currentDate. ${LocaleKeys.remittance_exchange_disclaimer2.tr}.'),
        ),
      ],
    );
  }
}
