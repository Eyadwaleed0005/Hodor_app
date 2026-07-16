import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_archive_model.dart';
import 'package:Hodor/ui/archive_screen/ui/widgets/archive_status_card.dart';

class ArchiveStatusCardsSection extends StatelessWidget {
  const ArchiveStatusCardsSection({
    super.key,
    required this.archivesCount,
    required this.bestMonth,
    required this.worstMonth,
  });

  final int archivesCount;
  final MonthlyArchiveModel? bestMonth;
  final MonthlyArchiveModel? worstMonth;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Expanded(
            child: ArchiveStatusCard(
              isDefaultStyle: true,
              blurColor: ColorPalette.blue,
              number: archivesCount.toString(),
              subtitle: 'الشهور المحفوظة',
              subtitleColor: ColorPalette.gray500,
              icon: Icons.archive_outlined,
            ),
          ),

          horizontalSpace(8),

          Expanded(
            child: ArchiveStatusCard(
              blurColor: ColorPalette.green,
              number: bestMonth == null
                  ? '0'
                  : bestMonth!.commitmentPercentage.toStringAsFixed(0),
              numberSuffix: '%',
              monthName: bestMonth?.monthNameWithYear ?? '',
              subtitle: 'أعلى شهر التزام',
              subtitleColor: ColorPalette.green,
              icon: Icons.trending_up_rounded,
            ),
          ),

          horizontalSpace(8),

          Expanded(
            child: ArchiveStatusCard(
              blurColor: ColorPalette.red,
              number: worstMonth == null
                  ? '0'
                  : worstMonth!.commitmentPercentage.toStringAsFixed(0),
              numberSuffix: '%',
              monthName: worstMonth?.monthNameWithYear ?? '',
              subtitle: 'أقل شهر التزام',
              subtitleColor: ColorPalette.red,
              icon: Icons.trending_down_rounded,
            ),
          ),
        ],
      ),
    );
  }
}