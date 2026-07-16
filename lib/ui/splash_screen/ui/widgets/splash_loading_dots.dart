import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';

class SplashLoadingDots extends StatelessWidget {
  const SplashLoadingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Container(
          width: 8.w,
          height: 8.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPalette.gray400,
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .fade(
              begin: 0.15,
              end: 0.55,
              duration: 700.ms,
              delay: (i * 180).ms,
              curve: Curves.easeInOut,
            );
      }),
    );
  }
}
