import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class MonthlyCommitmentCard extends StatelessWidget {
  final double percentage;

  const MonthlyCommitmentCard({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Animate().custom(
            duration: 1500.ms,
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              final currentPercentage =
                  (percentage * 100 * value).toInt();

              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '$currentPercentage%',
                        style: Textstyles.font18BlueBold(),
                      ),
                      const Spacer(),
                      Text(
                        'الالتزام هذا الشهر',
                        style: Textstyles.font18BlackBold(),
                      ),
                    ],
                  ),

                  verticalSpace(14),

                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: LinearProgressIndicator(
                        value: percentage * value,
                        minHeight: 10.h,
                        backgroundColor: ColorPalette.gray300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          ColorPalette.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          verticalSpace(12),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _LegendItem(
                color: ColorPalette.gray400,
                title: 'الغياب',
              ),
              horizontalSpace(24),
              _LegendItem(
                color: ColorPalette.blue,
                title: 'الحضور',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String title;

  const _LegendItem({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        horizontalSpace(6),
        Text(
          title,
          style: Textstyles.font18Gray500Regular(),
        ),
      ],
    );
  }
}