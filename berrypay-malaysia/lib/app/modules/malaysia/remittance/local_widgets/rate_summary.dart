import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';

class RateSummary extends StatelessWidget {
  const RateSummary({
    super.key,
    required this.transferFee,
    required this.payableAmount,
    required this.rate,
  });

  final num transferFee;
  final RxDouble payableAmount;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 3,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container())
          ],
        ),
        Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(1.0),
          highlightColor: Colors.red.shade200,
          period: const Duration(seconds: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'RM ${transferFee.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '- ${LocaleKeys.remittance_transfer_fee.tr}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 3,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container())
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(1.0),
          highlightColor: Colors.red.shade200,
          period: const Duration(seconds: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              Obx(
                () => Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'RM ${payableAmount.toStringAsFixed(2)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '- ${LocaleKeys.remittance_payable_amount.tr}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 3,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container())
          ],
        ),
        Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(1.0),
          highlightColor: Colors.red.shade200,
          period: const Duration(seconds: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '$rate',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '- ${LocaleKeys.remittance_exchange_rate.tr}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 3,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container())
          ],
        ),
      ],
    );
  }
}
