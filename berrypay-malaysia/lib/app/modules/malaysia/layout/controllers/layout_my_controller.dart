import 'package:berrypay_global_x/app/core/utils/functions/notification.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/secure_storage.dart';
import 'package:berrypay_global_x/app/data/model/bpg/user_profile.dart';
import 'package:berrypay_global_x/app/data/model/locale_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/profile_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/transaction_repo.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/home_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/profile_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/controllers/transaction_my_controller.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/views/home_my_view.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/views/profile_my_view.dart';
import 'package:berrypay_global_x/app/modules/malaysia/layout/views/transaction_my_view.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutMyController extends GetxController
    with GetTickerProviderStateMixin {
  ProfileInfoResponse? profileInfo;
  final AuthRepo authRepo;
  LayoutMyController(this.authRepo);

  SecureStorage secureStorage = SecureStorage();

  List<Widget> pages = const [
    HomeMyView(),
    TransactionMyView(),
    ProfileMyView()
  ];
  List<Widget> tabs = [
    Tab(icon: Image.asset("assets/icons/home.png", width: 20)),
    Tab(icon: Image.asset("assets/icons/history.png", width: 20)),
    Tab(icon: Image.asset("assets/icons/profile.png", width: 20)),
  ];
  List<String> titles = [
    "assets/images/logo.png",
    LocaleKeys.tabs_transaction_text.tr,
    LocaleKeys.transaction_page_account_text.tr,
  ];

  late TabController tabController;

  var selectedTab = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: pages.length, vsync: this);

    super.onInit();
  }

  void handleMyTab(int value) {
    selectedTab(value);
    switch (value) {
      case 0:
        Get.replace(HomeMyController(AuthRepo(), ProfileRepo()));
        break;
      case 1:
        Get.replace(TransactionMyController(
            ProfileRepo(), TransactionRepo(), RemittanceRepo()));
        break;
      case 2:
        Get.replace(ProfileMyController(AuthRepo(), ProfileRepo()));
        break;
    }
  }

  signOut() async {
    String? walletId = Get.find<StorageProvider>().getFasspayWalletId() ?? '';

    if (walletId.isNotEmpty) {
      await authRepo.logoutFp(walletId);
    }
    Get.offNamedUntil(Routes.WELCOME, ModalRoute.withName(Routes.WELCOME),
        arguments: false);

    var locale = Locale(
      Get.find<StorageProvider>().getLanguage()!.language,
      Get.find<StorageProvider>().getLanguage()!.countryCode,
    );
    Get.find<StorageProvider>().box.erase();
    await secureStorage.deleteAll();
    await NotificationService().removeFcmToken();
    Get.updateLocale(locale);
    Get.find<StorageProvider>().setLanguage(
      LocaleModel(
        language: locale.languageCode,
        countryCode: locale.countryCode!,
      ),
    );
    // if (Storage.getProfileInfoResponse()!.wallet != null) {
    //   logger("Masul");
    //   FasspayBase response = await fasspay.performLogout(Storage.getProfileInfoResponse()!.wallet.my!);
    //   if (response.isSuccess) {
    //     logger(jsonEncode(response.payload!));
    //   } else {
    //     logger(response.errorMessage!);
    //   }
    // }
    // Get.offAllNamed(Login.route);
  }
}
