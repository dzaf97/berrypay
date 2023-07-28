import 'package:flutter/material.dart';

class ColumnSubtitle extends StatelessWidget {
  const ColumnSubtitle({
    super.key,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle3,
    this.subtitle4,
  });
  final String subtitle1;
  final String subtitle2;
  final String subtitle3;
  final String? subtitle4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle1,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500, color: Colors.grey.shade800),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle2,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500, color: Colors.grey.shade800),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle3,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500, color: Colors.grey.shade800),
        ),
        const SizedBox(
          height: 10,
        ),
        subtitle4 != null
            ? Text(
                subtitle4!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade800),
              )
            : const SizedBox(),
      ],
    );
  }
}
