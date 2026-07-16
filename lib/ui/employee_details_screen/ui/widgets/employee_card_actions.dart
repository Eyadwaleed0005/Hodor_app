import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeCardActions extends StatelessWidget {
  const EmployeeCardActions({
    super.key,
    required this.onViewTap,
    required this.onDeleteTap,
  });

  final VoidCallback onViewTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: InkWell(
                onTap: onViewTap,
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  height: 46.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorPalette.blue.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: ColorPalette.blue.withOpacity(0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 20.sp,
                        color: ColorPalette.blue,
                      ),
                      horizontalSpace(8),
                      Text(
                        'عرض البيانات',
                        style: Textstyles.font16BlueBold(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        horizontalSpace(10),

        InkWell(
          onTap: onDeleteTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            width: 46.w,
            height: 46.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorPalette.red.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: ColorPalette.red.withOpacity(0.35),
              ),
            ),
            child: Icon(
              Icons.delete_outline,
              size: 22.sp,
              color: ColorPalette.red,
            ),
          ),
        ),
      ],
    );
  }
}