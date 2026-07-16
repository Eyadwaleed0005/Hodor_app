import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/statistic_card.dart';

class AbsenceStatisticsCards extends StatelessWidget {
  final int totalEmployees;
  final int presentEmployees;
  final int absentEmployees;

  const AbsenceStatisticsCards({
    super.key,
    required this.totalEmployees,
    required this.presentEmployees,
    required this.absentEmployees,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: StatisticCard(
            icon: Icons.people_alt_outlined,
            color: ColorPalette.blue,
            number: totalEmployees.toString(),
            title: 'إجمالي الموظفين',
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: StatisticCard(
            icon: Icons.check_circle_outline,
            color: ColorPalette.green,
            number: presentEmployees.toString(),
            title: 'الحضور اليوم',
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: StatisticCard(
            icon: Icons.event_busy_outlined,
            color: ColorPalette.red,
            number: absentEmployees.toString(),
            title: 'الغياب اليوم',
          ),
        ),
      ],
    );
  }
}