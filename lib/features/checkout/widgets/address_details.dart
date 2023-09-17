import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AddressDetails extends StatelessWidget {
  final TextEditingController addressTextController;

  const AddressDetails({Key? key, required this.addressTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserProvider>(context).user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          providerUser.name,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Visibility(
          visible: providerUser.address.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Text(providerUser.address),
              const SizedBox(
                height: 10.0,
              ),
              const Text('OR'),
            ],
          ),
        ),
        TextField(
          controller: addressTextController,
          style: const TextStyle(fontSize: 14.0),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Add a new address...',
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
