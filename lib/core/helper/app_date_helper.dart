class AppDateHelper {
  AppDateHelper._();

  static DateTime get now => DateTime.now();

  static String todayDatabaseFormat() {
    return dateToDatabaseFormat(now);
  }

  static String todayFullArabicDate() {
    return dateToFullArabicDate(now);
  }

  static String todayShortArabicDate() {
    return dateToArabicDate(now);
  }

  static String todayDayMonthArabicDate() {
    return dateToDayMonthArabicDate(now);
  }

  static int todayDayNumber() {
    return now.day;
  }

  static String currentMonthDatabasePrefix() {
    final date = now;

    return monthDatabaseKey(year: date.year, month: date.month);
  }

  static int currentMonthDaysCount() {
    final date = now;

    return monthDaysCount(year: date.year, month: date.month);
  }

  static String monthDatabaseKey({required int year, required int month}) {
    final formattedMonth = month.toString().padLeft(2, '0');

    return '$year-$formattedMonth';
  }

  static String monthKeyToArabicMonthWithYear(String monthKey) {
    final parts = monthKey.split('-');

    if (parts.length < 2) {
      return monthKey;
    }

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);

    if (year == null || month == null) {
      return monthKey;
    }

    final monthName = arabicMonthName(month);

    if (monthName.isEmpty) {
      return monthKey;
    }

    return '$monthName $year';
  }

  static DateTime previousMonthDate() {
    final date = now;

    return DateTime(date.year, date.month - 1);
  }

  static String previousMonthDatabaseKey() {
    final date = previousMonthDate();

    return monthDatabaseKey(year: date.year, month: date.month);
  }

  static int monthDaysCount({required int year, required int month}) {
    return DateTime(year, month + 1, 0).day;
  }

  static String monthStartDate({required int year, required int month}) {
    final monthKey = monthDatabaseKey(year: year, month: month);

    return '$monthKey-01';
  }

  static String monthEndDate({required int year, required int month}) {
    final monthKey = monthDatabaseKey(year: year, month: month);

    final daysCount = monthDaysCount(year: year, month: month);

    final formattedDay = daysCount.toString().padLeft(2, '0');

    return '$monthKey-$formattedDay';
  }

  static String dateDatabaseFormat({
    required int year,
    required int month,
    required int day,
  }) {
    final formattedMonth = month.toString().padLeft(2, '0');

    final formattedDay = day.toString().padLeft(2, '0');

    return '$year-$formattedMonth-$formattedDay';
  }

  static String dateToDatabaseFormat(DateTime date) {
    final year = date.year.toString();

    final month = date.month.toString().padLeft(2, '0');

    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static String formatDatabaseDateToArabic(String date) {
    final parsedDate = DateTime.tryParse(date);

    if (parsedDate == null) {
      return date;
    }

    return dateToArabicDate(parsedDate);
  }

  static String dateToArabicDate(DateTime date) {
    return '${date.day} '
        '${arabicMonthName(date.month)} '
        '${date.year}';
  }

  static String dateToDayMonthArabicDate(DateTime date) {
    return '${date.day} '
        '${arabicMonthName(date.month)}';
  }

  static String dateToFullArabicDate(DateTime date) {
    return '${arabicDayName(date.weekday)}، '
        '${date.day} '
        '${arabicMonthName(date.month)} '
        '${date.year}';
  }

  static String arabicDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'الاثنين';

      case DateTime.tuesday:
        return 'الثلاثاء';

      case DateTime.wednesday:
        return 'الأربعاء';

      case DateTime.thursday:
        return 'الخميس';

      case DateTime.friday:
        return 'الجمعة';

      case DateTime.saturday:
        return 'السبت';

      case DateTime.sunday:
        return 'الأحد';

      default:
        return '';
    }
  }

  static String arabicMonthName(int month) {
    switch (month) {
      case DateTime.january:
        return 'يناير';

      case DateTime.february:
        return 'فبراير';

      case DateTime.march:
        return 'مارس';

      case DateTime.april:
        return 'أبريل';

      case DateTime.may:
        return 'مايو';

      case DateTime.june:
        return 'يونيو';

      case DateTime.july:
        return 'يوليو';

      case DateTime.august:
        return 'أغسطس';

      case DateTime.september:
        return 'سبتمبر';

      case DateTime.october:
        return 'أكتوبر';

      case DateTime.november:
        return 'نوفمبر';

      case DateTime.december:
        return 'ديسمبر';

      default:
        return '';
    }
  }
}
