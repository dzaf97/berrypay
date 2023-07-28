import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedGlass extends StatefulWidget {
  final double height, width;
  final Widget child;
  final Color beginColor, endColor, borderColor;

  const FrostedGlass({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.beginColor = Colors.white,
    this.endColor = Colors.white,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  _FrostedGlassState createState() => _FrostedGlassState();
}

class _FrostedGlassState extends State<FrostedGlass> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 7.0,
              ),
              child: Container(
                  width: widget.width, height: widget.height, child: Text(" ")),
            ),
            Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/images/noise.png",
                  fit: BoxFit.cover,
                  width: widget.width,
                  height: widget.height,
                )),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: const Offset(2, 2))
                ],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: widget.borderColor.withOpacity(0.2), width: 1.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.beginColor.withOpacity(0.5),
                    widget.endColor.withOpacity(0.2),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Center(
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
