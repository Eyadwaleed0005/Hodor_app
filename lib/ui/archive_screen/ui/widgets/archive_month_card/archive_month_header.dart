import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

import 'glass_badge.dart';
import 'percentage_box.dart';

class ArchiveMonthHeader extends StatelessWidget {
  const ArchiveMonthHeader({
    super.key,
    required this.monthName,
    required this.percentage,
    required this.statusColor,
    this.monthTypeText,
    this.monthTypeColor,
  });

  final String monthName;
  final double percentage;
  final Color statusColor;
  final String? monthTypeText;
  final Color? monthTypeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  monthName,
                  overflow: TextOverflow.ellipsis,
                  style: Textstyles.font20BlackBold(),
                ),
              ),

              if (monthTypeText != null) ...[
                horizontalSpace(8),
                GlassBadge(
                  text: monthTypeText!,
                  color: monthTypeColor ?? statusColor,
                ),
              ],
            ],
          ),
        ),
        horizontalSpace(12),
        PercentageBox(
          percentage: percentage,
          color: statusColor,
        ),
      ],
    );
  }
}