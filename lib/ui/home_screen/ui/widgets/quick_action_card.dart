import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: ColorPalette.gray200, width: 1.w),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18.r),
          highlightColor: ColorPalette.gray200,
          splashColor: ColorPalette.gray300,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Textstyles.font18BlackBold(),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                horizontalSpace(15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: 46.w,
                      height: 46.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withOpacity(.14),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: color.withOpacity(.22)),
                      ),
                      child: Icon(icon, color: color, size: 24.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
