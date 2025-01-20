import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handman/core/assets/app_vectors.dart';
import 'package:handman/core/helper/app_navigator.dart';
import 'package:handman/presentation/auth/pages/singup.dart';
import 'package:handman/presentation/home/pages/home.dart';
import 'package:handman/service/auth_local_service.dart';
import 'package:handman/service_locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthState();
  }

  Future<void> _navigateBasedOnAuthState() async {
    bool isLoggedIn = await sl<AuthLocalService>().isLoggedIn();

    if (!mounted) return; // Ensure widget is still mounted before using context

    if (isLoggedIn) {
      AppNavigator.pushReplacement(context, HomePage(search: ''));
    } else {
      AppNavigator.pushReplacement(context, SignupPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: SvgPicture.asset(AppVectors.appLogo),
      ),
    );
  }
}
