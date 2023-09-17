import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../common/icon_container.dart';
import '../../utils/constants.dart';
import '../dashboard/dashboard_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void handleLogoutButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 18.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              DashboardServices.logout(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserProvider>(context).user;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Profile',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconContainer(
                    icon: SvgPicture.asset(
                      'assets/icons/settings.svg',
                      color: Colors.grey[400],
                    ),
                    padding: 5.0,
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.grey.shade800,
                    size: 35.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    providerUser.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                'ID: ${providerUser.id}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Email: ${providerUser.email}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    'User Type: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    providerUser.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: providerUser.type == ADMIN
                          ? Colors.green.shade700
                          : Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              if (providerUser.type == ADMIN) ...[
                const SizedBox(height: 5.0),
                Text(
                  'You are admin and you have access to add products, view and manage orders, and view business analytics',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ]
              else ...[
                const SizedBox(height: 5.0),
                Text(
                  'Address: ${providerUser.address.isEmpty ? 'You can set it once you place your first order' : providerUser.address}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'Items in cart: ${providerUser.cart.length}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
              const SizedBox(height: 10.0),
              Divider(thickness: 1, color: Colors.grey.shade300),
              const SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: () => handleLogoutButton(context),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: Text('About app'),
                    leading: Icon(Icons.info_outline),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: Text('Privacy policy'),
                    leading: Icon(Icons.privacy_tip_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
