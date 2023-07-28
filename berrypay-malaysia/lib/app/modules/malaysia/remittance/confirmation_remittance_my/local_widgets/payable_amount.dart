import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalPayable extends StatelessWidget {
  const TotalPayable({
    super.key,
    required this.collectedAmount,
  });

  final String collectedAmount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.black87,
          disabledForegroundColor: Colors.white,
          // foreground
        ),
        onPressed: null,
        child: Text(
            '${LocaleKeys.remittance_total_payable.tr}: RM $collectedAmount'),
      ),
    );
  }
}
