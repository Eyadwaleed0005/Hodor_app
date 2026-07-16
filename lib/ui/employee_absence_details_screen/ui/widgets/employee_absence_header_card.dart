import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/employee_short_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeAbsenceHeaderCard extends StatelessWidget {
  final String employeeName;
  final int absenceCount;
  final String salary;

  const EmployeeAbsenceHeaderCard({
    super.key,
    required this.employeeName,
    required this.absenceCount,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorPalette.red.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    absenceCount.toString(),
                    style: Textstyles.font25RedBold(),
                  ),
                  verticalSpace(2),
                  Text(
                    'غياب هذا الشهر',
                    textAlign: TextAlign.center,
                    style: Textstyles.font12RedBold(),
                  ),
                ],
              ),
            ),
          ),
        ),

        const Spacer(),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  EmployeeShortNameHelper.getFirstTwoWords(
                    employeeName,
                  ),
                  textAlign: TextAlign.right,
                  style: Textstyles.font20BlackBold(),
                ),
                verticalSpace(2),
                Text(
                  '$salary ج.م',
                  style: Textstyles.font18Gray500Regular(),
                ),
              ],
            ),

            horizontalSpace(12),

            Container(
              width: 56.w,
              height: 56.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorPalette.blue,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                EmployeeNameHelper.getInitials(employeeName),
                style: Textstyles.font18WhiteBold(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}