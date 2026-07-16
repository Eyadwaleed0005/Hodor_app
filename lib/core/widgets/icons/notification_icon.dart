import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 46.w,
            height: 46.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.white.withOpacity(0.16),
              border: Border.all(
                color: ColorPalette.white.withOpacity(0.22),
                width: 1.3.w,
              ),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: ColorPalette.white,
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}