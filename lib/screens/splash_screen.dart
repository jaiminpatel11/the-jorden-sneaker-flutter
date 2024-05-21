import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:the_jorden_sneakers/screens/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Column(
      children: [
        Center(
          child: Lottie.asset("assets/Lottie/Animation - 1712103562035.json"),
        )
      ],
    ), nextScreen: const HomeScreen(),
      splashIconSize: 500,
      duration: 3700,
    );
  }
}
