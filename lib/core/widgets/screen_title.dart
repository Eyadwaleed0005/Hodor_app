import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: iconBackgroundColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: iconBackgroundColor.withOpacity(.18),
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 35.sp,
            ),
          ),
          horizontalSpace(14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Textstyles.font20BlackBold(),
                ),
                verticalSpace(4),
                Text(
                  subtitle,
                  style: Textstyles.font15Gray500Regular(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}