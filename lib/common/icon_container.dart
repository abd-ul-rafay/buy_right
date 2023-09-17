import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final Widget icon;
  final double? padding;
  final VoidCallback? onTap;

  const IconContainer({
    Key? key,
    required this.icon,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(4.0),
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0.0),
          child: icon,
        ),
      ),
    );
  }
}
