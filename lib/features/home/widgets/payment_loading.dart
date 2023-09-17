import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaymentLoading extends StatelessWidget {
  const PaymentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 110.0,
            height: 14.0,
            color: Colors.white,
          ),
          Container(
            width: 60.0,
            height: 14.0,
            color: Colors.white,
          ),
        ],
      )
    );
  }
}
