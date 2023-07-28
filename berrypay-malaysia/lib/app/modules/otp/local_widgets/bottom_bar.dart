import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AppButton.rectangle(title: 'Verify', onTap: onTap),
    );
  }
}
