import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/ui/record_absence_screen/ui/widgets/employee_action_button.dart';

class EmployeeAbsenceCard extends StatelessWidget {
  final String employeeName;
  final Color avatarColor;
  final bool isPresent;
  final VoidCallback onHistoryTap;
  final VoidCallback onRegisterAbsenceTap;

  const EmployeeAbsenceCard({
    super.key,
    required this.employeeName,
    required this.avatarColor,
    required this.isPresent,
    required this.onHistoryTap,
    required this.onRegisterAbsenceTap,
  });

  @override
  Widget build(BuildContext context) {
    final employeeInitials = EmployeeNameHelper.getInitials(employeeName);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.w,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isPresent
                        ? avatarColor
                        : ColorPalette.red.withOpacity(.12),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    employeeInitials,
                    style: Textstyles.font18WhiteBold().copyWith(
                      color: isPresent
                          ? ColorPalette.white
                          : ColorPalette.red,
                    ),
                  ),
                ),
                if (!isPresent)
                  Positioned(
                    left: -4.w,
                    bottom: -4.h,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: ColorPalette.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorPalette.white,
                          width: 2.w,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: ColorPalette.white,
                          size: 12.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            horizontalSpace(12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          employeeName,
                          textAlign: TextAlign.right,
                          softWrap: true,
                          style: Textstyles.font18BlacksemiBold(),
                        ),
                      ),

                      horizontalSpace(12),

                      if (isPresent)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorPalette.green.withOpacity(.12),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'حاضر',
                            style: Textstyles.font18GreenSemiBold(),
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorPalette.red.withOpacity(.08),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: ColorPalette.red.withOpacity(.35),
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            'تم تسجيل الغياب',
                            style: Textstyles.font13RedBold(),
                          ),
                        ),
                    ],
                  ),

                  verticalSpace(12),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EmployeeActionButton(
                          title: 'السجل',
                          icon: Icons.history_rounded,
                          backgroundColor: ColorPalette.gray200,
                          textColor: ColorPalette.gray500,
                          onTap: onHistoryTap,
                        ),

                        if (isPresent) ...[
                          horizontalSpace(12),
                          EmployeeActionButton(
                            title: 'تسجيل غياب',
                            icon: Icons.event_busy_outlined,
                            backgroundColor: ColorPalette.red,
                            textColor: ColorPalette.white,
                            onTap: onRegisterAbsenceTap,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}