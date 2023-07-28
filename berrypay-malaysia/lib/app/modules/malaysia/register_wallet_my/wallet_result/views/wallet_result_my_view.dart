import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/ticket.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/wallet_result_my_controller.dart';

class WalletResultMyView extends GetView<WalletResultMyController> {
  const WalletResultMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: const Alignment(5.0, 1.0),
          colors: [Colors.red[800]!, Colors.blue[800]!],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[800],
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
        ),
        body: Body(
          accountType: controller.argument,
        ),
        bottomNavigationBar: BottomBar(controller: controller),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WalletResultMyController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 20,
            ),
          ]),
      child: Row(
        children: [
          Expanded(
              child: AppButton.rectangle(
                  onTap: () => controller.startNow(), title: 'Start Now')),
        ],
      ).paddingSymmetric(vertical: 10, horizontal: 20),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    this.accountType,
  }) : super(key: key);

  final String? accountType;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: TicketWidget.main(
            isCornerRounded: true,
            height: 500,
            topFlex: 1,
            bottomFlex: 2,
            circlePosition: 3,
            context: context,
            topChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset('assets/lottie/done.json', width: 100),
                  const Text(
                    'Success',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            bottomChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  accountType == "basic"
                      ? 'Registration Complete!'
                      : 'Upgrade Complete!',
                  style: Theme.of(context).textTheme.headline6!,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    accountType == "basic"
                        ? 'You have successfully registered for a Basic Wallet Account which entitles you to exprience safe and convenient way to pay.'
                        : 'Your application is under process.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Account Type:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  accountType == "basic"
                      ? 'Basic Wallet Account'
                      : 'Premium Wallet Account',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
          ),
        )
        // child: Container(
        //   color: AppColor.white,
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Lottie.asset('assets/lottie/done.json', width: 120),
        //         Text(
        //           'Registration Complete!',
        //           style: Theme.of(context).textTheme.headline6!,
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           'You have successfully registered for a Basic Wallet Account which entitles you to exprience safe and convenient way to pay.',
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context).textTheme.caption,
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         const Text(
        //           'Account Type',
        //           textAlign: TextAlign.center,
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           'Basic Wallet Account',
        //           style: TextStyle(color: AppColor.secondary),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         AppButton.rounded(width: 150, onTap: () {}, title: 'Start Now')
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
