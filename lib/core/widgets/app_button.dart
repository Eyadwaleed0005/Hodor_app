import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_loading_indicator.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.isEnabled = true,
    required this.isLoading,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
  });

  final bool isEnabled;
  final bool isLoading;
  final VoidCallback? onPressed;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? (backgroundColor ?? ColorPalette.blue)
              : ColorPalette.gray200,
          disabledBackgroundColor: ColorPalette.gray200,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.w,
                child: const AppLoadingIndicator(color: ColorPalette.blue),
              )
            : Text(
                title,
                style: enabled
                    ? Textstyles.font22WhiteBold()
                    : Textstyles.font16Gray400Bold(),
              ),
      ),
    );
  }
}
