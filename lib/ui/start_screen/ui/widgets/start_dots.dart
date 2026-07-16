import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';

class StartDots extends StatelessWidget {
  final int activeIndex; 
  const StartDots({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final bool active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: active ? 20.w : 8.w,
          height: 8.w,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: active ? ColorPalette.blue : ColorPalette.gray300,
          ),
        );
      }),
    );
  }
}
