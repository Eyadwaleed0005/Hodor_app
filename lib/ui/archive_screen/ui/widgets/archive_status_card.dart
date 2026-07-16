import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class ArchiveStatusCard extends StatelessWidget {
  const ArchiveStatusCard({
    super.key,
    required this.blurColor,
    required this.number,
    required this.subtitle,
    required this.subtitleColor,
    this.icon = Icons.archive_outlined,
    this.numberSuffix,
    this.monthName,
    this.isDefaultStyle = false,
  });

  final Color blurColor;
  final String number;
  final String subtitle;
  final Color subtitleColor;
  final IconData icon;
  final String? numberSuffix;
  final String? monthName;
  final bool isDefaultStyle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 145.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isDefaultStyle
                ? ColorPalette.white
                : blurColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isDefaultStyle
                  ? ColorPalette.gray400.withOpacity(0.3)
                  : blurColor.withOpacity(0.25),
              width: 1.2,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: blurColor.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Icon(
                        icon,
                        color: blurColor,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),

                verticalSpace(7),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        number,
                        style: Textstyles.font16BlackBold().copyWith(
                          color: blurColor,
                        ),
                      ),
                      if (numberSuffix != null) ...[
                        horizontalSpace(2),
                        Text(
                          numberSuffix!,
                          style: Textstyles.font16BlackBold().copyWith(
                            color: blurColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                if (monthName != null) ...[
                  verticalSpace(2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      monthName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Textstyles.font13Grey500Medium().copyWith(
                        color: blurColor,
                      ),
                    ),
                  ),
                ],

                verticalSpace(1),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Textstyles.font14Gray500Regular().copyWith(
                      color: subtitleColor,
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