import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const CustomIconBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: icon,
      ),
      onPressed: onPressed,
    );
  }
}
