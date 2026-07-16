import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/widgets/secondary_button.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_employee_archive_model.dart';

import 'archive_employees_performance_section.dart';
import 'archive_month_bottom_sheet_drag_handle.dart';
import 'archive_month_bottom_sheet_header.dart';
import 'archive_month_summary_section.dart';

class ArchiveMonthBottomSheet extends StatelessWidget {
  const ArchiveMonthBottomSheet({
    super.key,
    required this.monthName,
    required this.percentage,
    required this.employeesCount,
    required this.workDays,
    required this.absentDays,
    required this.statusColor,
    required this.employees,
    this.secondaryButtonTitle = 'إغلاق',
    this.onSecondaryPressed,
  });

  final String monthName;
  final double percentage;
  final int employeesCount;
  final int workDays;
  final int absentDays;
  final Color statusColor;
  final List<MonthlyEmployeeArchiveModel> employees;
  final String secondaryButtonTitle;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ArchiveMonthBottomSheetDragHandle(),

                      verticalSpace(20),

                      ArchiveMonthBottomSheetHeader(
                        monthName: monthName,
                        percentage: percentage,
                        employeesCount: employeesCount,
                        workDays: workDays,
                        statusColor: statusColor,
                      ),

                      verticalSpace(20),

                      ArchiveMonthSummarySection(
                        employeesCount: employeesCount,
                        absentDays: absentDays,
                      ),

                      verticalSpace(24),

                      ArchiveEmployeesPerformanceSection(
                        employees: employees,
                      ),
                    ],
                  ),
                ),
              ),

              verticalSpace(12),

              SecondaryButton(
                title: secondaryButtonTitle,
                onPressed:
                    onSecondaryPressed ?? () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}