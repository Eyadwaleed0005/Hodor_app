import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

import 'archive_month_blur_icon_box.dart';

class ArchiveMonthSummaryCard extends StatelessWidget {
  const ArchiveMonthSummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ArchiveMonthBlurIconBox(
                icon: icon,
                color: color,
              ),

              horizontalSpace(10),

              Text(
                value,
                style: Textstyles.font20BlackBold().copyWith(
                  color: color,
                ),
              ),
            ],
          ),
          verticalSpace(10),
          Text(
            title,
            style: Textstyles.font13Grey500Medium(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}