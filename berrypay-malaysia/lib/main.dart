import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/notification.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_my_provider.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

String appVersion = "";
bool isStaging = false;

// Firebase in background
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  logger("Handling a background message");
}

void main() async {
  // Get.put(LifeCycleController());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: ".env");
  appVersion = dotenv.env["APP_VERSION"]!;
  isStaging = dotenv.env["IS_STAGING"] == "true" ? true : false;
  Get.put(BpgMyProvider());
  Get.put(BpgProvider());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService().initializeNotification();
  runApp(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ConnectivityAppWrapper(
        app: GetMaterialApp(
          translationsKeys: AppTranslation.translations,
          title: "BerryPay Malaysia",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          theme: primaryTheme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}
