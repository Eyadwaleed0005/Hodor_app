import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/icons/menu_icon.dart';
import 'package:Hodor/core/widgets/icons/notification_icon.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.onMenuTap,
    this.onNotificationsTap,
  });

  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: 120.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 8,
                    sigmaY: 8,
                  ),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'حضور',
                      style: Textstyles.font20WhiteExtraBold(),
                    ),
                    Text(
                      'إدارة غياب الموظفين',
                      style: Textstyles.font16WhiteRegular(),
                    ),
                  ],
                ),
              ),
              NotificationIcon(
                onTap: onNotificationsTap,
              ),
              horizontalSpace(8),
              MenuIcon(
                onTap: onMenuTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}