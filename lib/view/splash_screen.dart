import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:final_q/view/home_screen.dart';
import 'package:final_q/view/login_screen.dart';
import 'package:flutter/material.dart';

import '../core/helper/responsive.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSplashScreen(
          backgroundColor: Colors.white,
          splash: Image.asset("assets/img/logoo.png"),
          splashIconSize: 150,
          animationDuration: const Duration(seconds: 3),
          nextScreen:  Home1Screen(),
          splashTransition: SplashTransition.scaleTransition,
          curve: Curves.easeOutQuad,
        ),
      ],
    );
  }
}
