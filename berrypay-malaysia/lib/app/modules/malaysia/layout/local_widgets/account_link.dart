import 'package:flutter/material.dart';

class AccountLinkWidget extends StatelessWidget {
  final Icon icon;
  final Widget text;
  final Function()? onTap;

  const AccountLinkWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            icon,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: 1,
              height: 24,
              color: Colors.grey.withOpacity(0.3),
            ),
            Expanded(
              child: text,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
