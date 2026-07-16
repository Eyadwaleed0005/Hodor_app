import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: const Color(0xFF4F86F7),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F86F7).withValues(alpha: 0.35),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'ح',
              style: TextStyle(
                fontSize: 42.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 500.ms,
          curve: Curves.easeOut,
        )
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          duration: 650.ms,
          curve: Curves.easeOutBack,
        );
  }
}