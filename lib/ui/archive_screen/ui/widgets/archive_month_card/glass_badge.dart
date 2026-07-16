import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassBadge extends StatelessWidget {
  const GlassBadge({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          decoration: BoxDecoration(
            color:
                color.withOpacity(0.12),
            borderRadius:
                BorderRadius.circular(
              14.r,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}