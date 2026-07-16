import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

class ArchiveMonthProgressSection extends StatelessWidget {
  const ArchiveMonthProgressSection({
    super.key,
    required this.percentage,
    required this.statusColor,
    required this.statusText,
  });

  final double percentage;
  final Color statusColor;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    final double targetPercentage =
        percentage.clamp(0.0, 100.0).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'متوسط الالتزام الشهري',
              style: Textstyles.font14Grey500Medium(),
            ),

            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: targetPercentage,
                  ),
                  duration: 1200.ms,
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      '${value.toInt()}%',
                      style: Textstyles.font18BlackBold().copyWith(
                        color: statusColor,
                      ),
                    );
                  },
                ),

                Text(
                  statusText,
                  style: Textstyles.font13Grey500Medium().copyWith(
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),

        verticalSpace(10),

        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0,
            end: targetPercentage / 100,
          ),
          duration: 1200.ms,
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 10.h,
                backgroundColor: statusColor.withOpacity(0.14),
                valueColor: AlwaysStoppedAnimation<Color>(
                  statusColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}