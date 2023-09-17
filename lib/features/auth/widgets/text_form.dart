import 'package:flutter/material.dart';

import '../../../common/custom_button.dart';
import '../../../common/custom_text_field.dart';

class TextForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoginState;
  final bool isLoading;
  final TextEditingController nameTextController;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController confirmPassTextController;
  final VoidCallback handleButtonOnPressed;

  const TextForm({
    Key? key,
    required this.formKey,
    required this.isLoginState,
    required this.isLoading,
    required this.nameTextController,
    required this.emailTextController,
    required this.passwordTextController,
    required this.confirmPassTextController,
    required this.handleButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // if it is register, then show name field also
          if (!isLoginState) ...[
            CustomTextField(
              controller: nameTextController,
              label: 'Name',
              textInputType: TextInputType.name,
              iconData: Icons.person,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
          CustomTextField(
            controller: emailTextController,
            label: 'Email',
            textInputType: TextInputType.emailAddress,
            iconData: Icons.email,
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomTextField(
            controller: passwordTextController,
            label: 'Password',
            textInputType: TextInputType.visiblePassword,
            iconData: Icons.lock,
            obscure: true,
          ),
          // if it is register, then show confirm password field also
          if (!isLoginState) ...[
            const SizedBox(
              height: 10.0,
            ),
            CustomTextField(
              controller: confirmPassTextController,
              label: 'Confirm Password',
              textInputType: TextInputType.visiblePassword,
              iconData: Icons.verified_user,
              obscure: true,
            ),
          ],
          const SizedBox(
            height: 10.0,
          ),
          CustomButton(
            onPressed: handleButtonOnPressed,
            text: isLoginState ? 'Login' : 'Register',
            isLoading: isLoading,
            loadingText: isLoginState ? 'Logging in...' : 'Registering...',
          )
        ],
      ),
    );
  }
}
