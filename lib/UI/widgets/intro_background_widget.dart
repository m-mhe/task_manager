import 'package:flutter/material.dart';
import '../utility/assets_path.dart';

class IntroBackgroundWidget extends StatelessWidget {
  const IntroBackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsPath.backgroundPngImg,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
