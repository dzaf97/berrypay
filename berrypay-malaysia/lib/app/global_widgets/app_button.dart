import 'package:flutter/material.dart';

class AppButton {
  // Round button
  static Widget rounded(
      {required Function()? onTap,
      String title = 'OK',
      double height = 55,
      Color? border,
      double? width,
      EdgeInsets padding = const EdgeInsets.all(0.0),
      double? fontSize,
      ButtonType type = ButtonType.primary}) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: getColorByType(type: type).color,
              border:
                  Border.all(color: border ?? Colors.white.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: Text(title,
                  style: TextStyle(
                      color: getColorByType(type: type).textColor,
                      fontSize: fontSize))),
        ),
      ),
    );
  }

  // Rectangle button
  static Widget rectangle(
      {required Function()? onTap,
      String title = 'OK',
      double height = 55,
      double? width,
      EdgeInsets padding = const EdgeInsets.all(0.0),
      double? fontSize,
      ButtonType type = ButtonType.primary}) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: getColorByType(type: type).color,
              border: Border.all(color: Colors.white.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(title,
                  style: TextStyle(
                      color: getColorByType(type: type).textColor,
                      fontSize: fontSize))),
        ),
      ),
    );
  }

  // Border button
  static Widget outlinedBorder(
      {required Function()? onTap,
      String title = 'OK',
      double height = 55,
      double? width,
      EdgeInsets padding = const EdgeInsets.all(0.0),
      double? fontSize,
      ButtonType type = ButtonType.primary}) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: getColorByType(type: type).color),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: Text(title,
                  style: TextStyle(
                      color: getColorByType(type: type).color,
                      fontSize: fontSize))),
        ),
      ),
    );
  }

  // Round Icon button
  static Widget roundedIcon(
      {required Function()? onTap,
      String title = 'OK',
      double height = 55,
      double? width,
      Color? border,
      EdgeInsets padding = const EdgeInsets.all(0.0),
      double? fontSize,
      ButtonType type = ButtonType.primary,
      IconData? icon}) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: getColorByType(type: type).color,
              border:
                  Border.all(color: border ?? Colors.white.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      color: getColorByType(type: type).textColor,
                      fontSize: fontSize)),
              const SizedBox(width: 3),
              Icon(
                icon,
                size: 17,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  static ButtonColor getColorByType({required ButtonType type}) {
    // Color color;
    ButtonColor buttonColor =
        ButtonColor(color: Colors.red, textColor: Colors.white);

    switch (type) {
      case ButtonType.primary:
        buttonColor.color = Colors.red;
        buttonColor.textColor = Colors.white;
        break;
      case ButtonType.secondary:
        buttonColor.color = Colors.white;
        buttonColor.textColor = Colors.red;
        break;
      case ButtonType.success:
        buttonColor.color = Colors.green;
        buttonColor.textColor = Colors.white;
        break;
      case ButtonType.danger:
        buttonColor.color = Colors.red[900]!;
        buttonColor.textColor = Colors.white;
        break;
      case ButtonType.info:
        buttonColor.color = Colors.lightBlue[200]!;
        buttonColor.textColor = Colors.white;
        break;
      case ButtonType.warning:
        buttonColor.color = Colors.amber;
        buttonColor.textColor = Colors.black;
        break;
      case ButtonType.light:
        buttonColor.color = Colors.grey[100]!;
        buttonColor.textColor = Colors.black;
        break;
      case ButtonType.dark:
        buttonColor.color = Colors.black87;
        buttonColor.textColor = Colors.white;
        break;
      case ButtonType.orange:
        buttonColor.color = Colors.orange;
        buttonColor.textColor = Colors.white;
        break;
      default:
        buttonColor.color = Colors.red;
        buttonColor.textColor = Colors.white;
        break;
    }
    return buttonColor;
  }
}

enum ButtonType {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
  orange
}

class ButtonColor {
  Color color;
  Color textColor;

  ButtonColor({required this.color, required this.textColor});
}
