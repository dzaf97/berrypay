import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  const TextInfo(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.titleSize,
      this.subtitleSize,
      this.titleColor,
      this.subtitleColor})
      : super(key: key);

  final String title;
  final String subtitle;
  final double? titleSize;
  final double? subtitleSize;
  final Color? titleColor;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: titleColor ?? Colors.grey, fontSize: titleSize ?? 12),
        ),
        Text(
          subtitle,
          style: TextStyle(
              color: subtitleColor ?? Colors.black,
              fontSize: subtitleSize ?? 15),
        ),
      ],
    );
  }
}
