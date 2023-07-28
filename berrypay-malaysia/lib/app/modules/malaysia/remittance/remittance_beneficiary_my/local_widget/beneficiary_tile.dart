import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryTile extends StatelessWidget {
  const BeneficiaryTile({
    super.key,
    required this.beneficiary,
    this.onTap,
  });

  final DataBeneficiary beneficiary;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
            border: Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColor.primary,
                  child: Text(
                    beneficiary.Nameenglish!.Firstname![0],
                    style: const TextStyle(color: AppColor.white),
                  ),
                )),
            const SizedBox(width: 15),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        beneficiary.Nameenglish!.Firstname!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Get.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(beneficiary.Beneficiarydetail!.Accountnumber!,
                      style: Get.textTheme.bodySmall),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(beneficiary.Beneficiarydetail!.Bankname!,
                      style: Get.textTheme.bodySmall)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
