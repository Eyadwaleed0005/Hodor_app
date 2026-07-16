import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';

class ArchiveSkeletonLoading extends StatelessWidget {
  const ArchiveSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ArchiveStatusCardsSkeleton(),
        verticalSpace(24),
        const _ArchiveMonthCardSkeleton(),
        verticalSpace(12),
        const _ArchiveMonthCardSkeleton(),
        verticalSpace(12),
        const _ArchiveMonthCardSkeleton(),
      ],
    );
  }
}

class _ArchiveStatusCardsSkeleton extends StatelessWidget {
  const _ArchiveStatusCardsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          const Expanded(
            child: _SkeletonBox(height: 110),
          ),
          horizontalSpace(8),
          const Expanded(
            child: _SkeletonBox(height: 110),
          ),
          horizontalSpace(8),
          const Expanded(
            child: _SkeletonBox(height: 110),
          ),
        ],
      ),
    );
  }
}

class _ArchiveMonthCardSkeleton extends StatelessWidget {
  const _ArchiveMonthCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const _SkeletonBox(
            width: 160,
            height: 18,
          ),
          verticalSpace(14),
          const _SkeletonBox(
            height: 12,
          ),
          verticalSpace(10),
          const _SkeletonBox(
            width: 220,
            height: 12,
          ),
          verticalSpace(18),
          const _SkeletonBox(
            height: 9,
          ),
          verticalSpace(18),
          const _SkeletonBox(
            height: 44,
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatefulWidget {
  const _SkeletonBox({
    this.width,
    required this.height,
  });

  final double? width;
  final double height;

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat(reverse: true);

    opacity = Tween<double>(
      begin: 0.35,
      end: 1,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Container(
        width: widget.width?.w ?? double.infinity,
        height: widget.height.h,
        decoration: BoxDecoration(
          color: ColorPalette.gray200,
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
    );
  }
}