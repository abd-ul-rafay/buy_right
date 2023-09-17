import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../../utils/constants.dart';

class BottomBar extends StatelessWidget {
  final int selectedTab;
  final void Function(int) onTap;

  const BottomBar({
    Key? key,
    required this.selectedTab,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserProvider>(context).user;
    const size = 30.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedTab,
          backgroundColor: Colors.grey.shade800,
          elevation: 0.0,
          onTap: onTap,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: size,
                height: size,
                color: selectedTab == 0
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
              label: '',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                providerUser.type == ADMIN
                    ? 'assets/icons/manage.svg'
                    : 'assets/icons/orders.svg',
                width: size,
                height: size,
                color: selectedTab == 1
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
              label: '',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: providerUser.type == ADMIN
                  ? SvgPicture.asset(
                      'assets/icons/earnings.svg',
                      width: size,
                      height: size,
                      color: selectedTab == 2
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    )
                  : badges.Badge(
                      position: badges.BadgePosition.topEnd(),
                      showBadge: providerUser.cart.isEmpty ? false : true,
                      badgeAnimation: const badges.BadgeAnimation.scale(
                        curve: Curves.bounceIn,
                        animationDuration: Duration(milliseconds: 1000),
                      ),
                      badgeContent: Text(
                        providerUser.cart.length.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/cart.svg',
                        width: size,
                        height: size,
                        color: selectedTab == 2
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
              label: '',
              backgroundColor: Colors.grey.shade800,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/person.svg',
                width: size,
                height: size,
                color: selectedTab == 3
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
              label: '',
              backgroundColor: Colors.grey.shade800,
            ),
          ],
        ),
      ),
    );
  }
}
