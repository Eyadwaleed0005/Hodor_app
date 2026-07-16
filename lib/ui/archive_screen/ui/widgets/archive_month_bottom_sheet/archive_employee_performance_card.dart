import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_commitment_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

import 'archive_blur_badge.dart';
import 'archive_employee_attendance_stats_row.dart';
import 'archive_employee_progress_bar.dart';

class ArchiveEmployeePerformanceCard extends StatelessWidget {
  const ArchiveEmployeePerformanceCard({
    super.key,
    required this.employeeName,
    required this.percentage,
    required this.attendanceDays,
    required this.absentDays,
  });

  final String employeeName;
  final double percentage;
  final int attendanceDays;
  final int absentDays;

  String get initials {
    final name = employeeName.trim();

    if (name.isEmpty) {
      return '-';
    }

    if (name.length <= 2) {
      return name;
    }

    return name.substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor =
        EmployeeCommitmentHelper.getStatusColor(percentage);

    final statusText =
        EmployeeCommitmentHelper.getStatusText(percentage);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorPalette.blue,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  initials,
                  style: Textstyles.font18WhiteBold(),
                ),
              ),

              horizontalSpace(12),

              Expanded(
                child: Text(
                  employeeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Textstyles.font16BlackBold(),
                ),
              ),

              Column(
                children: [
                  ArchiveBlurBadge(
                    title:
                        '${percentage.toStringAsFixed(0)}%',
                    color: statusColor,
                  ),

                  verticalSpace(6),

                  ArchiveBlurBadge(
                    title: statusText,
                    color: statusColor,
                  ),
                ],
              ),
            ],
          ),

          verticalSpace(18),

          ArchiveEmployeeProgressBar(
            percentage: percentage,
            color: statusColor,
          ),

          verticalSpace(18),

          ArchiveEmployeeAttendanceStatsRow(
            attendanceDays: attendanceDays,
            absentDays: absentDays,
          ),
        ],
      ),
    );
  }
}