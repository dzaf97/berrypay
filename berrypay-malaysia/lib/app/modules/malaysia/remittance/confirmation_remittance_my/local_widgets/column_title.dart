import 'package:flutter/material.dart';

class ColumnTitle extends StatelessWidget {
  const ColumnTitle({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    this.title4,
  });

  final String title1;
  final String title2;
  final String title3;
  final String? title4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title1:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$title2:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$title3:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 10,
        ),
        title4 != null
            ? Text(
                '$title4:',
                style: Theme.of(context).textTheme.bodySmall,
              )
            : const SizedBox(),
      ],
    );
  }
}
