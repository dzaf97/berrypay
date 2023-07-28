import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/global_widgets/text_info.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wallet_benefit_controller.dart';

class WalletBenefitView extends GetView<WalletBenefitController> {
  const WalletBenefitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[800]!,
        title: Text(
          LocaleKeys.profile_page_my_benefit.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Body(
      //     controller: controller,
      //   ),
      // ),
      body: Body(controller: controller),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final WalletBenefitController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: Get.height * 0.15,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[800]!,
            // borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.card_giftcard_outlined,
                      color: AppColor.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.profile_page_current_wallet.tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          profileType(controller
                                  .getSSWalletCardModelVO!
                                  .userProfileVO!
                                  .walletProfileList![0]
                                  .profileType!)
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextInfo(
                title: LocaleKeys.transaction_page_card_balance_text.tr,
                subtitle: 'RM${controller.balance}')
            .paddingOnly(bottom: 20, left: 16),
        TextInfo(
                title: LocaleKeys.profile_page_wallet_size.tr,
                subtitle:
                    'RM${controller.getSSWalletCardModelVO?.userProfileVO?.walletProfileList?[0].profileMaxBalance}')
            .paddingOnly(bottom: 20, left: 16),
        controller.getSSWalletCardModelVO?.userProfileVO?.walletProfileList?[0]
                    .profileType ==
                ProfileType.PersonalPremium
            ? ListView.separated(
                shrinkWrap: true,
                itemCount: controller.benefitsPremium.length,
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      controller.icon[index],
                      color: AppColor.primary,
                      size: 20,
                    ),
                    title: Text(
                      controller.titleBenefitsPremium[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      controller.benefitsPremium[index],
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                })
            : ListView.separated(
                shrinkWrap: true,
                itemCount: controller.benefitBasic.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      controller.iconBasic[index],
                      color: AppColor.primary,
                      size: 20,
                    ),
                    title: Text(
                      controller.titleBenefitsBasic[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      controller.benefitBasic[index],
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                  );
                }),
      ],
    );
  }
}

profileType(ProfileType profileType) {
  logger(profileType);
  switch (profileType) {
    case ProfileType.PersonalPremium:
      return 'Premium';

    case ProfileType.Personal:
      return 'Basic';

    default:
  }
}
