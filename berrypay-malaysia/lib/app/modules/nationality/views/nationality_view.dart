import 'package:azlistview/azlistview.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/nationality_controller.dart';

class NationalityView extends GetView<NationalityController> {
  const NationalityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CountryView'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(bottom: 20),
              height: 30,
              child: const Text(
                "Select your country code",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: AzListView(
                data: controller.nationality,
                itemBuilder: (BuildContext context, int index) {
                  controller.nationality[index].isShowSuspension;
                  return Column(
                    children: [
                      Offstage(
                        offstage:
                            controller.nationality[index].isShowSuspension !=
                                true,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          height: 40,
                          color: Colors.grey.shade200,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Text(
                                controller.nationality[index]
                                    .getSuspensionTag(),
                                textScaleFactor: 1.2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          controller.selectedNationalityCode.value =
                              controller.nationality[index].cca3!;
                          controller.selectedNationality.value =
                              controller.nationality[index].name!.common!;
                          Get.back();
                        },
                        leading: Text(
                          controller.nationality[index].flag!,
                          style: const TextStyle(fontSize: 30),
                        ),
                        title: Text(
                          controller.nationality[index].name!.common!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: controller.nationality.length,
              ),
            ),
          ],
        ));
  }
}
