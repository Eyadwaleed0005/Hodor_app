import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/core/style/textstyles.dart';

class EmployeeAbsenceCalendar extends StatelessWidget {
  final List<String> absenceDates;

  const EmployeeAbsenceCalendar({
    super.key,
    required this.absenceDates,
  });

  @override
  Widget build(BuildContext context) {
    final now = AppDateHelper.now;
    final daysInMonth = AppDateHelper.currentMonthDaysCount();

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Text(
                  '${AppDateHelper.arabicMonthName(now.month)} ${now.year}',
                  style: Textstyles.font20BlackBold(),
                ),
                const Spacer(),
                const _CalendarStatusDot(color: ColorPalette.red),
                horizontalSpace(6),
                Text(
                  'يوم غياب',
                  style: Textstyles.font16Gray400Bold(),
                ),
                horizontalSpace(12),
                const _CalendarStatusDot(color: ColorPalette.blue),
                horizontalSpace(6),
                Text(
                  'اليوم',
                  style: Textstyles.font16Gray400Bold(),
                ),
              ],
            ),
          ),

          verticalSpace(18),

          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: const [
                _WeekDayItem(text: 'س'),
                _WeekDayItem(text: 'ح'),
                _WeekDayItem(text: 'ن'),
                _WeekDayItem(text: 'ث'),
                _WeekDayItem(text: 'ر'),
                _WeekDayItem(text: 'خ'),
                _WeekDayItem(text: 'ج'),
              ],
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: GridView.builder(
              itemCount: daysInMonth,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final day = index + 1;

                final dateKey = AppDateHelper.dateDatabaseFormat(
                  year: now.year,
                  month: now.month,
                  day: day,
                );

                final isToday = day == now.day;
                final isAbsence = absenceDates.contains(dateKey);

                return _CalendarDayItem(
                  day: day,
                  isToday: isToday,
                  isAbsence: isAbsence,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarDayItem extends StatelessWidget {
  final int day;
  final bool isToday;
  final bool isAbsence;

  const _CalendarDayItem({
    required this.day,
    required this.isToday,
    required this.isAbsence,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isToday
        ? ColorPalette.blue
        : isAbsence
            ? ColorPalette.red
            : ColorPalette.black;

    final Color backgroundColor = isToday
        ? ColorPalette.blue.withOpacity(.12)
        : isAbsence
            ? ColorPalette.red.withOpacity(.12)
            : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isToday ? ColorPalette.blue : Colors.transparent,
        ),
      ),
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            fontFamily: Textstyles.tajawal,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _WeekDayItem extends StatelessWidget {
  final String text;

  const _WeekDayItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: Textstyles.font16Gray400Bold(),
        ),
      ),
    );
  }
}

class _CalendarStatusDot extends StatelessWidget {
  final Color color;

  const _CalendarStatusDot({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 4.r,
      backgroundColor: color,
    );
  }
}