import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_button.dart';
import 'package:Hodor/core/widgets/secondary_button.dart';

class DefaultBottomSheet extends StatelessWidget {
  const DefaultBottomSheet({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.description,
    required this.content,
    required this.primaryButtonTitle,
    required this.onPrimaryPressed,
    this.secondaryButtonTitle = 'إلغاء',
    this.onSecondaryPressed,
    this.primaryButtonColor = ColorPalette.blue,
    this.isLoading = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final Widget description;
  final Widget content;
  final String primaryButtonTitle;
  final VoidCallback onPrimaryPressed;
  final String secondaryButtonTitle;
  final VoidCallback? onSecondaryPressed;
  final Color primaryButtonColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),

          verticalSpace(24),

          ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 34.sp,
                ),
              ),
            ),
          ),

          verticalSpace(20),

          Text(
            title,
            style: Textstyles.font25BlackBold(),
            textAlign: TextAlign.center,
          ),

          verticalSpace(25),

          description,

          verticalSpace(24),

          SizedBox(
            width: double.infinity,
            child: content,
          ),

          verticalSpace(30),

          Column(
            children: [
              AppButton(
                title: primaryButtonTitle,
                isLoading: isLoading,
                backgroundColor: primaryButtonColor,
                onPressed: onPrimaryPressed,
              ),

              verticalSpace(12),

              SecondaryButton(
                title: secondaryButtonTitle,
                onPressed:
                    onSecondaryPressed ??
                    () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}