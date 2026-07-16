import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/helper/employee_commitment_helper.dart';
import 'package:Hodor/core/style/app_color.dart';

import 'archive_month_header.dart';
import 'archive_month_stats_row.dart';
import 'archive_month_progress_section.dart';
import 'archive_month_details_button.dart';

class ArchiveMonthCard extends StatelessWidget {
  const ArchiveMonthCard({
    super.key,
    required this.monthName,
    required this.percentage,
    required this.employeesCount,
    required this.workDays,
    required this.absentDays,
    required this.isBestMonth,
    required this.isWorstMonth,
    this.onViewDetailsTap,
  });

  final String monthName;
  final double percentage;
  final int employeesCount;
  final int workDays;
  final int absentDays;
  final bool isBestMonth;
  final bool isWorstMonth;
  final VoidCallback? onViewDetailsTap;

  @override
  Widget build(BuildContext context) {
    final Color statusColor =
        EmployeeCommitmentHelper.getStatusColor(percentage);

    final String statusText =
        EmployeeCommitmentHelper.getStatusText(percentage);

    String? monthTypeText;
    Color? monthTypeColor;

    if (isBestMonth) {
      monthTypeText = 'الأعلى';
      monthTypeColor = ColorPalette.green;
    } else if (isWorstMonth) {
      monthTypeText = 'الأقل';
      monthTypeColor = ColorPalette.red;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.black.withOpacity(0.04),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArchiveMonthHeader(
                      monthName: monthName,
                      percentage: percentage,
                      statusColor: statusColor,
                      monthTypeText: monthTypeText,
                      monthTypeColor: monthTypeColor,
                    ),
                    verticalSpace(10),
                    ArchiveMonthStatsRow(
                      employeesCount: employeesCount,
                      workDays: workDays,
                      absentDays: absentDays,
                    ),
                    verticalSpace(16),
                    ArchiveMonthProgressSection(
                      percentage: percentage,
                      statusColor: statusColor,
                      statusText: statusText,
                    ),
                    verticalSpace(16),
                    ArchiveMonthDetailsButton(
                      onTap: onViewDetailsTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}