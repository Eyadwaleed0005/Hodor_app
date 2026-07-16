import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

class ArchiveBlurBadge extends StatelessWidget {
  const ArchiveBlurBadge({
    super.key,
    required this.title,
    this.subtitle,
    required this.color,
  });

  final String title;
  final String? subtitle;
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
            horizontal: 12.w,
            vertical: 6.h,
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
              Text(
                title,
                style: Textstyles.font16BlackBold().copyWith(
                  color: color,
                ),
              ),

              if (subtitle != null) ...[
                verticalSpace(2),
                Text(
                  subtitle!,
                  style: Textstyles.font12Gray400Regular().copyWith(
                    color: color,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}