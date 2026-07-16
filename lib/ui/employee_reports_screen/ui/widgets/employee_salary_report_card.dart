import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_commitment_helper.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeSalaryReportCard extends StatelessWidget {
  final String employeeName;
  final double commitmentPercentage;
  final num suggestedSalary;
  final VoidCallback onTapDetails;

  const EmployeeSalaryReportCard({
    super.key,
    required this.employeeName,
    required this.commitmentPercentage,
    required this.suggestedSalary,
    required this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = EmployeeCommitmentHelper.getStatusColor(
      commitmentPercentage,
    );

    final statusText = EmployeeCommitmentHelper.getStatusText(
      commitmentPercentage,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: ColorPalette.gray300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorPalette.blue,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    EmployeeNameHelper.getInitials(employeeName),
                    style: Textstyles.font20WhiteBold(),
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Text(
                    employeeName,
                    textAlign: TextAlign.right,
                    style: Textstyles.font20BlackBold(),
                  ),
                ),
                _BlurBox(
                  color: statusColor,
                  child: Column(
                    children: [
                      Text(
                        '${commitmentPercentage.toStringAsFixed(0)}%',
                        style: Textstyles.font20BlackBold().copyWith(
                          color: statusColor,
                        ),
                      ),
                      Text(
                        'الالتزام',
                        style: Textstyles.font13Grey500Medium().copyWith(
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            verticalSpace(20),

            Row(
              children: [
                Text(
                  'نسبة الالتزام هذا الشهر',
                  textAlign: TextAlign.right,
                  style: Textstyles.font16Gray500Bold(),
                ),
                const Spacer(),
                Text(
                  statusText,
                  textAlign: TextAlign.left,
                  style: Textstyles.font16Gray500Bold().copyWith(
                    color: statusColor,
                  ),
                ),
              ],
            ),

            verticalSpace(10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: LinearProgressIndicator(
                value: commitmentPercentage.clamp(0, 100) / 100,
                minHeight: 10.h,
                backgroundColor: ColorPalette.gray300,
                valueColor: AlwaysStoppedAnimation(statusColor),
              ),
            ),

            verticalSpace(18),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: ColorPalette.blue.withOpacity(.10),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: ColorPalette.blue.withOpacity(.15)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _BlurBox(
                        color: ColorPalette.blue,
                        padding: EdgeInsets.all(10.r),
                        child: Icon(
                          Icons.payments_outlined,
                          color: ColorPalette.blue,
                          size: 24.sp,
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Text(
                          'الراتب المقترح',
                          textAlign: TextAlign.right,
                          style: Textstyles.font18BlueBold(),
                        ),
                      ),
                      Text(
                        '$suggestedSalary جنيه',
                        style: Textstyles.font20BlueDarkBold(),
                      ),
                    ],
                  ),

                  verticalSpace(12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تم احتساب الراتب بناءً على نسبة الالتزام لهذا الشهر',
                      textAlign: TextAlign.right,
                      style: Textstyles.font14BlueMedium(),
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTapDetails,
                icon: Icon(Icons.description_outlined, size: 22.sp),
                label: Text(
                  'عرض التقرير التفصيلى',
                  style: Textstyles.font16BlueBold(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.white,
                  foregroundColor: ColorPalette.blue,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: BorderSide(color: ColorPalette.blue.withOpacity(.25)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlurBox extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _BlurBox({
    required this.color,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding == EdgeInsets.zero
        ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h)
        : padding;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            color: color.withOpacity(.12),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: color.withOpacity(.18)),
          ),
          child: child,
        ),
      ),
    );
  }
}
