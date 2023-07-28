import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/kyc_result_my_controller.dart';

class KycResultMyView extends GetView<KycResultMyController> {
  const KycResultMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
        ),
        body: controller.argument == 'eKYCStatusPending'
            ? PendingUpgrade(
                controller: controller,
              )
            : controller.argument == 'eKYCStatusRemitPending'
                ? Pendingremit(controller: controller)
                : Body(
                    controller: controller,
                  ),
        bottomNavigationBar: BottomBar(
          controller: controller,
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KycResultMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: AppButton.rounded(
          onTap: () {
            controller.proceed();
          },
          title: 'Okay'),
    );
  }
}

class BenefitAdvance extends StatelessWidget {
  const BenefitAdvance({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KycResultMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.kyc_page_enjoy_with.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.benefitsAdvance.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: AppColor.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      controller.benefitsAdvance[index],
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KycResultMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            LocaleKeys.kyc_page_kyc_verification.tr.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset("assets/images/kyc.png", width: 250),
          // const Text('Congratulations, you\'ve upgraded to'),
          // const Text(
          //   'Advance Account',
          //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          // ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                  ),
                  child: Text(LocaleKeys.kyc_page_under_process.tr),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 4,
          ),
          BenefitAdvance(controller: controller)
        ],
      ),
    );
  }
}

class PendingUpgrade extends StatelessWidget {
  const PendingUpgrade({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KycResultMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.kyc_page_pending_review.tr.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Lottie.asset('assets/lottie/pending.json',
              animate: true, repeat: true, reverse: true, width: 150),
          const SizedBox(
            height: 20,
          ),
          Text(
            LocaleKeys.kyc_page_we_are_currently_verify.tr,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Pendingremit extends StatelessWidget {
  const Pendingremit({super.key, required this.controller});

  final KycResultMyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.kyc_page_pending_review.tr.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Lottie.asset('assets/lottie/pending.json',
              animate: true, repeat: true, reverse: true, width: 150),
          const SizedBox(
            height: 20,
          ),
          Text(
            LocaleKeys.remittance_kyc_remit.tr,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class FailedUpgrade extends StatelessWidget {
  const FailedUpgrade({
    Key? key,
    required this.controller,
    required this.context,
  }) : super(key: key);

  final KycResultMyController controller;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'UNABLE TO UPGRADE',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          Lottie.asset('assets/lottie/error.json',
              animate: true, repeat: true, reverse: true, width: 150),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              'The document you submitted did not match with the details you previously registered with us.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              'To verify again, please resubmit the documents or contact us for assistance.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reason ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.failedUpgrade.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: AppColor.primary,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                controller.failedUpgrade[index],
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
