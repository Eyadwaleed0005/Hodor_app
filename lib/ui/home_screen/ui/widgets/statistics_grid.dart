import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/statistic_card.dart';

class StatisticsGrid extends StatelessWidget {
  final int monthAbsencesCount;
  final int employeesCount;
  final int todayAbsentCount;
  final double commitmentPercentage;

  const StatisticsGrid({
    super.key,
    required this.monthAbsencesCount,
    required this.employeesCount,
    required this.todayAbsentCount,
    required this.commitmentPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final commitment = (commitmentPercentage * 100).toInt();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatisticCard(
                icon: Icons.calendar_month,
                color: ColorPalette.yellow,
                number: monthAbsencesCount.toString(),
                title: 'غيابات الشهر',
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: StatisticCard(
                icon: Icons.groups_rounded,
                color: ColorPalette.blue,
                number: employeesCount.toString(),
                title: 'عدد الموظفين',
              ),
            ),
          ],
        ),
        verticalSpace(12),
        Row(
          children: [
            Expanded(
              child: StatisticCard(
                icon: Icons.show_chart_rounded,
                color: ColorPalette.green,
                number: '$commitment%',
                title: 'نسبه الالتزام',
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: StatisticCard(
                icon: Icons.person_outline,
                color: ColorPalette.red,
                number: todayAbsentCount.toString(),
                title: 'الغائبون اليوم',
              ),
            ),
          ],
        ),
      ],
    );
  }
}