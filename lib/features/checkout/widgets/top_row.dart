import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/icon_container.dart';

class TopRow extends StatelessWidget {
  const TopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            IconContainer(
              icon: SvgPicture.asset(
                'assets/icons/back_arrow.svg',
                color: Colors.grey.shade500,
              ),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              'Checkout',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
