import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';
import 'package:Hodor/core/widgets/title_section.dart';

class TodaySummaryCard extends StatelessWidget {
  final String date;
  final int presentCount;
  final int absentCount;
  final int vacationCount;

  const TodaySummaryCard({
    super.key,
    required this.date,
    required this.presentCount,
    required this.absentCount,
    required this.vacationCount,
  });

  String get formattedDate {
    final parsedDate = DateTime.tryParse(date);

    if (parsedDate == null) {
      return date;
    }

    return '${AppDateHelper.arabicDayName(parsedDate.weekday)}، '
        '${parsedDate.day} '
        '${AppDateHelper.arabicMonthName(parsedDate.month)} '
        '${parsedDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: ColorPalette.gray200,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      formattedDate,
                      overflow: TextOverflow.ellipsis,
                      style: Textstyles.font18Gray500Regular(),
                    ),
                  ),
                ),
              ),

              horizontalSpace(12),

              const TitleSection(
                title: 'ملخص اليوم',
              ),
            ],
          ),

          verticalSpace(20),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      vacationCount.toString(),
                      style: Textstyles.font20BlackBold().copyWith(
                        color: ColorPalette.gray500,
                      ),
                    ),
                    verticalSpace(6),
                    Text(
                      'إجازة',
                      style: Textstyles.font18Gray500Regular(),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    Text(
                      absentCount.toString(),
                      style: Textstyles.font20BlackBold().copyWith(
                        color: ColorPalette.red,
                      ),
                    ),
                    verticalSpace(6),
                    Text(
                      'غياب',
                      style: Textstyles.font18Gray500Regular(),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    Text(
                      presentCount.toString(),
                      style: Textstyles.font20GreenBold(),
                    ),
                    verticalSpace(6),
                    Text(
                      'حاضر',
                      style: Textstyles.font18Gray500Regular(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}