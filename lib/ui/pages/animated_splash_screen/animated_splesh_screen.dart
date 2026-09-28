
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_application/ui/pages/home_page/home_page.dart';

class AnimatedScreen extends StatelessWidget {
  const AnimatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const HomePage(),
      splash: 'assets/images/sunny_images.png',
      backgroundColor: Colors.white,
      duration: 3000,
      splashIconSize: 450,
    );
  } 
}