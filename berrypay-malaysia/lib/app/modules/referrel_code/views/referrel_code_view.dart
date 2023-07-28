import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/referrel_code_controller.dart';

class ReferrelCodeView extends GetView<ReferrelCodeController> {
  const ReferrelCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Beneficiary',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text(
          'Unlock exclusive rewards! Do you have a referral code to earn extra benefits?',
        ),
      ),
    );
  }
}
