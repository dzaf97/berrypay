/*
 * Copyright (c) 2020 .
 */

import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.isRequired = true,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.divider,
    this.style,
    this.textAlign,
    this.suffix,
    this.controller,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.focusNode,
    this.readOnly,
    this.ontap,
    this.regex,
    this.topHint,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  // final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final String? topHint;
  final bool isRequired;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final bool? divider;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? maxLength;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool? readOnly;
  final Function()? ontap;
  final String? regex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      // margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
          color: enabled ?? true ? Colors.white : Colors.grey.shade300,
          // color: enabled ?? true ? Colors.white : Colors.grey.shade200,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Colors.grey.shade200.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                labelText ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 15),
                textAlign: textAlign ?? TextAlign.start,
              ),
              const SizedBox(
                width: 5,
              ),
              isRequired
                  ? Text(
                      '*',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.red),
                      textAlign: textAlign ?? TextAlign.start,
                    )
                  : Container(),
              const SizedBox(
                width: 5,
              ),
              topHint != null
                  ? Text(
                      topHint ?? "",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: textAlign ?? TextAlign.start,
                    )
                  : Container()
            ],
          ),
          divider == true
              ? const Divider(
                  height: 26,
                  thickness: 1.2,
                )
              : Container(),
          TextFormField(
            onTap: ontap,
            readOnly: readOnly ?? false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: textInputAction ?? TextInputAction.done,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
              FilteringTextInputFormatter.allow(RegExp(regex ?? '[^]'))
            ],
            maxLines: keyboardType == TextInputType.multiline ? null : 1,
            // decoration: const InputDecoration(focusColor: AppTheme.lightGrey),
            key: key,
            keyboardType: keyboardType ?? TextInputType.text,
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
            // initialValue: initialValue ?? '',
            controller: controller,
            enabled: enabled ?? true,
            style: style ??
                Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColor.black),
            obscureText: obscureText ?? false,
            textAlign: textAlign ?? TextAlign.start,
            decoration: InputDecoration(
                errorMaxLines: 2,
                border: InputBorder.none,
                hintText: hintText ?? '',
                icon: (iconData != null) ? Icon(iconData) : null,
                suffixIcon: suffixIcon,
                suffix: suffix,
                errorText: errorText,
                filled: true,
                fillColor:
                    enabled ?? true ? Colors.white : Colors.grey.shade300,
                hintStyle: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst!) {
      return const BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast!) {
      return const BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst! && isLast != null && !isLast!) {
      return const BorderRadius.all(Radius.circular(0));
    }
    return const BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst!)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast!)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
