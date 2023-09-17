import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            width: 150.0,
            height: 12.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            width: 50.0,
            height: 12.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
