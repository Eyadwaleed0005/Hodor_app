import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';

class ArchiveMonthBottomSheetDragHandle extends StatelessWidget {
  const ArchiveMonthBottomSheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: ColorPalette.gray300,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}