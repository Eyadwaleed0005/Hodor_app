import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

class AbsenceRegistrationSkeletonLoading extends StatelessWidget {
  const AbsenceRegistrationSkeletonLoading({super.key});

  Widget _box({
    required double width,
    required double height,
    double radius = 14,
  }) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: ColorPalette.gray200,
            borderRadius: BorderRadius.circular(radius.r),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .fade(begin: .35, end: 1, duration: 900.ms);
  }

  Widget _statisticsSkeleton() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(child: _statisticCardSkeleton()),
        horizontalSpace(10),
        Expanded(child: _statisticCardSkeleton()),
        horizontalSpace(10),
        Expanded(child: _statisticCardSkeleton()),
      ],
    );
  }

  Widget _statisticCardSkeleton() {
    return Container(
      height: 105.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _box(width: 34.w, height: 34.h, radius: 12.r),
          const Spacer(),
          _box(width: 45.w, height: 20.h, radius: 8.r),
          verticalSpace(8),
          _box(width: 75.w, height: 14.h, radius: 8.r),
        ],
      ),
    );
  }

  Widget _searchSkeleton() {
    return Container(
      width: double.infinity,
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Row(
        children: [
          _box(width: 24.w, height: 24.h, radius: 8.r),
          const Spacer(),
          _box(width: 150.w, height: 18.h, radius: 8.r),
        ],
      ),
    );
  }

  Widget _titleSkeleton() {
    return Align(
      alignment: Alignment.centerRight,
      child: _box(width: 120.w, height: 24.h, radius: 8.r),
    );
  }

  Widget _employeeCardSkeleton() {
    return Container(
      width: double.infinity,
      height: 78.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _box(width: 46.w, height: 46.h, radius: 50.r),
          horizontalSpace(12),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _box(width: 130.w, height: 20.h, radius: 8.r),
            ),
          ),
          horizontalSpace(12),
          _box(width: 34.w, height: 34.h, radius: 10.r),
          horizontalSpace(8),
          _box(width: 34.w, height: 34.h, radius: 10.r),
        ],
      ),
    );
  }

  Widget _employeesListSkeleton() {
    return Column(
      children: [
        _employeeCardSkeleton(),
        verticalSpace(12),
        _employeeCardSkeleton(),
        verticalSpace(12),
        _employeeCardSkeleton(),
        verticalSpace(12),
        _employeeCardSkeleton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _statisticsSkeleton(),
        verticalSpace(20),
        _searchSkeleton(),
        verticalSpace(16),
        _titleSkeleton(),
        verticalSpace(16),
        _employeesListSkeleton(),
      ],
    );
  }
}
