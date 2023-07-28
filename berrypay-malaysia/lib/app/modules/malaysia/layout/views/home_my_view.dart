import 'package:auto_size_text/auto_size_text.dart';
import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/global_widgets/shimmer_loading_balance_box.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/global_widgets/va_card.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/home_my_controller.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeMyView extends GetView<HomeMyController> {
  const HomeMyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 2),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.refreshHome();
                },
                child: ListView(
                  children: [
                    Obx(
                      () => TopMenu(
                        name: controller.isLoading.isTrue
                            ? 'Member'
                            : controller.profileInfo?.fullName ?? "-",
                        controller: controller,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: const Text('Menu'),
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 30.0,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MenuBox(
                            icon: "assets/icons/plus-circle.png",
                            title: LocaleKeys.home_page_topup_text.tr,
                            onTap: () {
                              if (controller.walletId == null) {
                                AppSnackbar.errorSnackbar(
                                    title:
                                        LocaleKeys.remittance_error_upgrade.tr);
                                return;
                              }
                              Get.toNamed(Routes.TOPUP_MY);

                              // AppSnackbar.comingSoonSnackbar(context: context);
                            }),
                        MenuBox(
                          icon: "assets/icons/1347-card-exchange-flat.png",
                          title: LocaleKeys.home_page_transfer.tr,
                          onTap: () {
                            if (controller.walletId == null ||
                                controller
                                            .getSSWalletCardModelVO!
                                            .userProfileVO!
                                            .walletProfileList![0]
                                            .profileType !=
                                        ProfileType.PersonalPremium &&
                                    controller
                                            .getSSWalletCardModelVO!
                                            .userProfileVO!
                                            .walletProfileList![0]
                                            .profileType !=
                                        ProfileType.PersonalAdvance) {
                              AppSnackbar.errorSnackbar(
                                  title:
                                      LocaleKeys.remittance_error_upgrade.tr);
                            } else {
                              controller
                                  .requestContactPermission(Routes.TRANSFER_MY);
                            }

                            // AppSnackbar.comingSoonSnackbar(context: context);
                          },
                        ),
                        MenuBox(
                          icon: "assets/icons/paperlane.png",
                          title: LocaleKeys.home_page_withdraw.tr,
                          onTap: () {
                            if (controller.walletId == null) {
                              AppSnackbar.errorSnackbar(
                                  title:
                                      LocaleKeys.remittance_error_upgrade.tr);
                              return;
                            }
                            controller.toWithdrawPage();

                            // AppSnackbar.comingSoonSnackbar(context: context);
                          },
                        ),
                        // MenuBox(
                        //   icon: "assets/icons/bill-payment.png",
                        //   title: "Pay",
                        //   onTap: () {
                        //     if (controller.walletId == null) {
                        //       AppSnackbar.errorSnackbar(
                        //           title:
                        //               'Please upgrade your wallet to use this feature.');
                        //       return;
                        //     }

                        //     Get.toNamed(Routes.SPENDING_MY);
                        //   },
                        // ),
                        // MenuBox(
                        //   icon: "assets/icons/transfer2.png",
                        //   title: "Remittance",
                        //   // onTap: () => Get.toNamed(Routes.REMITTANCE_MY),
                        //   onTap: () => Get.toNamed(Routes.EXCHANGE_RATE_MY),
                        // ),
                        // MenuBox(
                        //   icon: "assets/icons/transaction-history.png",
                        //   title: "Request",
                        //   onTap: () {
                        //     if (controller.walletId == null ||
                        //         controller
                        //                     .getSSWalletCardModelVO!
                        //                     .userProfileVO!
                        //                     .walletProfileList![0]
                        //                     .profileType !=
                        //                 ProfileType.PersonalPremium &&
                        //             controller
                        //                     .getSSWalletCardModelVO!
                        //                     .userProfileVO!
                        //                     .walletProfileList![0]
                        //                     .profileType !=
                        //                 ProfileType.PersonalAdvance) {
                        //       AppSnackbar.errorSnackbar(
                        //           title:
                        //               'Please upgrade your wallet to use this feature.');
                        //     } else {
                        //       controller
                        //           .requestContactPermission(Routes.REQUEST_MY);
                        //     }
                        //   },
                        // ),
                        MenuBox(
                          icon: "assets/icons/bill-payment.png",
                          title: LocaleKeys.home_page_pay_text.tr,
                          onTap: () {
                            if (controller.walletId == null) {
                              AppSnackbar.errorSnackbar(
                                  title:
                                      LocaleKeys.remittance_error_upgrade.tr);
                              return;
                            }

                            Get.toNamed(Routes.SPENDING_MY);

                            // AppSnackbar.comingSoonSnackbar(context: context);
                          },
                        ),
                        MenuBox(
                          icon: "assets/icons/transfer2.png",
                          title: LocaleKeys.home_page_remittance_text.tr,
                          // onTap: () => Get.toNamed(Routes.REMITTANCE_MY),
                          // onTap: () => Get.toNamed(Routes.EXCHANGE_RATE_MY),
                          onTap: () => controller.requestLocationPermission(
                            Routes.EXCHANGE_RATE_MY,
                          ),
                        ),
                        MenuBox(
                          icon: "assets/icons/transaction-history.png",
                          title: LocaleKeys.home_page_request_text.tr,
                          onTap: () {
                            if (controller.walletId == null ||
                                controller
                                            .getSSWalletCardModelVO!
                                            .userProfileVO!
                                            .walletProfileList![0]
                                            .profileType !=
                                        ProfileType.PersonalPremium &&
                                    controller
                                            .getSSWalletCardModelVO!
                                            .userProfileVO!
                                            .walletProfileList![0]
                                            .profileType !=
                                        ProfileType.PersonalAdvance) {
                              AppSnackbar.errorSnackbar(
                                  title:
                                      LocaleKeys.remittance_error_upgrade.tr);
                            } else {
                              controller
                                  .requestContactPermission(Routes.REQUEST_MY);
                            }
                            // AppSnackbar.comingSoonSnackbar(context: context);
                          },
                        ),
                        MenuBox(
                          icon: "assets/icons/signal.png",
                          title: LocaleKeys.home_page_bill_payment_text.tr,
                          onTap: () {
                            Get.toNamed(Routes.BILL_PAYMENT);
                            // AppSnackbar.comingSoonSnackbar(context: context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopMenu extends StatelessWidget {
  const TopMenu({
    Key? key,
    required this.name,
    required this.controller,
  }) : super(key: key);

  final String name;
  final HomeMyController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(
            5.0,
            1.0,
          ),
          colors: [const Color(0xFFE3242B), Colors.blue[800]!],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          GreetingUser(
            fullName: name,
            name: name.split(" ").elementAt(0),
            controller: controller,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: controller.isLoading.isTrue
                  ? const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ShimmerLoadingBalanceBox())
                  : controller.walletId == null
                      ? GestureDetector(
                          onTap: () {
                            logger('masuk');
                            Get.toNamed(Routes.REGISTER_WALLET_MY,
                                arguments: 'Basic');

                            // AppSnackbar.comingSoonSnackbar(context: context);
                          },
                          child: VaCard.noFrostedCard(context: context),
                        )
                      : GestureDetector(
                          onTap: () {
                            logger('masuk sini');
                            // Get.toNamed(Wallet.route, arguments: 'Advance');
                            // chooseWalletType(context: context);
                            // Get.toNamed(Wallet.route);
                          },
                          child: Obx(
                            () => VaCard.walletFrostedCard(
                              type: controller
                                          .getSSWalletCardModelVO!
                                          .userProfileVO!
                                          .walletProfileList![0]
                                          .profileType ==
                                      ProfileType.PersonalAdvance
                                  ? 'ADVANCE'
                                  : controller
                                              .getSSWalletCardModelVO!
                                              .userProfileVO!
                                              .walletProfileList![0]
                                              .profileType ==
                                          ProfileType.PersonalPremium
                                      ? 'PREMIUM'
                                      : 'BASIC',
                              upgrade: controller
                                              .getSSWalletCardModelVO!
                                              .userProfileVO!
                                              .walletProfileList![0]
                                              .eKYCStatus ==
                                          EKYCStatus.AdminVerified ||
                                      controller
                                              .getSSWalletCardModelVO!
                                              .userProfileVO!
                                              .walletProfileList![0]
                                              .eKYCStatus ==
                                          EKYCStatus.Verified
                                  ? false
                                  : true,
                              // ontap: chooseWalletType(context: context),

                              ontap: () {
                                // logger(controller
                                //     .getSSWalletCardModelVO!
                                //     .userProfileVO!
                                //     .walletProfileList![0]
                                //     .eKYCStatus);
                                controller
                                            .getSSWalletCardModelVO!
                                            .userProfileVO!
                                            .walletProfileList![0]
                                            .eKYCStatus ==
                                        EKYCStatus.Pending
                                    ? Get.toNamed(Routes.KYC_RESULT_MY,
                                        arguments: 'eKYCStatusPending')
                                    : Get.toNamed(Routes.REGISTER_WALLET_MY,
                                        arguments: 'Premium');

                                // AppSnackbar.comingSoonSnackbar(
                                //     context: context);
                              },
                              context: context,
                              accountBalance:
                                  'RM ${controller.balance.toStringAsFixed(2)}',
                              cardHolder: controller.walletId!,
                            ),
                          ),
                        ),
            ),
          )
        ],
      ),
    );
  }

  dynamic chooseWalletType({required BuildContext context}) {
    Get.bottomSheet(
      SizedBox(
        // height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 6,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Upgrade Wallet',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              controller.walletId != null
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER_WALLET_MY,
                            arguments: 'Basic');
                      },
                      child: ListTile(
                        title: Text(
                          'Basic',
                          style: TextStyle(color: AppColor.secondary),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Create your wallet'),
                      ),
                    ),
              Divider(color: Colors.grey.shade300),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REGISTER_WALLET_MY, arguments: 'Advance');

                  // Get.toNamed(Routes.KYC_RESULT_MY);
                },
                child: ListTile(
                  title: Text(
                    'Advance',
                    style: TextStyle(color: AppColor.secondary),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  subtitle: const Text(
                      'Increase your wallet limit to RM4,999 and unlock additional features.'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey.shade300),
              // const SizedBox(
              //   height: 5,
              // ),
              // GestureDetector(
              //   // onTap: () {
              //   //   Get.toNamed(Wallet.route, arguments: 'Premium');
              //   // },
              //   child: ListTile(
              //     title: Text('Premium',
              //         style: TextStyle(color: AppColor.secondary)),
              //     trailing: const Icon(Icons.arrow_forward_ios),
              //     subtitle: const Text(
              //         'Go premium and apply for Visa prepaid card which increases your wallet limit to RM10,000'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class MenuBox extends StatelessWidget {
  const MenuBox({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              height: 40,
              width: 40,
              child: Image.asset(icon),
            ),
            AutoSizeText(
              title,
              style: const TextStyle(fontSize: 8.5),
              maxLines: 1,
              minFontSize: 6,
            ),
          ],
        ),
      ),
    );
  }
}

