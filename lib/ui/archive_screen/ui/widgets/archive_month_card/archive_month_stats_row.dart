import 'package:flutter/material.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

import 'dot_separator.dart';

class ArchiveMonthStatsRow extends StatelessWidget {
  const ArchiveMonthStatsRow({
    super.key,
    required this.employeesCount,
    required this.workDays,
    required this.absentDays,
  });

  final int employeesCount;
  final int workDays;
  final int absentDays;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$employeesCount موظف',
          style: Textstyles.font14Grey500Medium(),
        ),

        const DotSeparator(),

        Text(
          '$workDays يوم عمل',
          style: Textstyles.font14Grey500Medium(),
        ),

        const DotSeparator(),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$absentDays',
                style: Textstyles.font14Grey500Medium().copyWith(
                  color: ColorPalette.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' يوم غياب',
                style: Textstyles.font14Grey500Medium(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}