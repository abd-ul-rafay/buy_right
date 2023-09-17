import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final String loadingText;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    required this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          backgroundColor: Colors.grey.shade800,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: Text(
          isLoading ? loadingText : text,
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }
}
