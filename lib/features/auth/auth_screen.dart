import 'package:buy_right/features/auth/auth_services.dart';
import 'package:buy_right/features/auth/widgets/text_form.dart';
import 'package:flutter/material.dart';

import '../../utils/functions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();

  bool _isLoading = false;
  bool _isLoginState = true;

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void handleButtonOnPressed() async {
    if (_formKey.currentState!.validate()) {
      if (!_isLoginState && _passwordTextController.text != _confirmPassTextController.text) {
        return showSnackBar(context, 'Password does not match the confirm password');
      }

      FocusScope.of(context).unfocus();
      bool isSuccess = false;

      setState(() {
        _isLoading = true;
      });

      if (_isLoginState) {
        isSuccess = await AuthServices.login(
          context,
          _emailTextController.text,
          _passwordTextController.text,
          mounted,
        );
      } else {
        isSuccess = await AuthServices.register(
          context,
          _nameTextController.text,
          _emailTextController.text,
          _passwordTextController.text,
          mounted,
        );
      }

      if (!isSuccess) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BuyRight',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(_isLoginState
                    ? 'Sign in to continue'
                    : 'Create new account'),
                const SizedBox(
                  height: 25.0,
                ),
                TextForm(
                  formKey: _formKey,
                  isLoginState: _isLoginState,
                  isLoading: _isLoading,
                  nameTextController: _nameTextController,
                  emailTextController: _emailTextController,
                  passwordTextController: _passwordTextController,
                  confirmPassTextController: _confirmPassTextController,
                  handleButtonOnPressed: handleButtonOnPressed,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoginState = !_isLoginState;
                    });
                  },
                  child: Text(_isLoginState
                      ? 'Do not have an account? Register'
                      : 'Already have an account? Login',
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
