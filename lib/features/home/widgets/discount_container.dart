import 'package:buy_right/common/custom_button.dart';
import 'package:flutter/material.dart';

class DiscountContainer extends StatelessWidget {
  const DiscountContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: double.infinity,
          height: 225.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200,
            image: const DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1629131726692-1accd0c53ce0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZGV2aWNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
              fit: BoxFit.fitWidth,
              // alignment: Alignment.centerRight,
            ),
          ),
        ),
        Positioned(
          left: 15.0,
          bottom: 15.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discounts',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 150.0,
                child: CustomButton(
                  onPressed: () {},
                  text: 'See More',
                  isLoading: false,
                  loadingText: '',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 15.0,
          right: 15.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              '25%',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
