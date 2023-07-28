import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final String title;
  final GestureTapCallback? route;

  const AppAppBar({
    super.key,
    this.showBack = true,
    required this.title,
    this.route,
  });

  @override
  Size get preferredSize => Size.fromHeight(preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold
        ),
      ),
      leading: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: IconButton(
          onPressed: route ?? () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      )
    );
  }
}

