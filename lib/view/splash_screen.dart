import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:play_game_machine_test/view/intro_screen.dart';

//AnimatedSplashScreen----------------------------------------------------------
class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSplashScreen(
          splash: Lottie.asset('assets/118018-puzzle.json'),
          nextScreen: IntroScreen(),
          splashTransition: SplashTransition.fadeTransition,
          duration: 3000,
        ),
      ),
    );
  }
}
