import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/remittance_beneficiary_my/local_widget/add_beneficiary_box.dart';
import 'package:berrypay_global_x/app/modules/malaysia/remittance/remittance_beneficiary_my/local_widget/beneficiary_tile.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/remittance_beneficiary_my_controller.dart';

class RemittanceBeneficiaryMyView
    extends GetView<RemittanceBeneficiaryMyController> {
  const RemittanceBeneficiaryMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.remittance_beneficiary.tr),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getDocType(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.remittance_new.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                AddBeneficiaryBox(
                  onTap: () => Get.toNamed(
                    Routes.REMITTANCE_FORM_MY,
                    arguments: {
                      'calcBy': Get.arguments['calcBy'],
                      'amount': controller.amount,
                      'country': controller.country,
                      'currency': controller.currency,
                      'receiverCountry': controller.receiverCountry
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.remittance_beneficiary_list.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.isLoading.value
                      ? const BerryPayLoading()
                      : Container(
                          child: controller.getBeneficiaryResponse!.isEmpty
                              ? Text(LocaleKeys.remittance_no_beneficiary.tr)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount:
                                      controller.getBeneficiaryResponse?.length,
                                  itemBuilder: (context, index) {
                                    return BeneficiaryTile(
                                      beneficiary: controller
                                          .getBeneficiaryResponse![index],
                                      onTap: () {
                                        controller.viewDetails(index);
                                        // Get.toNamed(Routes.BENEFICIARY_INFO_MY, arguments: {
                                        //   "data": beneficiary,
                                        //   'amount': controller.amount,
                                        // });
                                      },
                                    );
                                  },
                                ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
