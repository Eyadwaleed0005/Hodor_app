import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/app_loading_indicator.dart';


class StartContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;

  const StartContinueButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.text = 'متابعة',
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null || isLoading;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.blue,
          disabledBackgroundColor: ColorPalette.blue.withValues(alpha: 0.55),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const AppLoadingIndicator()
              : Text(text, style: Textstyles.font22whiteSemiBold()),
        ),
      ),
    );
  }
}
