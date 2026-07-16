import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

import 'archive_month_blur_icon_box.dart';

class ArchiveEmployeeAttendanceStatCard extends StatelessWidget {
  const ArchiveEmployeeAttendanceStatCard({
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
      height: 73.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: color.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          ArchiveMonthBlurIconBox(
            icon: icon,
            color: color,
          ),

          horizontalSpace(10),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: Textstyles.font20BlackBold().copyWith(
                      color: color,
                    ),
                  ),
                ),

                verticalSpace(3),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Textstyles.font13Grey500Medium().copyWith(
                    color: color.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}