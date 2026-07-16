import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Hodor/core/style/textstyles.dart';

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
          'نظام ذكي لتسجيل حضور وغياب الموظفين',
          textAlign: TextAlign.center,
          style: Textstyles.font13Grey500Medium(),
        )
        .animate()
        .fadeIn(
          delay: 520.ms,
          duration: 600.ms,
        )
        .slideY(
          begin: 0.2,
          end: 0,
          delay: 520.ms,
          duration: 600.ms,
        );
  }
}