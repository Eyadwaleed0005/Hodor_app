import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

class EmployeeDetailsSkeletonLoading extends StatelessWidget {
  const EmployeeDetailsSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        return const _EmployeeDetailsSkeletonCard();
      },
    );
  }
}

class _EmployeeDetailsSkeletonCard extends StatelessWidget {
  const _EmployeeDetailsSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray300,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _SkeletonBox(
                width: 52.w,
                height: 52.w,
                radius: 16.r,
              ),

              horizontalSpace(12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonBox(
                      width: double.infinity,
                      height: 18.h,
                      radius: 8.r,
                    ),

                    verticalSpace(12),

                    _SkeletonBox(
                      width: 180.w,
                      height: 14.h,
                      radius: 8.r,
                    ),

                    verticalSpace(10),

                    _SkeletonBox(
                      width: 120.w,
                      height: 14.h,
                      radius: 8.r,
                    ),
                  ],
                ),
              ),
            ],
          ),

          verticalSpace(16),

          Row(
            children: [
              Expanded(
                child: _SkeletonBox(
                  width: double.infinity,
                  height: 44.h,
                  radius: 12.r,
                ),
              ),

              horizontalSpace(10),

              Expanded(
                child: _SkeletonBox(
                  width: double.infinity,
                  height: 44.h,
                  radius: 12.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.radius,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorPalette.gray200,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}