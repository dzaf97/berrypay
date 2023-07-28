import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    Key? key,
    required this.animatedCircle,
    this.top,
    this.left,
    this.right,
    this.bottom,
  }) : super(key: key);

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final RxDouble animatedCircle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(seconds: 4),
          width: animatedCircle.value,
          height: animatedCircle.value,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(300),
          ),
        ),
      ),
    );
  }
}
