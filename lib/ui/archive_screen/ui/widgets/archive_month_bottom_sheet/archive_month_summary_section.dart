import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

import 'archive_month_summary_card.dart';

class ArchiveMonthSummarySection extends StatelessWidget {
  const ArchiveMonthSummarySection({
    super.key,
    required this.employeesCount,
    required this.absentDays,
  });

  final int employeesCount;
  final int absentDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ArchiveMonthSummaryCard(
            icon: Icons.groups_rounded,
            value: employeesCount.toString(),
            title: 'إجمالي الموظفين',
            color: ColorPalette.blue,
          ),
        ),

        horizontalSpace(12),

        Expanded(
          child: ArchiveMonthSummaryCard(
            icon: Icons.event_busy_rounded,
            value: absentDays.toString(),
            title: 'إجمالي أيام الغياب',
            color: ColorPalette.red,
          ),
        ),
      ],
    );
  }
}