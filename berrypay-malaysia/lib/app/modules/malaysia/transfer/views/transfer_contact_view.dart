import 'package:berrypay_global_x/app/modules/malaysia/transfer/controllers/transfer_my_controller.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TransferContactView extends GetView<TransferMyController> {
  const TransferContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.transfer_transfer_other_acc.tr.toUpperCase(),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            LocaleKeys.transfer_transfer_registered.tr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          controller.ssWalletTransferModelVO?.p2pList == null
              ? const Text('No contact registered with BerryPay wallet')
              : Obx(
                  () => Expanded(
                    child: ListView(
                      children: controller.contactList
                          .map(
                            (element) => ListTile(
                              leading: const Icon(Icons.wallet),
                              title: Text(element.userProfile?.fullName ?? ""),
                              subtitle:
                                  Text(element.userProfile?.mobileNo ?? ""),
                              onTap: () =>
                                  controller.selectWallet(element.userProfile!),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
