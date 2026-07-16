import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArchiveEmployeeProgressBar extends StatelessWidget {
  const ArchiveEmployeeProgressBar({
    super.key,
    required this.percentage,
    required this.color,
  });

  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double targetPercentage =
        percentage.clamp(0.0, 100.0).toDouble();

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: targetPercentage / 100,
      ),
      duration: 1000.ms,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 9.h,
            backgroundColor: color.withOpacity(0.14),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        );
      },
    );
  }
}