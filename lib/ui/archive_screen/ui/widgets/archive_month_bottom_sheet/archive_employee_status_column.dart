import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';

import 'archive_blur_badge.dart';

class ArchiveEmployeeStatusColumn extends StatelessWidget {
  const ArchiveEmployeeStatusColumn({
    super.key,
    required this.percentage,
    required this.statusText,
    required this.color,
  });

  final double percentage;
  final String statusText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArchiveBlurBadge(
          title: '${percentage.toStringAsFixed(0)}%',
          color: color,
        ),

        verticalSpace(8),

        ArchiveBlurBadge(
          title: statusText,
          color: color,
        ),
      ],
    );
  }
}