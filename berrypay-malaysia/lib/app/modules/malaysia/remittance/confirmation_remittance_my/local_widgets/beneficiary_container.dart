import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/column_subtitle.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/column_title.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BeneficiaryContainer extends StatelessWidget {
  const BeneficiaryContainer({
    super.key,
    this.beneficiary,
  });

  final DataBeneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, bottom: 8, top: 8),
            child: Text(
              LocaleKeys.remittance_beneficiary.tr.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
              ),
              right: BorderSide(color: Colors.grey.shade300),
              left: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    ColumnTitle(
                      title1: LocaleKeys.remittance_name.tr,
                      title3: LocaleKeys.remittance_bank_name.tr,
                      title2: LocaleKeys.remittance_acc_no.tr,
                    ),
                    const SizedBox(width: 20),
                    ColumnSubtitle(
                      subtitle1:
                          '${beneficiary!.Nameenglish!.Firstname} ${beneficiary!.Nameenglish!.Lastname}',
                      subtitle3: '${beneficiary!.Beneficiarydetail!.Bankname}',
                      subtitle2:
                          '${beneficiary!.Beneficiarydetail!.Accountnumber}',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
