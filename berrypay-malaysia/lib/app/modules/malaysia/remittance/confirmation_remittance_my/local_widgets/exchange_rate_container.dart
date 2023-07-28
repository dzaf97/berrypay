import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/column_subtitle.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/column_title.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeRateContainer extends StatelessWidget {
  const ExchangeRateContainer({
    super.key,
    this.transferFee,
  });

  final DataTransferFee? transferFee;

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
              LocaleKeys.remittance_exchange_rate.tr.toUpperCase(),
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
                      title1: LocaleKeys.remittance_you_pay.tr,
                      title4:
                          LocaleKeys.transaction_page_beneficiary_get_text.tr,
                      title2: LocaleKeys.remittance_transfer_fee.tr,
                      title3: LocaleKeys.remittance_exchange_rate.tr,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ColumnSubtitle(
                      subtitle1:
                          'RM ${double.parse(transferFee!.TransferAmount!).toStringAsFixed(2)}',
                      subtitle4:
                          '${transferFee!.PayoutCurrency} ${double.parse(transferFee!.PayoutAmount!).toStringAsFixed(2)}',
                      subtitle2:
                          'RM ${double.parse(transferFee!.ServiceCharge!).toStringAsFixed(2)}',
                      subtitle3: double.parse(transferFee!.ExchangeRate!)
                          .toStringAsFixed(4),
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
