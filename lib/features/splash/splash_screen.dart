import 'package:buy_right/features/dashboard/dashboard_screen.dart';
import 'package:buy_right/features/splash/splash_services.dart';
import 'package:buy_right/features/splash/widgets/shimmer_loading.dart';
import 'package:buy_right/features/splash/widgets/went_wrong.dart';
import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  bool _responseSuccess = false;

  void getUser() async {
    _responseSuccess = await SplashServices.getUser(context, mounted);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(body: ShimmerLoading())
        : Provider.of<UserProvider>(context).user.id.isEmpty
            ? _responseSuccess
                ? const AuthScreen()
                : const Scaffold(body: WentWrong())
            : const DashboardScreen();
  }
}
