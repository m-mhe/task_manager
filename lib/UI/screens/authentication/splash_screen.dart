import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/authentication/sign_in_screen.dart';
import 'package:task_manager/UI/utility/assets_path.dart';
import 'package:task_manager/UI/widgets/snack_bar_message.dart';
import 'package:task_manager/data/controller/authentication_controller.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/intro_background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _waitThenMoveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isUserLogedIn =
        await AuthenticationController.checkIfUserLogedInOrNot();
    if (mounted) {
      if (isUserLogedIn == true) {
        bottomPopUpMessage(context, 'You are Signed In!', showError: false);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return isUserLogedIn ? const BottomNavBar() : const SignInScreen();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _waitThenMoveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroBackgroundWidget(
      child: Center(
        child: Image.asset(
          AssetsPath.logoImg,
          width: MediaQuery.sizeOf(context).width / 1.7,
        ),
      ),
    ));
  }
}
