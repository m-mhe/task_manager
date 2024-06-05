import 'package:flutter/material.dart';
import 'package:task_manager/UI/screens/sign_in_screen.dart';
import 'package:task_manager/UI/utility/assets_path.dart';

import '../widgets/intro_background_Widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _waitThenMoveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
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
