import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 2.0,
              ),
              Container(
                width: size.width * 0.65,
                height: 16.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Container(
                width: 140.0,
                height: 10.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Container(
                width: 135.0,
                height: 12.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Container(
                width: size.width * 0.8,
                height: 12.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 90.0,
                  height: 12.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
