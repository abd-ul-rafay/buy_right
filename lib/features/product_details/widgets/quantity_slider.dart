import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class QuantitySlider extends StatelessWidget {
  final int quantity;
  final int sliderValue;
  final Function(double) setSliderValue;

  const QuantitySlider({
    Key? key,
    required this.quantity,
    required this.sliderValue,
    required this.setSliderValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfSlider(
      min: 1.0,
      max: quantity < 99 ? quantity : 99,
      value: sliderValue,
      onChanged: (value) => setSliderValue(value),
      activeColor: Colors.grey.shade800,
      interval: 1,
      stepSize: 1,
      enableTooltip: true,
      thumbIcon: Center(
        child: Text(
          '$sliderValue',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
