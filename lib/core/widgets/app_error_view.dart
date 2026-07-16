import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class AppErrorView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  final String retryButtonText;
  final IconData icon;
  final Color color;

  const AppErrorView({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.retryButtonText = 'إعادة المحاولة',
    this.icon = Icons.error_outline_rounded,
    this.color = ColorPalette.red,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 40.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 38.sp,
              ),
            ),
            verticalSpace(16),
            Text(
              title,
              style: Textstyles.font18BlackBold(),
              textAlign: TextAlign.center,
            ),
            verticalSpace(8),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              verticalSpace(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(
                    Icons.refresh_rounded,
                  ),
                  label: Text(
                    retryButtonText,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}