class GreetingUser extends StatelessWidget {
  const GreetingUser({
    Key? key,
    required this.name,
    required this.controller,
    required this.fullName,
  }) : super(key: key);

  final String name;
  final String fullName;
  final HomeMyController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      leading: Container(
        alignment: Alignment.center,
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: controller.isLoading.isTrue
            ? Text(
                name[0],
                // name[0] ,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              )
            : Text(
                name[0],
                // name[0] ,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Text(
                  '${LocaleKeys.home_page_greet_text.tr}, $fullName',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => controller.isLoading.value
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[400]!.withOpacity(0.5),
                    highlightColor: Colors.grey[100]!.withOpacity(0.5),
                    child: Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  )
                : Row(
                    children: <Widget>[
                      controller.walletId == null
                          ? Text(
                              statusKyc(EKYCStatus.NotVerify),
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            )
                          : Text(
                              statusKyc(controller
                                  .getSSWalletCardModelVO!
                                  .userProfileVO!
                                  .walletProfileList![0]
                                  .eKYCStatus!),
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                      const SizedBox(width: 6),
                      Icon(
                        icon(controller.status!.value),
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
          )
        ],
      ),
      // trailing: IconButton(
      //   icon: const Icon(
      //     Icons.notifications,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      //   onPressed: () {
      //     // Navigator.push(
      //     //     context,
      //     //     CupertinoPageRoute(
      //     //         builder: (context) =>
      //     //             // NotificationsPage()
      //     //             // ScanAndPayPage()
      //     //             WalletSelectionPage()));
      //   },
      // ),
      // UserConst.kycStatus == 3 ||
      //         UserConst.kycStatus ==
      //             4
      //     ? _verificationStatus(
      //         status: tr(
      //             "home_page.verified_text"),
      //         icon: Icons
      //             .verified_user)
      //     : UserConst.kycStatus ==
      //             10
      //         ? _verificationStatus(
      //             status: tr(
      //                 "home_page.pending_verified_text"),
      //             icon:
      //                 Icons.pending)
      //         : _verificationStatus(
      //             status: tr(
      //                 "home_page.not_verified_text"),
      //             icon:
      //                 Icons.cancel,
      //           ),
    );
  }
}

String status(String kycStatus) {
  switch (kycStatus) {
    case "NOT_VERIFIED":
      return LocaleKeys.home_page_not_verified_text.tr;
    case "PENDING":
      return LocaleKeys.home_page_pending_verified_text.tr;
    case "REJECTED":
      return LocaleKeys.home_page_rejected_verified_text.tr;
    case "VERIFIED":
      return LocaleKeys.home_page_verified_text.tr;
  }
  return "Null";
}

String statusKyc(EKYCStatus status) {
  switch (status) {
    case EKYCStatus.AdminRejected:
      return LocaleKeys.home_page_rejected_verified_text.tr;

    case EKYCStatus.AdminRejectedAdvance:
      return LocaleKeys.home_page_rejected_verified_text.tr;

    case EKYCStatus.AdminRejectedPremium:
      return LocaleKeys.home_page_rejected_verified_text.tr;

    case EKYCStatus.AdminVerified:
      return LocaleKeys.home_page_verified_text.tr;

    case EKYCStatus.NotVerify:
      return LocaleKeys.home_page_not_verified_text.tr;

    case EKYCStatus.Verified:
      return LocaleKeys.home_page_verified_text.tr;

    case EKYCStatus.Failed:
      return LocaleKeys.home_page_not_verified_text.tr;

    case EKYCStatus.Pending:
      return LocaleKeys.home_page_pending_verified_text.tr;

    default:
  }

  return "null";
}

IconData icon(String kycStatus) {
  switch (kycStatus) {
    case "NOT_VERIFIED":
      return Icons.cancel;
    case "PENDING":
      return Icons.pending;
    case "REJECTED":
      return Icons.cancel;
    case "VERIFIED":
      return Icons.verified_user;
  }
  return Icons.verified;
}
