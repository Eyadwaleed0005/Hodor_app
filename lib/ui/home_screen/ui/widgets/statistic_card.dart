import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class StatisticCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String number;
  final String title;

  const StatisticCard({
    super.key,
    required this.icon,
    required this.color,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final int targetNumber = int.tryParse(
          number.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;

    final String suffix = number.replaceAll(RegExp(r'[0-9]'), '');

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: Container(
                width: 46.w,
                height: 46.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withOpacity(.14),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: color.withOpacity(.22),
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          verticalSpace(14),

          Animate().custom(
            duration: 1500.ms,
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              final currentNumber = (targetNumber * value).toInt();

              return Text(
                '$currentNumber$suffix',
                style: Textstyles.font25BlackBold(),
              );
            },
          ),
          verticalSpace(4),
          Text(
            title,
            style: Textstyles.font18Gray500Regular(),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}