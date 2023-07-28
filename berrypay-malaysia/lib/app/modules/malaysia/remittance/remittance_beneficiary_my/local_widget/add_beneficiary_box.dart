import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBeneficiaryBox extends StatelessWidget {
  const AddBeneficiaryBox({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
                border:
                    Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add_alt_1,
                  size: 40,
                  color: AppColor.primary,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  LocaleKeys.remittance_beneficiary.tr,
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
