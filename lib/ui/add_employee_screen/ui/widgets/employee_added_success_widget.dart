import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_animations.dart';
import 'package:Hodor/core/widgets/app_button.dart';
import 'package:Hodor/core/widgets/secondary_button.dart';

class EmployeeAddedSuccessWidget extends StatelessWidget {
  const EmployeeAddedSuccessWidget({
    super.key,
    required this.onAddAnotherEmployee,
  });

  final VoidCallback onAddAnotherEmployee;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: ColorPalette.green.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: ColorPalette.green,
                size: 75.sp,
              ),
            ).animate(
              effects: AppAnimations.fadeScale(),
            ),

            verticalSpace(24),

            Text(
              'تمت الإضافة بنجاح',
              textAlign: TextAlign.center,
              style: Textstyles.font20BlackBold(),
            ).animate(
              effects: AppAnimations.fadeSlideUp(
                delay: 150.ms,
              ),
            ),

            verticalSpace(40),

            AppButton(
              isLoading: false,
              title: 'إضافة موظف آخر',
              onPressed: onAddAnotherEmployee,
            ).animate(
              effects: AppAnimations.fadeSlideUp(
                delay: 300.ms,
              ),
            ),

            verticalSpace(12),

            SecondaryButton(
              title: 'العودة للرئيسية',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.homeScreen,
                  (route) => false,
                );
              },
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