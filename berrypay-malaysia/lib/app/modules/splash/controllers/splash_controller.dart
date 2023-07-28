import 'dart:async';
import 'dart:io';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/secure_storage.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/main.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:store_checker/store_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AuthRepo authRepo;
  SplashController(this.authRepo);

  late AnimationController ac;
  late Animation<double> animation;
  RxBool isForceUpdate = false.obs;
  RxString isLoggedIn = 'false'.obs;
  final SecureStorage secureStorage = SecureStorage();
  // BuildContext? context;

  var jailBroken = false;

  @override
  void onInit() async {
    ac = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: ac, curve: Curves.easeIn);
    ac.forward();

    if (GetPlatform.isAndroid) {
      // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_BLUR_BEHIND);
    }
    await initJailbreakCheck();
    await checkVersion();
    // await checkConnection();
    fetchSecureStorageData();
    routeSplash();
    // Get.updateLocale(const Locale('en', 'US'));

    logger(
        Get.find<StorageProvider>().getLanguage()?.language ?? null.toString());
    if (Get.find<StorageProvider>().getLanguage() == null) {
      Get.updateLocale(Get.deviceLocale!);
    } else {
      Get.updateLocale(Locale(
          Get.find<StorageProvider>().getLanguage()!.language,
          Get.find<StorageProvider>().getLanguage()!.countryCode));
    }

    super.onInit();
  }

  Future<void> initJailbreakCheck() async {
    try {
      jailBroken = await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      jailBroken = true;
    }

    if (!jailBroken) {
      await authRepo.initFpSdk();
    }

    // if (AppConst.baseApi == AppConst.stagingApi) {
    //   jailBroken = false;
    // }
  }

  Future<void> fetchSecureStorageData() async {
    isLoggedIn.value = await secureStorage.getIslogin() ?? 'false';

    logger(isLoggedIn.value);
  }

  Future<void> checkConnection() async {
    logger('masuk checkConnection');
    final connectionStatus = await ConnectivityWrapper.instance.isConnected;

    if (connectionStatus != true) {
      return Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: const Text("Internet"),
            content: const Text("No internet connection"),
            actions: [
              CupertinoDialogAction(
                onPressed: () async {},
                isDefaultAction: true,
                child: const Text("Okay", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> checkVersion() async {
    String clientOs = '';
    // If iOS, set clientOs to iOS
    if (Platform.isIOS) {
      clientOs = 'iOS';
    } else if (Platform.isAndroid) {
      // Check if Huawei device
      int isHuaweiDevice = await HmsApiAvailability().isHMSAvailable();

      // If Huawei device, check if Google Play Store is available
      if (isHuaweiDevice == 0) {
        // If check installation is from Huawei App Gallery, set clientOs to HarmonyOS
        Source installationSource = await StoreChecker.getSource;
        logger('installationSource: $installationSource');
        if (installationSource == Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY) {
          clientOs = 'HarmonyOS';
        } else {
          clientOs = 'AndroidOS';
        }
        // If not Huawei device, set clientOs to AndroidOS
      } else {
        clientOs = 'AndroidOS';
      }
    }
    final response = await authRepo.getVersion(clientOs);

    if (verifyResponse(response)) {
      return;
    }

    Version version = response;
    String currentVersion = "";

    if (version.data?.majorVersion != null &&
        version.data?.minorVersion != null &&
        version.data?.patchVersion != null) {
      currentVersion =
          "${version.data?.majorVersion}.${version.data?.minorVersion}.${version.data?.patchVersion}";

      logger('appVersion: $appVersion - currentVersion $currentVersion',
          name: 'SplashController-checkVersion');

      isForceUpdate(version.data?.isForceUpdate ?? false);

      int now = int.parse(
        "${appVersion.split(".").first}${appVersion.split(".")[1]}${appVersion.split(".").last}",
      );

      int latest = int.parse(
        "${version.data?.majorVersion}${version.data?.minorVersion}${version.data?.patchVersion}",
      );

      if (now < latest) {
        logger("UPDATEE 2");
        isForceUpdate.value
            ? await Get.dialog(
                barrierDismissible: false,
                WillPopScope(
                  onWillPop: () async => false,
                  child: CupertinoAlertDialog(
                    title: const Text("Update Available"),
                    content: Text(
                        "Please update your app to continue.\n\nYour version: $appVersion\nLatest version: $currentVersion"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () async => updateVersion(),
                        isDefaultAction: true,
                        child: const Text("Update",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
              )
            : await Get.dialog(
                CupertinoAlertDialog(
                  title: const Text("Update Available"),
                  content: Text(
                      "Please update your app to continue.\n\nYour version: $appVersion\nLatest version: $currentVersion"),
                  actions: [
                    CupertinoDialogAction(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel")),
                    CupertinoDialogAction(
                      onPressed: () async => updateVersion(),
                      isDefaultAction: true,
                      child: const Text("Update",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              );
      }
    }
  }

  Future<void> updateVersion() async {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(
          "https://apps.apple.com/my/app/berrypay-malaysia/id1673687496"));
    } else if (Platform.isAndroid) {
      // Check if Huawei device
      int isHuaweiDevice = await HmsApiAvailability().isHMSAvailable();

      // If Huawei device, check if Google Play Store is available
      if (isHuaweiDevice == 0) {
        // If check installation is from Huawei App Gallery, launch Huawei App Gallery
        Source installationSource = await StoreChecker.getSource;
        if (installationSource == Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY) {
          await launchUrl(
              Uri.parse("https://appgallery.huawei.com/app/C108554575"),
              mode: LaunchMode.externalNonBrowserApplication);
        } else {
          // Else, launch Google Play Store
          await launchUrl(
            Uri.parse(
                "https://play.google.com/store/apps/details?id=com.berrypay.malaysia"),
            mode: LaunchMode.externalNonBrowserApplication,
          );
        }
      } else {
        await launchUrl(
          Uri.parse(
              "https://play.google.com/store/apps/details?id=com.berrypay.malaysia"),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      }
    }
  }

  routeSplash() {
    Timer(const Duration(seconds: 2), () {
      if (!jailBroken) {
        isLoggedIn.value == 'true'
            ? Get.toNamed(Routes.LOGIN_SECOND, arguments: jailBroken)
            : Get.toNamed(Routes.WELCOME, arguments: jailBroken);
      }
    });
  }
}
