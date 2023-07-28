import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/values/languages/locales.g.dart';
import 'package:berrypay_global_x/app/global_widgets/frosted_glass.dart';
import 'package:berrypay_global_x/app/global_widgets/shimmer.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VaCard {
  static Widget colouredCard({
    required String vaNum,
    required String prefix,
    required List<Color> colors,
    required String bankIcon,
    required BuildContext context,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 200,
            // width: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.topLeft,
                  colors: colors),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          ///Circle
          Positioned(
            top: -100,
            right: -30,
            child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                )),
          ),

          ///Circle
          Positioned(
            top: 0,
            right: -100,
            child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                )),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                SizedBox(
                  height: 40,

                  ///Bank Logo
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/$bankIcon',
                        width: 80,
                      ),
                    ],
                  ),
                ),

                ///Chip and balance
                SizedBox(
                  height: 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/chip_card.png',
                        width: 45,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Virtual Account Number
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.virtual_account.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                          vaNum.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: ShimmerSingle(height: 15, width: 120),
                                )
                              : Text('$prefix $vaNum',
                                  style: TextStyle(color: Colors.yellow[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget blueCard({
    required String vaNum,
    required List<Color> colors,
    required String bankIcon,
    required BuildContext context,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            height: 200,
            // width: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.centerLeft,
                  colors: colors),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(
                    10.0,
                    12.0,
                  ),
                  blurRadius: 15.0,
                  spreadRadius: 4.0,
                ),
              ],
            ),
          ),

          ///Circle
          Positioned(
            top: 115,
            left: 5,
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(100),
                )),
          ),

          ///Circle
          Positioned(
            top: -10,
            right: -10,
            child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(100),
                )),
          ),

          ///Circle
          Positioned(
            top: -10,
            right: -10,
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(100),
                )),
          ),

          ///Bank Logo
          Positioned(
            bottom: -20,
            right: -60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/$bankIcon',
                  width: 200,
                  color: Colors.white.withOpacity(0.2),
                ),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                ///Chip and balance
                // Container(
                //   height: 85,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Image.asset(
                //         'assets/images/chip_card.png',
                //         width: 45,
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Virtual Account Number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              'Virtual Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0),
                              minFontSize: 10,
                              maxFontSize: 20,
                            ),
                            AutoSizeText(
                              "Anis",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 70),
                            vaNum.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child:
                                        ShimmerSingle(height: 15, width: 120),
                                  )
                                : AutoSizeText(vaNum,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        letterSpacing: 2.0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget frostedCard({
    required String accountBalance,
    required String fullName,
    required BuildContext context,
    required String img,
    double logoWidth = 60,
  }) {
    return FrostedGlass(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              flex: 1,
              child: Stack(children: [
                // Circle
                Positioned(
                  top: -100,
                  right: -30,
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),

                // Circle
                Positioned(
                  top: -50,
                  right: -100,
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),

                // Logo, Balance, Name
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: double.infinity,
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          img != 'berrypay-global-x'
                              ? Image.asset(
                                  'assets/images/$img',
                                  width: logoWidth,
                                )
                              : Row(
                                  children: [
                                    Image.asset("assets/images/logo.png",
                                        color: Colors.white, width: 20.0),
                                    const SizedBox(width: 5),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(color: Colors.white),
                                        children: [
                                          TextSpan(text: "BERRY"),
                                          TextSpan(
                                              text: "PAY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              // color: Colors.red,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    accountBalance.isNotEmpty
                                        ? RichText(
                                            text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  "${LocaleKeys.main_page_Account_balance.tr.toUpperCase()}\n",
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 10),
                                            ),
                                            TextSpan(
                                                text: accountBalance,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 26,
                                                )),
                                          ]))
                                        : const ShimmerLoadingBalanceBox(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                  ]))),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.cardholder.tr,
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 10)),

                                      // If full name is null, show loading
                                      // UserConst.fullName != null
                                      "UserConst.fullName" != null
                                          ? Text(
                                              "Anis",
                                              // UserConst.fullName!.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            )
                                          : const ShimmerSingle(),
                                    ]),
                                // Text(
                                //   '$bankName',
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                // Top Up Icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      icon: Image.asset(
                        "assets/images/plus.png",
                        color: Colors.white.withOpacity(0.8),
                      ),
                      onPressed: () {},
                      // onPressed: () => AppNav.cupertinoPush(
                      //   context: context,
                      //   route: TopupListPage(),
                      // ),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  static Widget frostedCardLoading({
    required BuildContext context,
  }) {
    return FrostedGlass(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              flex: 1,
              child: Stack(children: [
                // Circle
                Positioned(
                  top: -100,
                  right: -30,
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),

                // Circle
                Positioned(
                  top: -50,
                  right: -100,
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),

                // Logo, Balance, Name
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: double.infinity,
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerSingle(height: 15),
                      Expanded(
                          flex: 2,
                          child: Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              // color: Colors.red,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    ShimmerLoadingBalanceBox(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ]))),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.cardholder.tr,
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 10)),
                                      const SizedBox(height: 5),
                                      const ShimmerSingle(height: 15),
                                    ]),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                // Top Up Icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      icon: Image.asset(
                        "assets/images/plus.png",
                        color: Colors.white.withOpacity(0.8),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  static Widget noFrostedCard(
      {required BuildContext context,
      String message = 'Create your new wallet.'}) {
    return FrostedGlass(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/plus.png",
              color: Colors.white.withOpacity(0.8),
              width: 50.0,
            ),
            const SizedBox(height: 10),
            Text(LocaleKeys.home_page_create_new_wallet_text.tr,
                style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  static Widget walletFrostedCard(
      {required String accountBalance,
      required String cardHolder,
      required BuildContext context,
      dynamic Function()? ontap,
      String? type,
      bool? upgrade = true}) {
    return FrostedGlass(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              flex: 1,
              child: Stack(children: [
                // Circle
                Positioned(
                  top: -100,
                  right: -30,
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),

                // Circle
                Positioned(
                  top: -50,
                  right: -100,
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      )),
                ),

                // Logo, Balance, Name
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: double.infinity,
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/logo.png",
                                  color: Colors.white, width: 20.0),
                              const SizedBox(width: 5),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(text: "BERRY"),
                                    TextSpan(
                                        text: "PAY",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              // color: Colors.red,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    accountBalance.isNotEmpty
                                        ? RichText(
                                            text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  "${LocaleKeys.main_page_Account_balance.tr.toUpperCase()}\n",
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 10),
                                            ),
                                            TextSpan(
                                                text: accountBalance,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 26,
                                                )),
                                          ]))
                                        : const ShimmerLoadingBalanceBox(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                  ]))),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.cardholder.tr,
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 10)),
                                      Text(
                                        cardHolder,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                                Text(
                                  type ?? 'BASIC',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                upgrade == true
                    ?

                    // Top Up Icon
                    Positioned(
                        top: 10,
                        right: 10,
                        child: SizedBox(
                          width: 75,
                          height: 65,
                          child: Column(
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  "assets/images/plus.png",
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                onPressed:
                                    // logger('masuk');
                                    ontap,

                                // onPressed: () {
                                //   BottomModalSheet.chooseWalletType(context: context);
                                // },
                              ),
                              const Text(
                                'UPGRADE',
                                style: TextStyle(
                                    fontSize: 8, color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ]))
        ],
      ),
    );
  }
}
