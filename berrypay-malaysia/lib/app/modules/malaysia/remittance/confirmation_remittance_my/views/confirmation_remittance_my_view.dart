import 'package:berrypay_global_x/app/global_widgets/dotted_seperator.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/beneficiary_container.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/exchange_rate_container.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/next_button.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/one_last_step.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/payable_amount.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/rate_disclaimer.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/remit_overview.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/confirmation_remittance_my/local_widgets/terms_and_condition.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/confirmation_remittance_my_controller.dart';

class ConfirmationRemittanceMyView
    extends GetView<ConfirmationRemittanceMyController> {
  const ConfirmationRemittanceMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          LocaleKeys.confirmation_text.tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: controller.agent!.isEmpty
              ? const Text('No agent')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OneLastStep(),
                    const SizedBox(height: 20),
                    const MySeparator(),
                    const SizedBox(height: 20),
                    RateDisclaimer(currentDate: controller.currentDate),
                    const SizedBox(height: 20),
                    Obx(
                      () => controller.isLoading.value
                          ? const BerryPayLoading()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RemitOverview(
                                  sendAmount: controller.amount ?? "",
                                  countryImageUrl: controller.getCountry,
                                  beneficiary:
                                      controller.getBeneficiaryResponse,
                                  transferFee: controller.transferFeeResponse,
                                ),
                                const SizedBox(height: 30),
                                ExchangeRateContainer(
                                  transferFee: controller.transferFeeResponse,
                                ),
                                const SizedBox(height: 30),
                                BeneficiaryContainer(
                                  beneficiary:
                                      controller.getBeneficiaryResponse,
                                ),
                                const SizedBox(height: 20),
                                TotalPayable(
                                  collectedAmount: controller
                                          .transferFeeResponse?.CollectAmount ??
                                      "",
                                ),
                                const SizedBox(height: 20),
                                TermsAndCondition(
                                  onTap: controller.launchInBrowser,
                                  tnc: controller.tnc,
                                )
                              ],
                            ),
                    )
                  ],
                ),
        ),
      ),
      bottomNavigationBar: NextButton(
        tnc: controller.tnc,
        onConfirm: () {
          Get.close(1);
          controller.onSubmit();
        },
      ),
    );
  }
}
