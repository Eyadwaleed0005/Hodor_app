import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_commitment_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_employee_archive_model.dart';

import 'archive_blur_badge.dart';
import 'archive_employee_attendance_stats_row.dart';
import 'archive_employee_progress_bar.dart';

class ArchiveEmployeesPerformanceSection extends StatelessWidget {
  const ArchiveEmployeesPerformanceSection({
    super.key,
    required this.employees,
  });

  final List<MonthlyEmployeeArchiveModel> employees;

  String _getInitials(String name) {
    final cleanName = name.trim();

    if (cleanName.isEmpty) {
      return '-';
    }

    if (cleanName.length <= 2) {
      return cleanName;
    }

    return cleanName.substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorPalette.offWhite,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          'لا يوجد موظفين في هذا الشهر',
          style: Textstyles.font18Gray500Regular(),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أداء الموظفين',
          style: Textstyles.font18BlackBold(),
        ),

        verticalSpace(14),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: employees.length,
          separatorBuilder: (_, __) => verticalSpace(10),
          itemBuilder: (context, index) {
            final employee = employees[index];

            final Color statusColor =
                EmployeeCommitmentHelper.getStatusColor(
              employee.commitmentPercentage,
            );

            final String statusText =
                EmployeeCommitmentHelper.getStatusText(
              employee.commitmentPercentage,
            );

            final int attendanceDays =
                employee.workDays - employee.absentDays;

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
                          _getInitials(employee.employeeName),
                          style: Textstyles.font18WhiteBold(),
                        ),
                      ),

                      horizontalSpace(12),

                      Expanded(
                        child: Text(
                          employee.employeeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Textstyles.font16BlackBold(),
                        ),
                      ),

                      Column(
                        children: [
                          ArchiveBlurBadge(
                            title:
                                '${employee.commitmentPercentage.toStringAsFixed(0)}%',
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
                    percentage: employee.commitmentPercentage,
                    color: statusColor,
                  ),

                  verticalSpace(18),

                  ArchiveEmployeeAttendanceStatsRow(
                    attendanceDays: attendanceDays,
                    absentDays: employee.absentDays,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}