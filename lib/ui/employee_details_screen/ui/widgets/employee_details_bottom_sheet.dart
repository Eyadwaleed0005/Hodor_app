import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeDetailsBottomSheet extends StatelessWidget {
  const EmployeeDetailsBottomSheet({
    super.key,
    required this.employeeName,
    required this.age,
    required this.salary,
    required this.absentDays,
    required this.createdAt,
    required this.isPresent,
  });

  final String employeeName;
  final int age;
  final double salary;
  final int absentDays;
  final String createdAt;
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
        ),
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
                  color: Colors.grey.shade300,
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
                    height: 68.w,
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

              verticalSpace(10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isPresent
                      ? ColorPalette.green.withOpacity(.12)
                      : ColorPalette.red.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'حالة اليوم: ${isPresent ? "حاضر" : "غائب"}',
                  style: Textstyles.font14BlackMedium().copyWith(
                    color: isPresent ? ColorPalette.green : ColorPalette.red,
                    fontWeight: FontWeight.w700,
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
                    _InfoRow(
                      icon: Icons.person_outline_rounded,
                      title: 'الاسم الكامل',
                      value: employeeName,
                    ),

                    const _Divider(),

                    _InfoRow(
                      icon: Icons.cake_outlined,
                      title: 'العمر',
                      value: '$age سنة',
                    ),

                    const _Divider(),

                    _InfoRow(
                      icon: Icons.payments_outlined,
                      title: 'الراتب الشهري',
                      value: '${salary.toStringAsFixed(0)} جنيه',
                    ),

                    const _Divider(),

                    _InfoRow(
                      icon: Icons.calendar_month_outlined,
                      title: 'تاريخ الإضافة',
                      value: AppDateHelper.formatDatabaseDateToArabic(
                        createdAt,
                      ),
                    ),

                    const _Divider(),

                    _InfoRow(
                      icon: Icons.event_busy_outlined,
                      title: 'أيام الغياب الكلية',
                      value: '$absentDays يوم',
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
                  child: Text('اغلاق', style: Textstyles.font16BlackBold()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38.w,
          height: 38.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorPalette.gray100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 20.sp, color: Colors.grey.shade700),
        ),

        horizontalSpace(10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Textstyles.font14Grey500Medium()),

              verticalSpace(3),

              Text(
                value,
                style: Textstyles.font16BlackBold(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
