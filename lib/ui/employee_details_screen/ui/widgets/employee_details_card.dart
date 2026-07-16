import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/helper/employee_name_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/default_bottom_sheet.dart';
import 'package:Hodor/ui/employee_details_screen/ui/widgets/employee_card_actions.dart';
import 'package:Hodor/ui/employee_details_screen/ui/widgets/employee_details_bottom_sheet.dart';

class EmployeeDetailsCard extends StatelessWidget {
  const EmployeeDetailsCard({
    super.key,
    required this.employeeName,
    required this.age,
    required this.salary,
    required this.absentDays,
    required this.createdAt,
    required this.isPresent,
    required this.onViewTap,
    required this.onDeleteTap,
  });

  final String employeeName;
  final int age;
  final double salary;
  final int absentDays;
  final String createdAt;
  final bool isPresent;
  final VoidCallback onViewTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: ColorPalette.gray300, width: 1.w),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52.w,
                  height: 52.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorPalette.blue,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    EmployeeNameHelper.getInitials(employeeName),
                    style: Textstyles.font20WhiteExtraBold(),
                  ),
                ),

                horizontalSpace(12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              employeeName,
                              style: Textstyles.font18BlackBold(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Container(
                            height: 34.h,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isPresent
                                  ? ColorPalette.green.withOpacity(0.12)
                                  : ColorPalette.red.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isPresent
                                    ? ColorPalette.green
                                    : ColorPalette.red,
                                width: 1.2.w,
                              ),
                            ),
                            child: Text(
                              isPresent ? 'حاضر' : 'غائب',
                              style: Textstyles.font14BlackMedium().copyWith(
                                color: isPresent
                                    ? ColorPalette.green
                                    : ColorPalette.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      verticalSpace(25),

                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'العمر: ',
                                  style: Textstyles.font14Grey500Medium(),
                                ),
                                TextSpan(
                                  text: '$age',
                                  style: Textstyles.font14BlackMedium(),
                                ),
                              ],
                            ),
                          ),

                          Text('·', style: Textstyles.font14Grey500Medium()),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'الراتب: ',
                                  style: Textstyles.font14Grey500Medium(),
                                ),
                                TextSpan(
                                  text: '${salary.toStringAsFixed(0)}ج.م',
                                  style: Textstyles.font14BlackMedium(),
                                ),
                              ],
                            ),
                          ),

                          Text('·', style: Textstyles.font14Grey500Medium()),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$absentDays ',
                                  style: Textstyles.font14BlackMedium()
                                      .copyWith(
                                        color: ColorPalette.red,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                TextSpan(
                                  text: 'غياب',
                                  style: Textstyles.font14BlackMedium()
                                      .copyWith(
                                        color: ColorPalette.red,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      verticalSpace(8),

                      Text(
                        'أُضيف في: ${AppDateHelper.formatDatabaseDateToArabic(createdAt)}',
                        style: Textstyles.font14Grey500Medium(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            verticalSpace(16),
            EmployeeCardActions(
              onViewTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: EmployeeDetailsBottomSheet(
                        employeeName: employeeName,
                        age: age,
                        salary: salary,
                        absentDays: absentDays,
                        createdAt: createdAt,
                        isPresent: isPresent,
                      ),
                    );
                  },
                );
              },
              onDeleteTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: DefaultBottomSheet(
                        icon: Icons.delete_outline_rounded,
                        iconColor: ColorPalette.red,
                        iconBackgroundColor: ColorPalette.red.withOpacity(0.12),
                        title: 'حذف الموظف',
                        description: Text(
                          'هل أنت متأكد أنك تريد حذف هذا الموظف؟ لا يمكن التراجع عن هذا الإجراء.',
                          style: Textstyles.font14Grey500Medium(),
                          textAlign: TextAlign.center,
                        ),
                        content: Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: ColorPalette.gray100,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: ColorPalette.gray300),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorPalette.blue,
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Text(
                                  EmployeeNameHelper.getInitials(employeeName),
                                  style: Textstyles.font20WhiteExtraBold(),
                                ),
                              ),

                              horizontalSpace(12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      employeeName,
                                      style: Textstyles.font16BlackBold(),
                                    ),

                                    verticalSpace(4),

                                    Text(
                                      'تاريخ التسجيل: ${AppDateHelper.formatDatabaseDateToArabic(createdAt)}',
                                      style: Textstyles.font14Grey500Medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        primaryButtonTitle: 'حذف',
                        primaryButtonColor: ColorPalette.red,
                        onPrimaryPressed: () {
                          Navigator.pop(context);
                          onDeleteTap();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
