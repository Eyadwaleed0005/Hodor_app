import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_commitment_helper.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeSalaryReportBottomSheet extends StatelessWidget {
  final String employeeName;
  final int presentDays;
  final int absentDays;
  final double commitmentPercentage;
  final num baseSalary;
  final num suggestedSalary;

  const EmployeeSalaryReportBottomSheet({
    super.key,
    required this.employeeName,
    required this.presentDays,
    required this.absentDays,
    required this.commitmentPercentage,
    required this.baseSalary,
    required this.suggestedSalary,
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
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorPalette.gray300,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),

              verticalSpace(18),

              ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: 68.w,
                    height: 68.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorPalette.blue,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Text(
                      EmployeeNameHelper.getInitials(employeeName),
                      style: Textstyles.font20WhiteExtraBold(),
                    ),
                  ),
                ),
              ),

              verticalSpace(10),

              Text(
                employeeName,
                textAlign: TextAlign.center,
                style: Textstyles.font18BlackBold(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              verticalSpace(18),

              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: commitmentPercentage.clamp(0, 100) / 100,
                ),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  final animatedPercentage = value * 100;

                  return SizedBox(
                    width: 130.w,
                    height: 130.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 130.w,
                          height: 130.h,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 10.w,
                            backgroundColor: ColorPalette.gray300,
                            valueColor: AlwaysStoppedAnimation(statusColor),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${animatedPercentage.toStringAsFixed(0)}%',
                              style: Textstyles.font24BlueBold().copyWith(
                                color: statusColor,
                              ),
                            ),
                            verticalSpace(2),
                            Text(
                              'الالتزام',
                              style: Textstyles.font14Grey500Medium().copyWith(
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              verticalSpace(14),

              Text(
                'مستوى الالتزام',
                textAlign: TextAlign.center,
                style: Textstyles.font14Grey500Medium(),
              ),

              verticalSpace(6),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: statusColor.withOpacity(.18)),
                ),
                child: Text(
                  statusText,
                  textAlign: TextAlign.center,
                  style: Textstyles.font16BlackBold().copyWith(
                    color: statusColor,
                  ),
                ),
              ),

              verticalSpace(16),

              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: ColorPalette.gray300, width: 1.w),
                ),
                child: Column(
                  children: [
                    _ReportRow(
                      title: 'أيام الحضور',
                      value: '$presentDays يوم',
                      valueColor: ColorPalette.green,
                    ),
                    const _Divider(),
                    _ReportRow(
                      title: 'أيام الغياب',
                      value: '$absentDays يوم',
                      valueColor: ColorPalette.red,
                    ),
                    const _Divider(),
                    _ReportRow(
                      title: 'نسبة الالتزام',
                      value: '${commitmentPercentage.toStringAsFixed(0)}%',
                      valueColor: statusColor,
                    ),
                    const _Divider(),
                    _ReportRow(
                      title: 'الراتب الأساسي',
                      value: '${baseSalary.toStringAsFixed(0)} جنيه',
                      valueColor: ColorPalette.black,
                    ),
                    const _Divider(),
                    _ReportRow(
                      title: 'الراتب المقترح',
                      value: '${suggestedSalary.toStringAsFixed(0)} جنيه',
                      valueColor: ColorPalette.blue,
                    ),
                  ],
                ),
              ),

              verticalSpace(18),

              Container(
                width: double.infinity,
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
                          '${suggestedSalary.toStringAsFixed(0)} جنيه',
                          style: Textstyles.font20BlueBold(),
                        ),
                      ],
                    ),

                    verticalSpace(12),

                    Divider(
                      height: 1.h,
                      color: ColorPalette.blue.withOpacity(.20),
                    ),

                    verticalSpace(12),

                    Row(
                      children: [
                        Text(
                          'الراتب الأساسي: ${baseSalary.toStringAsFixed(0)} جنيه',
                          style: Textstyles.font14BlueMedium(),
                        ),
                        const Spacer(),
                        Text(
                          'الالتزام: ${commitmentPercentage.toStringAsFixed(0)}%',
                          style: Textstyles.font14BlueMedium(),
                        ),
                      ],
                    ),

                    verticalSpace(8),

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
                height: 58.h,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: ColorPalette.white,
                    side: BorderSide(color: ColorPalette.gray300, width: 1.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text('إغلاق', style: Textstyles.font16BlackBold()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const _ReportRow({
    required this.title,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: Textstyles.font14Grey500Medium())),
        Text(
          value,
          style: Textstyles.font16BlackBold().copyWith(color: valueColor),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Divider(height: 1, color: ColorPalette.gray300),
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
