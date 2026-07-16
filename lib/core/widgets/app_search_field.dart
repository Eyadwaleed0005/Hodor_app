import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final borderRadius = 12.r;

    return SizedBox(
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextSelectionTheme(
          data: TextSelectionThemeData(
            cursorColor: ColorPalette.blueDark,
            selectionColor: ColorPalette.blueDark.withOpacity(0.18),
            selectionHandleColor: ColorPalette.blueDark,
          ),
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              return TextFormField(
                controller: controller,
                enabled: enabled,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                textAlign: TextAlign.right,
                cursorColor: ColorPalette.blueDark,
                cursorWidth: 1.6.w,
                cursorRadius: Radius.circular(2.r),
                cursorHeight: 15.h,
                style: Textstyles.font18BlackRegular(),
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
                decoration: InputDecoration(
                  labelText: 'البحث عن موظف...',
                  labelStyle: Textstyles.font18Grey500Medium(),
                  floatingLabelStyle: Textstyles.font18Grey500Medium(),
                  filled: true,
                  fillColor:
                      enabled ? ColorPalette.white : ColorPalette.offWhite,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20.sp,
                    color: ColorPalette.gray400,
                  ),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            size: 18.sp,
                            color: ColorPalette.gray400,
                          ),
                          onPressed: () {
                            controller.clear();
                            onChanged?.call('');
                          },
                        )
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: ColorPalette.gray300,
                      width: 1.2.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: ColorPalette.blueDark,
                      width: 1.3.w,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: ColorPalette.gray300,
                      width: 1.2.w,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}