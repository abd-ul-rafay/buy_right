import 'package:buy_right/providers/user_provider.dart';
import 'package:buy_right/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../common/icon_container.dart';
import '../../add_product/add_product_screen.dart';

class TopRow extends StatelessWidget {
  const TopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserProvider>(context).user;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconContainer(
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                color: Colors.grey[400],
              ),
              padding: 3.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Cart to Doorstep, Seamless',
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconContainer(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.grey[400],
              ),
              padding: 3.5,
              onTap: () {},
            ),
            const SizedBox(
              width: 10.0,
            ),
            if (providerUser.type == ADMIN)
              IconContainer(
                icon: SvgPicture.asset(
                  'assets/icons/add.svg',
                  color: Colors.grey[400],
                ),
                padding: 1.5,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                ),
              )
            else
              IconContainer(
                icon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  color: Colors.grey[400],
                ),
                onTap: () {}
              ),
          ],
        ),
      ],
    );
  }
}
