import 'package:flutter/material.dart';

class WentWrong extends StatelessWidget {
  const WentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            ':(',
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Something went wrong, please try again later.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
