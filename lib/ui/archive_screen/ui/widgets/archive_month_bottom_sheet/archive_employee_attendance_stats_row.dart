import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

import 'archive_employee_attendance_stat_card.dart';

class ArchiveEmployeeAttendanceStatsRow extends StatelessWidget {
  const ArchiveEmployeeAttendanceStatsRow({
    super.key,
    required this.attendanceDays,
    required this.absentDays,
  });

  final int attendanceDays;
  final int absentDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ArchiveEmployeeAttendanceStatCard(
            icon: Icons.check_circle_outline_rounded,
            value: attendanceDays.toString(),
            title: 'يوم حضور',
            color: ColorPalette.green,
          ),
        ),

        horizontalSpace(10),

        Expanded(
          child: ArchiveEmployeeAttendanceStatCard(
            icon: Icons.cancel_outlined,
            value: absentDays.toString(),
            title: 'يوم غياب',
            color: ColorPalette.red,
          ),
        ),
      ],
    );
  }
}