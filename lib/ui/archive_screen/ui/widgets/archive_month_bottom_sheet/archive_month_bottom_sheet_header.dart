import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

import 'archive_month_blur_icon_box.dart';
import 'archive_blur_badge.dart';

class ArchiveMonthBottomSheetHeader extends StatelessWidget {
  const ArchiveMonthBottomSheetHeader({
    super.key,
    required this.monthName,
    required this.percentage,
    required this.employeesCount,
    required this.workDays,
    required this.statusColor,
  });

  final String monthName;
  final double percentage;
  final int employeesCount;
  final int workDays;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArchiveMonthBlurIconBox(
          icon: Icons.archive_outlined,
          color: statusColor,
        ),

        horizontalSpace(10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthName,
                style: Textstyles.font20BlackBold(),
              ),
              verticalSpace(4),
              Text(
                '$workDays يوم عمل · $employeesCount موظف',
                style: Textstyles.font14Gray500Regular(),
              ),
            ],
          ),
        ),

        horizontalSpace(10),

        ArchiveBlurBadge(
          title: '${percentage.toInt()}%',
          subtitle: 'الالتزام',
          color: statusColor,
        ),
      ],
    );
  }
}