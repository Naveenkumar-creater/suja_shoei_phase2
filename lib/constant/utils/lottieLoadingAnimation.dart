import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/94350-gears-lottie-animation.json', // Replace with the path to your Lottie animation JSON file
      height: 100, // Adjust the height as needed
      width: 100, // Adjust the width as needed
      fit: BoxFit.cover,
    );
  }
}
