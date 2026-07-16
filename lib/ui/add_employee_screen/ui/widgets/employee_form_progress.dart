import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeFormProgress extends StatelessWidget {
  const EmployeeFormProgress({
    super.key,
    required this.completedFields,
    this.totalFields = 3,
  });

  final int completedFields;
  final int totalFields;

  @override
  Widget build(BuildContext context) {
    final double progress = totalFields == 0
        ? 0
        : (completedFields / totalFields).clamp(0.0, 1.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'اكتمال البيانات',
                style: Textstyles.font18Gray500Regular(),
              ),
              const Spacer(),
              Text(
                '$completedFields من $totalFields',
                style: Textstyles.font18BlueBold(),
              ),
            ],
          ),
          verticalSpace(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: ColorPalette.gray300,
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorPalette.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}