import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Hodor/core/style/textstyles.dart';

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'حضور',
      style: Textstyles.font30BlueSemiBold(),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(
          delay: 250.ms,
          duration: 550.ms,
        )
        .slideY(
          begin: 0.25,
          end: 0,
          delay: 250.ms,
          duration: 650.ms,
          curve: Curves.easeOut,
        );
  }
}