import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingBalanceBox extends StatelessWidget {
  const ShimmerLoadingBalanceBox({super.key, required this.mainAxisAlignment, required this.crossAxisAlignment});

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!.withOpacity(0.5),
          highlightColor: Colors.grey[100]!.withOpacity(0.5),
          child: Container(
            width: 100,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!.withOpacity(0.5),
          highlightColor: Colors.grey[100]!.withOpacity(0.5),
          child: Container(
            width: 150,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

// Normal shimmer
class ShimmerSingle extends StatelessWidget {
  const ShimmerSingle({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.height = 10,
    this.width = 100,
  }) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!.withOpacity(0.5),
          highlightColor: Colors.grey[100]!.withOpacity(0.5),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

// Shimmer with box
class TransactionShimmerBox extends StatelessWidget {
  const TransactionShimmerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 5.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Row(
                children: const [
                  ShimmerSingle(height: 45, width: 45),
                  SizedBox(width: 30),
                  ShimmerSingle(height: 20, width: 200),
                ],
              )
            ),
          )
        ]
      )
    );
  }
}

// Shimmer for billers
class BillersShimmerBox extends StatelessWidget {
  const BillersShimmerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerLoadingBalanceBox(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        SizedBox(height: 50),

        ShimmerLoadingBalanceBox(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        SizedBox(height: 50),

      ],
    );
  }
}

