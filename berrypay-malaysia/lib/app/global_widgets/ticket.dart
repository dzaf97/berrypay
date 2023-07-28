import 'package:berrypay_global_x/app/global_widgets/seperator.dart';
import 'package:flutter/material.dart';

class TicketWidget {
  /// To get optimum line that align with the circle,
  /// Please use `topFlex = 1, bottomFlex = 1, circlePosition = 2`
  /// or `topFlex = 2, bottomFlex = 1, circlePosition = 1.5`
  static Widget main(
      {required BuildContext context,
      required Widget topChild,
      required Widget bottomChild,
      int topFlex = 1,
      int bottomFlex = 1,
      double? height,
      double? width,
      Color color = Colors.white,
      Color separatorColor = Colors.black,
      double separatorHeight = 1,
      bool hasSeparator = true,
      bool isCornerRounded = false,
      double circlePosition = 2,
      double circleRadius = 16,
      double? borderRadius}) {
    Radius radius = isCornerRounded ? Radius.circular(borderRadius ?? circleRadius) : const Radius.circular(0.0);
    return ClipPath(
      clipper: TicketClipper(circlePosition: circlePosition, circleRadius: circleRadius),
      child: Container(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: topFlex,
                child: Container(
                    child: topChild,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    )))),
            hasSeparator ? AppSeparator.main(context: context, color: separatorColor, height: separatorHeight) : Container(),
            Expanded(
                flex: bottomFlex,
                child: Container(
                    child: bottomChild,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      bottomLeft: radius,
                      bottomRight: radius,
                    )))),
          ],
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: isCornerRounded ? BorderRadius.circular(borderRadius ?? circleRadius) : BorderRadius.circular(0.0)),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double circlePosition;
  final double circleRadius;
  final bool isRow;

  TicketClipper({this.circlePosition = 2, this.circleRadius = 20, this.isRow = false});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    if (isRow) {
      path.addOval(Rect.fromCircle(center: Offset(size.width / circlePosition, 0.0), radius: circleRadius));
      path.addOval(Rect.fromCircle(center: Offset(size.width / circlePosition, size.height), radius: circleRadius));
      // path.a
    } else {
      path.addOval(Rect.fromCircle(center: Offset(0.0, size.height / circlePosition), radius: circleRadius));
      path.addOval(Rect.fromCircle(center: Offset(size.width, size.height / circlePosition), radius: circleRadius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
