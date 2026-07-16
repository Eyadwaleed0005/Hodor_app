import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeAbsenceEmptyView extends StatelessWidget {
  const EmployeeAbsenceEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        children: [
          Container(
            width: 62.w,
            height: 62.h,
            decoration: const BoxDecoration(
              color: ColorPalette.gray200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_available_rounded,
              size: 30.sp,
              color: ColorPalette.gray400,
            ),
          ),
          verticalSpace(14),
          Text(
            'لا يوجد سجل غيابات لهذا الموظف',
            style: Textstyles.font18Gray500Regular(),
            textAlign: TextAlign.center,
          ),
          verticalSpace(4),
          Text(
            'لم يتم تسجيل أي أيام غياب حتى الآن',
            style: Textstyles.font14Gray500Regular(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
