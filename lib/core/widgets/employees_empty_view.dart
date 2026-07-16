import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeesEmptyView extends StatelessWidget {
  final IconData icon;
  final String title;

  const EmployeesEmptyView({
    super.key,
    required this.icon,
    required this.title,
  });

  factory EmployeesEmptyView.noSearchResults() {
    return const EmployeesEmptyView(
      icon: Icons.search_off_rounded,
      title: 'لا توجد نتائج للبحث',
    );
  }

  factory EmployeesEmptyView.noEmployeesInDatabase() {
    return const EmployeesEmptyView(
      icon: Icons.people_outline_rounded,
      title: 'لا يوجد موظفين في قاعدة البيانات',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorPalette.gray200, width: 1.w),
      ),
      child: Column(
        children: [
          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              color: ColorPalette.gray200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30.sp, color: ColorPalette.gray400),
          ),
          verticalSpace(14),
          Text(
            title,
            style: Textstyles.font18Gray500Regular(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
