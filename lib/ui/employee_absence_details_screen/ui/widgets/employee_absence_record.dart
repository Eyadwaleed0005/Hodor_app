import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/ui/employee_absence_details_screen/ui/widgets/employee_absence_empty_view.dart';

class AbsenceRecord {
  final String date;

  const AbsenceRecord({
    required this.date,
  });
}

class EmployeeAbsenceRecord extends StatelessWidget {
  final List<AbsenceRecord> records;

  const EmployeeAbsenceRecord({
    super.key,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سجل الغيابات',
            style: Textstyles.font20BlackBold(),
          ),

          verticalSpace(12),

          if (records.isEmpty)
            const EmployeeAbsenceEmptyView()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: records.length,
              separatorBuilder: (_, __) => verticalSpace(12),
              itemBuilder: (context, index) {
                return _AbsenceRecordCard(
                  absenceDate: records[index].date,
                );
              },
            ),
        ],
      ),
    );
  }
}

class _AbsenceRecordCard extends StatelessWidget {
  final String absenceDate;

  const _AbsenceRecordCard({
    required this.absenceDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: ColorPalette.red.withOpacity(.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              color: ColorPalette.red,
              size: 22.sp,
            ),
          ),

          horizontalSpace(12),

          Text(
            absenceDate,
            style: Textstyles.font18BlackBold(),
          ),

          const Spacer(),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 7.h,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.red.withOpacity(.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              'غياب',
              style: Textstyles.font12RedBold(),
            ),
          ),
        ],
      ),
    );
  }
}