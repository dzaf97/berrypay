import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: ConnectivityWidgetWrapper(
        alignment: Alignment.bottomCenter,
        disableInteraction: true,
        offlineWidget: Container(
            color: AppColor.white,
            width: double.infinity,
            height: 30,
            child: const Center(
                child: Text(
              'No internet connection',
              style: TextStyle(color: Colors.red),
            ))),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: const Alignment(5.0, 1.0),
                    colors: [const Color(0xFFE3242B), Colors.blue[800]!],
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: FadeTransition(
                    opacity: controller.animation,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: 150,
                      height: 150,
                      child: Hero(
                        tag: "logo",
                        child: Image.asset("assets/images/bp_logo_white.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
