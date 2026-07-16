import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class ArchiveMonthDetailsButton
    extends StatelessWidget {
  const ArchiveMonthDetailsButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(16.r),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(16.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.blue
                  .withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(
                16.r,
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.archive_outlined,
                  color: ColorPalette.blue,
                  size: 20.sp,
                ),
                horizontalSpace(8),
                Text(
                  'عرض تفاصيل الشهر',
                  style:
                      Textstyles.font14BlueMedium(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}