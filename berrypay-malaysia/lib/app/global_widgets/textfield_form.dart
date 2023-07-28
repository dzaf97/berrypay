import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FormTextField extends StatelessWidget {
  FormTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  TextInputType? keyboardType;
  bool? obscureText;
  int? maxLines = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: const TextStyle(color: Color(0xFF686777)),
            ),
          ),
          TextField(
            obscureText: obscureText ?? false,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            maxLines: maxLines,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // hintText: title,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffE2E3E4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
