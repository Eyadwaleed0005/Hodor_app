import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class DefaultAppHeader extends StatelessWidget {
  const DefaultAppHeader({super.key, this.onBackTap});

  final VoidCallback? onBackTap;

  void _defaultBack(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.homeScreen,
      (route) => false,
    );
  }

  void _handleBack(BuildContext context) {
    if (onBackTap != null) {
      onBackTap!();
      return;
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      _defaultBack(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: 130.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: ColorPalette.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _handleBack(context),
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorPalette.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: ColorPalette.white.withOpacity(0.2),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorPalette.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  Text('رجوع', style: Textstyles.font20WhiteRegular()),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: 48.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorPalette.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: ColorPalette.white.withOpacity(0.22),
                          ),
                        ),
                        child: Text(
                          'ح',
                          style: Textstyles.font24WhiteExtraBold(),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(12),
                  Text('حضور', style: Textstyles.font20WhiteExtraBold()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
