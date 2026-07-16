import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

class HomeScreenSkeletonLoading extends StatelessWidget {
  const HomeScreenSkeletonLoading({super.key});

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

  Widget _morningCardSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          children: [
            _box(width: 65.w, height: 68.h, radius: 14),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _box(width: 160.w, height: 24.h, radius: 8.r),
                  verticalSpace(10),
                  _box(width: 210.w, height: 18.h, radius: 8.r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleSkeleton() {
    return Align(
      alignment: Alignment.centerRight,
      child: _box(width: 110.w, height: 24.h, radius: 8.r),
    );
  }

  Widget _statisticsSkeleton() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _statisticCardSkeleton()),
            horizontalSpace(12),
            Expanded(child: _statisticCardSkeleton()),
          ],
        ),
        verticalSpace(12),
        Row(
          children: [
            Expanded(child: _statisticCardSkeleton()),
            horizontalSpace(12),
            Expanded(child: _statisticCardSkeleton()),
          ],
        ),
      ],
    );
  }

  Widget _statisticCardSkeleton() {
    return Container(
      height: 120.h,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _box(width: 38.w, height: 38.h, radius: 12.r),
          const Spacer(),
          _box(width: 55.w, height: 22.h, radius: 8.r),
          verticalSpace(8),
          _box(width: 90.w, height: 16.h, radius: 8.r),
        ],
      ),
    );
  }

  Widget _monthlyCommitmentSkeleton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _box(width: 50.w, height: 22.h, radius: 8.r),
              const Spacer(),
              _box(width: 140.w, height: 22.h, radius: 8.r),
            ],
          ),
          verticalSpace(14),
          _box(width: double.infinity, height: 10.h, radius: 20.r),
          verticalSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _box(width: 70.w, height: 16.h, radius: 8.r),
              horizontalSpace(20),
              _box(width: 70.w, height: 16.h, radius: 8.r),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickActionsSkeleton() {
    return Row(
      children: [
        Expanded(child: _actionSkeleton()),
        horizontalSpace(12),
        Expanded(child: _actionSkeleton()),
      ],
    );
  }

  Widget _actionSkeleton() {
    return Container(
      height: 95.h,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        children: [
          _box(width: 34.w, height: 34.h, radius: 12.r),
          verticalSpace(12),
          _box(width: 90.w, height: 16.h, radius: 8.r),
        ],
      ),
    );
  }

  Widget _todaySummarySkeleton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _box(width: 70.w, height: 18.h, radius: 8.r),
              const Spacer(),
              _box(width: 100.w, height: 22.h, radius: 8.r),
            ],
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(child: _summaryItemSkeleton()),
              Expanded(child: _summaryItemSkeleton()),
              Expanded(child: _summaryItemSkeleton()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItemSkeleton() {
    return Column(
      children: [
        _box(width: 32.w, height: 22.h, radius: 8.r),
        verticalSpace(8),
        _box(width: 50.w, height: 16.h, radius: 8.r),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _morningCardSkeleton(),
          verticalSpace(8),
          Container(
            width: double.infinity,
            color: ColorPalette.offWhite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
              child: Column(
                children: [
                  _titleSkeleton(),
                  verticalSpace(20),
                  _statisticsSkeleton(),
                  verticalSpace(20),
                  _monthlyCommitmentSkeleton(),
                  verticalSpace(20),
                  _titleSkeleton(),
                  verticalSpace(20),
                  _quickActionsSkeleton(),
                  verticalSpace(20),
                  _todaySummarySkeleton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
