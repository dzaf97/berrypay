import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFFE3242B);
  static Color secondary = Colors.blue[800]!;
  static const Color background = Colors.white;
  static const Color briPrimary = Color(0xFF00529C);
  static const Color briSecondary = Color(0xFFF27224);
  static const Color permataPrimary = Color(0xFF149740);
  static const Color permataSecondary = Color(0xFF0049A3);
  static const Color malaysiaPrimary = Color(0xFF81D4F4);
  static const Color malaysiaSecondary = Color(0xFF4F61F5);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

MaterialColor _appSwatch = MaterialColor(AppColor.primary.value, {
  50: AppColor.primary.withOpacity(.1),
  100: AppColor.primary.withOpacity(.2),
  200: AppColor.primary.withOpacity(.3),
  300: AppColor.primary.withOpacity(.4),
  400: AppColor.primary.withOpacity(.5),
  500: AppColor.primary.withOpacity(.6),
  600: AppColor.primary.withOpacity(.7),
  700: AppColor.primary.withOpacity(.8),
  800: AppColor.primary.withOpacity(.9),
  900: AppColor.primary.withOpacity(1),
});

ThemeData primaryTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: _appSwatch),
  scaffoldBackgroundColor: AppColor.background,
  primarySwatch: _appSwatch,
  bottomAppBarColor: _appSwatch,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.primary,
    foregroundColor: Colors.white,
  ),
);

class AppStyle {
  TextStyle pageHeading = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  TextStyle title = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    color: Color(0xff686777),
  );

  TextStyle menuTitle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.white,
  );
  TextStyle formTitle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  TextStyle formSubTitle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  TextStyle datePickerDate = const TextStyle(
    fontSize: 16,
  );

  TextStyle button = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  TextStyle detailTitle = const TextStyle(
    color: Color(0xFF686777),
  );
}

AppStyle styles = AppStyle();
