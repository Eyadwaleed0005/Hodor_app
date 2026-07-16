import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.width,
    this.height,
    this.contentPadding,
    this.prefixIcon,
    this.enabled = true,
    this.errorText,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final IconData? prefixIcon;
  final bool enabled;
  final String? errorText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final borderRadius = 14.r;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextSelectionTheme(
          data: TextSelectionThemeData(
            cursorColor: ColorPalette.blue,
            selectionColor: ColorPalette.blue.withOpacity(.15),
            selectionHandleColor: ColorPalette.blue,
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.isPassword ? _obscurePassword : false,
            enabled: widget.enabled,
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            textAlign: TextAlign.right,
            cursorColor: ColorPalette.blue,
            cursorWidth: 1.5.w,
            cursorRadius: Radius.circular(2.r),
            cursorHeight: 16.h,
            style: Textstyles.font18BlackRegular(),
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              errorText: widget.errorText,
              labelStyle: Textstyles.font14Gray500Regular().copyWith(
                color: ColorPalette.gray500,
              ),
              floatingLabelStyle: Textstyles.font14Gray500Regular().copyWith(
                color: ColorPalette.blue,
                fontSize: 11.sp,
              ),
              hintStyle: Textstyles.font18Gray500Regular().copyWith(
                color: ColorPalette.gray400,
              ),
              filled: true,
              fillColor:
                  widget.enabled ? ColorPalette.white : ColorPalette.offWhite,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      size: 20.sp,
                      color: ColorPalette.gray400,
                    )
                  : null,
              suffixIcon: !widget.enabled
                  ? Icon(
                      Icons.lock_outline_rounded,
                      color: ColorPalette.gray400,
                      size: 18.sp,
                    )
                  : widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: ColorPalette.gray400,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        )
                      : null,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: ColorPalette.gray200,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: ColorPalette.blue,
                  width: 1.2.w,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: ColorPalette.gray200,
                  width: 1.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 1.w,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 1.2.w,
                ),
              ),
              errorStyle: Textstyles.font12RedRegular(),
              errorMaxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}