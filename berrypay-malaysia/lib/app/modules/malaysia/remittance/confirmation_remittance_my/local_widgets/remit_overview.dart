import 'package:berrypay_global_x/app/data/model/remitx/beneficiary.dart';
import 'package:berrypay_global_x/app/data/model/remitx/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemitOverview extends StatelessWidget {
  const RemitOverview({
    super.key,
    required this.sendAmount,
    required this.countryImageUrl,
    this.beneficiary,
    this.transferFee,
  });

  final String sendAmount;
  final String countryImageUrl;
  final DataBeneficiary? beneficiary;
  final DataTransferFee? transferFee;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/mys.png', width: 30),
                const SizedBox(height: 10),
                Text(
                  'Malaysia',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                Text('RM $sendAmount')
              ],
            ),
          ),
        ),
        const Icon(Icons.arrow_forward).paddingOnly(right: 16, left: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  height: 30,
                  width: 30,
                  child: Image.network(countryImageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                Text(
                  '${beneficiary!.Beneficiarydetail!.Countryname}'
                      .capitalizeFirst!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                Text(
                    '${transferFee!.PayoutCurrency} ${transferFee!.PayoutAmount}')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
