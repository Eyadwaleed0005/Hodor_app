import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/local/sql_lite/sql_lite_app_database.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_archive_model.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_employee_archive_model.dart';
import 'package:sqflite/sqflite.dart';

class ArchiveLocalDataSource {
  final AppDatabase _appDatabase;

  ArchiveLocalDataSource({AppDatabase? appDatabase})
    : _appDatabase = appDatabase ?? AppDatabase.instance;

  String _monthKeyFromDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$year-$month';
  }

  Future<List<MonthlyArchiveModel>> getMonthlyArchives() async {
    final database = await _appDatabase.database;

    final result = await database.query(
      'monthly_archives',
      orderBy: 'monthKey DESC',
    );

    return result
        .map((archive) => MonthlyArchiveModel.fromMap(archive))
        .toList();
  }

  Future<MonthlyArchiveModel?> getMonthlyArchiveByMonthKey(
    String monthKey,
  ) async {
    final database = await _appDatabase.database;

    final result = await database.query(
      'monthly_archives',
      where: 'monthKey = ?',
      whereArgs: [monthKey],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return MonthlyArchiveModel.fromMap(result.first);
  }

  Future<List<MonthlyEmployeeArchiveModel>> getMonthlyEmployeeArchives(
    int archiveId,
  ) async {
    final database = await _appDatabase.database;

    final result = await database.query(
      'monthly_employee_archives',
      where: 'archiveId = ?',
      whereArgs: [archiveId],
      orderBy: 'commitmentPercentage DESC',
    );

    return result
        .map(
          (employeeArchive) =>
              MonthlyEmployeeArchiveModel.fromMap(employeeArchive),
        )
        .toList();
  }

  Future<int> archiveMonth({required int year, required int month}) async {
    final database = await _appDatabase.database;

    final monthKey = AppDateHelper.monthDatabaseKey(year: year, month: month);

    final startDate = AppDateHelper.monthStartDate(year: year, month: month);

    final endDate = AppDateHelper.monthEndDate(year: year, month: month);

    final daysInMonth = AppDateHelper.monthDaysCount(year: year, month: month);

    final now = DateTime.now().toIso8601String();

    return database.transaction((transaction) async {
      final employees = await transaction.rawQuery(
        '''
        SELECT
          employees.id,
          employees.name,
          employees.salary,
          COUNT(employee_absences.id) AS absentDays

        FROM employees

        LEFT JOIN employee_absences
          ON employee_absences.employeeId = employees.id
          AND employee_absences.absenceDate BETWEEN ? AND ?

        WHERE substr(employees.createdAt, 1, 10) <= ?

        GROUP BY
          employees.id,
          employees.name,
          employees.salary
        ''',
        [startDate, endDate, endDate],
      );

      final employeesCount = employees.length;

      if (employeesCount == 0) {
        return 0;
      }

      var totalAbsentDays = 0;

      for (final employee in employees) {
        final absentDays = (employee['absentDays'] as num?)?.toInt() ?? 0;

        totalAbsentDays += absentDays;
      }

      final totalWorkDays = employeesCount * daysInMonth;

      final commitmentPercentage = totalWorkDays == 0
          ? 0.0
          : ((totalWorkDays - totalAbsentDays) / totalWorkDays) * 100;

      await transaction.insert('monthly_archives', {
        'monthKey': monthKey,
        'monthName': AppDateHelper.arabicMonthName(month),
        'daysInMonth': daysInMonth,
        'employeesCount': employeesCount,
        'totalAbsentDays': totalAbsentDays,
        'commitmentPercentage': commitmentPercentage,
        'createdAt': now,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      final archiveResult = await transaction.query(
        'monthly_archives',
        columns: ['id'],
        where: 'monthKey = ?',
        whereArgs: [monthKey],
        limit: 1,
      );

      if (archiveResult.isEmpty) {
        throw StateError('Archive was not created for month $monthKey');
      }

      final archiveId = archiveResult.first['id'] as int;

      await transaction.delete(
        'monthly_employee_archives',
        where: 'archiveId = ?',
        whereArgs: [archiveId],
      );

      for (final employee in employees) {
        final absentDays = (employee['absentDays'] as num?)?.toInt() ?? 0;

        final employeeCommitment = daysInMonth == 0
            ? 0.0
            : ((daysInMonth - absentDays) / daysInMonth) * 100;

        await transaction.insert(
          'monthly_employee_archives',
          {
            'archiveId': archiveId,
            'employeeId': employee['id'],
            'employeeName': employee['name'],
            'salary': employee['salary'],
            'absentDays': absentDays,
            'workDays': daysInMonth,
            'commitmentPercentage': employeeCommitment,
            'createdAt': now,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return archiveId;
    });
  }

  Future<void> autoArchivePreviousMonthIfNeeded() async {
    final database = await _appDatabase.database;

    final previousMonthDate = AppDateHelper.previousMonthDate();

    final previousMonthKey = AppDateHelper.previousMonthDatabaseKey();

    final previousMonthEndDate = AppDateHelper.monthEndDate(
      year: previousMonthDate.year,
      month: previousMonthDate.month,
    );

    final firstEmployeeResult = await database.query(
      'employees',
      columns: ['createdAt'],
      orderBy: 'createdAt ASC',
      limit: 1,
    );

    if (firstEmployeeResult.isEmpty) {
      return;
    }

    final firstEmployeeDate = DateTime.parse(
      firstEmployeeResult.first['createdAt'] as String,
    );

    final firstEmployeeMonthKey = _monthKeyFromDate(firstEmployeeDate);

    final previousMonthIsBeforeFirstEmployee =
        previousMonthKey.compareTo(firstEmployeeMonthKey) < 0;

    if (previousMonthIsBeforeFirstEmployee) {
      return;
    }

    final archivedMonthResult = await database.query(
      'monthly_archives',
      columns: ['id'],
      where: 'monthKey = ?',
      whereArgs: [previousMonthKey],
      limit: 1,
    );

    if (archivedMonthResult.isNotEmpty) {
      return;
    }

    final employeesCountResult = await database.rawQuery(
      '''
      SELECT COUNT(*) AS count
      FROM employees
      WHERE substr(createdAt, 1, 10) <= ?
      ''',
      [previousMonthEndDate],
    );

    final employeesCount =
        (employeesCountResult.first['count'] as num?)?.toInt() ?? 0;

    if (employeesCount == 0) {
      return;
    }

    await archiveMonth(
      year: previousMonthDate.year,
      month: previousMonthDate.month,
    );
  }

  Future<void> deleteArchivesBeforeFirstEmployeeMonth() async {
    final database = await _appDatabase.database;

    await database.transaction((transaction) async {
      final firstEmployeeResult = await transaction.query(
        'employees',
        columns: ['createdAt'],
        orderBy: 'createdAt ASC',
        limit: 1,
      );

      if (firstEmployeeResult.isEmpty) {
        await transaction.delete('monthly_employee_archives');

        await transaction.delete('monthly_archives');

        return;
      }

      final firstEmployeeDate = DateTime.parse(
        firstEmployeeResult.first['createdAt'] as String,
      );

      final firstEmployeeMonthKey = _monthKeyFromDate(firstEmployeeDate);

      final oldArchives = await transaction.query(
        'monthly_archives',
        columns: ['id'],
        where: 'monthKey < ?',
        whereArgs: [firstEmployeeMonthKey],
      );

      for (final archive in oldArchives) {
        await transaction.delete(
          'monthly_employee_archives',
          where: 'archiveId = ?',
          whereArgs: [archive['id']],
        );
      }

      await transaction.delete(
        'monthly_archives',
        where: 'monthKey < ?',
        whereArgs: [firstEmployeeMonthKey],
      );
    });
  }
}
