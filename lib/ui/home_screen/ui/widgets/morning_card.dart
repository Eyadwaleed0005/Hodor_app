import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class MorningCard extends StatelessWidget {
  final String date;
  final int presentCount;

  const MorningCard({
    super.key,
    required this.date,
    required this.presentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Container(
              width: 65.w,
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.greenLight,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: ColorPalette.greenBorder,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    presentCount.toString(),
                    style: Textstyles.font24DarkGreenBold(),
                  ),
                  verticalSpace(1),
                  Text(
                    'حاضر',
                    style: Textstyles.font13DarkGreenSemiBold(),
                  ),
                ],
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'صباح يوم جديد',
                    style: Textstyles.font25BlackBold(),
                  ),
                  verticalSpace(6),
                  Text(
                    date,
                    style: Textstyles.font18Gray500Regular(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}