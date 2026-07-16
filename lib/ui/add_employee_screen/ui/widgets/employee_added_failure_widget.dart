import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_button.dart';
import 'package:Hodor/core/widgets/secondary_button.dart';

class EmployeeAddedFailureWidget extends StatelessWidget {
  const EmployeeAddedFailureWidget({
    super.key,
    required this.onRetry,
    required this.onBackToForm,
  });

  final VoidCallback onRetry;
  final VoidCallback onBackToForm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: ColorPalette.red.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_rounded,
                color: ColorPalette.red,
                size: 75.sp,
              ),
            ).animate(
              effects: AppAnimations.fadeScale(),
            ),
            verticalSpace(24),
            Text(
              'تعذر إضافة الموظف',
              textAlign: TextAlign.center,
              style: Textstyles.font20BlackBold(),
            ).animate(
              effects: AppAnimations.fadeSlideUp(
                delay: 150.ms,
              ),
            ),
            verticalSpace(10),
            Text(
              'حدث خطأ أثناء حفظ بيانات الموظف، حاول مرة أخرى.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate(
              effects: AppAnimations.fadeSlideUp(
                delay: 220.ms,
              ),
            ),
            verticalSpace(40),
            AppButton(
              isLoading: false,
              title: 'إعادة المحاولة',
              onPressed: onRetry,
            ).animate(
              effects: AppAnimations.fadeSlideUp(
                delay: 300.ms,
              ),
            ),
            verticalSpace(12),
            SecondaryButton(
              title: 'العودة لتعديل البيانات',
              onPressed: onBackToForm,
            ).animate(
              effects: AppAnimations.fadeSlideUp(
                delay: 450.ms,
              ),
            ),
          ],
        ),
      ),
    );
  }
}