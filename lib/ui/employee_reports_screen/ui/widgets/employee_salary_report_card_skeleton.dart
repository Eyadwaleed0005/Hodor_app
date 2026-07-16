import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

class EmployeeSalaryReportCardSkeleton extends StatefulWidget {
  const EmployeeSalaryReportCardSkeleton({super.key});

  @override
  State<EmployeeSalaryReportCardSkeleton> createState() =>
      _EmployeeSalaryReportCardSkeletonState();
}

class _EmployeeSalaryReportCardSkeletonState
    extends State<EmployeeSalaryReportCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.35, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _box({
    required double width,
    required double height,
    double radius = 12,
  }) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorPalette.gray200,
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _box(width: 48.w, height: 48.w, radius: 50),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(width: 120.w, height: 14.h),
                    verticalSpace(8),
                    _box(width: 80.w, height: 12.h),
                  ],
                ),
              ),
              _box(width: 70.w, height: 45.h),
            ],
          ),
          verticalSpace(18),
          _box(width: double.infinity, height: 9.h),
          verticalSpace(16),
          _box(width: double.infinity, height: 70.h, radius: 16),
        ],
      ),
    );
  }
}