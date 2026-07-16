import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/textstyles.dart';

class PercentageBox extends StatelessWidget {
  const PercentageBox({
    super.key,
    required this.percentage,
    required this.color,
  });

  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: color.withOpacity(0.25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 0,
                  end: percentage,
                ),
                duration: 1200.ms,
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    '${value.toInt()}%',
                    style: Textstyles.font20BlackBold().copyWith(
                      color: color,
                    ),
                  );
                },
              ),

              SizedBox(height: 2.h),

              Text(
                'الالتزام',
                style: Textstyles.font13Grey500Medium().copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}