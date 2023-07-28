import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppButton2 extends StatelessWidget {
  AppButton2({
    Key? key,
    required this.onPressed,
    required this.title,
    this.contentPadding,
    this.color,
    this.width,
  }) : super(key: key);

  final Function onPressed;
  final String title;
  EdgeInsets? contentPadding;
  Color? color = AppColor.primary;
  double? width = Get.width * 0.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(contentPadding ?? const EdgeInsets.symmetric(vertical: 13)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: AppStyle().button,
        ),
      ),
    );
  }
}
