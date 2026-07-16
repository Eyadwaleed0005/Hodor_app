import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_button.dart';

class HomeDataFailureView
    extends StatelessWidget {
  final VoidCallback onRetry;

  const HomeDataFailureView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 112.w,
              height: 112.w,
              decoration: BoxDecoration(
                color: ColorPalette.red
                    .withOpacity(0.08),
                borderRadius:
                    BorderRadius.circular(
                  32.r,
                ),
                border: Border.all(
                  color: ColorPalette.red
                      .withOpacity(0.18),
                  width: 1.5,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.dashboard_outlined,
                    color: ColorPalette.red
                        .withOpacity(0.28),
                    size: 68.sp,
                  ),
                  Positioned(
                    right: 19.w,
                    bottom: 18.h,
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: const BoxDecoration(
                        color: ColorPalette.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.priority_high_rounded,
                        color: ColorPalette.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate(
              effects:
                  AppAnimations.fadeScale(),
            ),
            verticalSpace(24),
            Text(
              'تعذر تحميل لوحة التحكم',
              textAlign: TextAlign.center,
              style:
                  Textstyles.font20BlackBold(),
            ).animate(
              effects:
                  AppAnimations.fadeSlideUp(
                delay: 120.ms,
              ),
            ),
            verticalSpace(10),
            Text(
              'لم نتمكن من تحميل إحصائيات الموظفين والغياب في الوقت الحالي.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ).animate(
              effects:
                  AppAnimations.fadeSlideUp(
                delay: 200.ms,
              ),
            ),
            verticalSpace(6),
            Text(
              'تحقق من البيانات ثم أعد المحاولة.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            ).animate(
              effects:
                  AppAnimations.fadeSlideUp(
                delay: 240.ms,
              ),
            ),
            verticalSpace(32),
            AppButton(
              isLoading: false,
              title: 'إعادة تحميل البيانات',
              onPressed: onRetry,
            ).animate(
              effects:
                  AppAnimations.fadeSlideUp(
                delay: 320.ms,
              ),
            ),
          ],
        ),
      ),
    );
  }
}