import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesContainer extends StatefulWidget {
  final double height;
  final List<String> images;

  const ImagesContainer({
    Key? key,
    required this.height,
    required this.images,
  }) : super(key: key);

  @override
  State<ImagesContainer> createState() => _ImagesContainerState();
}

class _ImagesContainerState extends State<ImagesContainer> {
  int _activeIndex = 0;

  void _updateActiveIndex(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey.shade200,
          child: CarouselSlider(
            items: widget.images.map((image) => Image.network(image)).toList(),
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: 1,
              autoPlay: widget.images.length > 1,
              autoPlayInterval: const Duration(milliseconds: 5000),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: widget.images.length > 1,
              onPageChanged: (index, _) => _updateActiveIndex(index),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: AnimatedSmoothIndicator(
            activeIndex: _activeIndex,
            count: widget.images.length,
            onDotClicked: _updateActiveIndex,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.grey.shade800,
              dotWidth: 10.0,
              dotHeight: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}
