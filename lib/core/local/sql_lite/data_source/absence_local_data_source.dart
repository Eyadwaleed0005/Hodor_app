import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/local/sql_lite/sql_lite_app_database.dart';
import 'package:Hodor/core/models/employee_absence_model.dart';
import 'package:Hodor/core/models/employee_model.dart';
import 'package:sqflite/sqflite.dart';

class AbsenceLocalDataSource {
  final AppDatabase _appDatabase;

  AbsenceLocalDataSource({AppDatabase? appDatabase})
    : _appDatabase = appDatabase ?? AppDatabase.instance;

  Future<int> addAbsence({
    required int employeeId,
    required String absenceDate,
  }) async {
    final database = await _appDatabase.database;

    return database.insert('employee_absences', {
      'employeeId': employeeId,
      'absenceDate': absenceDate,
      'createdAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> markEmployeeAbsentToday(int employeeId) {
    return addAbsence(
      employeeId: employeeId,
      absenceDate: AppDateHelper.todayDatabaseFormat(),
    );
  }

  Future<List<EmployeeAbsenceModel>> getEmployeeAbsenceDays({
    required int employeeId,
    String? monthKey,
  }) async {
    final database = await _appDatabase.database;

    final whereClause = monthKey == null
        ? 'employeeId = ?'
        : '''
          employeeId = ?
          AND substr(absenceDate, 1, 7) = ?
        ''';

    final whereArguments = <Object?>[
      employeeId,
      if (monthKey != null) monthKey,
    ];

    final result = await database.query(
      'employee_absences',
      where: whereClause,
      whereArgs: whereArguments,
      orderBy: 'absenceDate DESC',
    );

    return result.map(EmployeeAbsenceModel.fromMap).toList();
  }

  Future<int> deleteAbsenceDay(int absenceId) async {
    final database = await _appDatabase.database;

    return database.delete(
      'employee_absences',
      where: 'id = ?',
      whereArgs: [absenceId],
    );
  }

  Future<int> getAbsentEmployeesCountByDate(String date) async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery(
      '''
      SELECT
        COUNT(DISTINCT employeeId) AS count
      FROM employee_absences
      WHERE substr(absenceDate, 1, 10) = ?
      ''',
      [date],
    );

    return (result.first['count'] as num?)?.toInt() ?? 0;
  }

  Future<int> getTodayAbsentCount() {
    return getAbsentEmployeesCountByDate(AppDateHelper.todayDatabaseFormat());
  }

  Future<int> getAbsencesCountByMonth(String monthKey) async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery(
      '''
      SELECT
        COUNT(*) AS count
      FROM employee_absences
      WHERE substr(absenceDate, 1, 7) = ?
      ''',
      [monthKey],
    );

    return (result.first['count'] as num?)?.toInt() ?? 0;
  }

  Future<int> getCurrentMonthAbsencesCount() {
    return getAbsencesCountByMonth(AppDateHelper.currentMonthDatabasePrefix());
  }

  Future<List<EmployeeModel>> getAbsentEmployeesByDate(String date) async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery(
      '''
      SELECT
        employees.id,
        employees.name,
        employees.age,
        employees.salary,
        employees.createdAt,

        0 AS isPresent,

        COUNT(
          employee_absences.id
        ) AS absentDays

      FROM employees

      INNER JOIN employee_absences
        ON employee_absences.employeeId =
          employees.id

      WHERE substr(
        employee_absences.absenceDate,
        1,
        10
      ) = ?

      GROUP BY
        employees.id,
        employees.name,
        employees.age,
        employees.salary,
        employees.createdAt

      ORDER BY employees.id DESC
      ''',
      [date],
    );

    return result.map(EmployeeModel.fromMap).toList();
  }

  Future<List<EmployeeModel>> getTodayAbsentEmployees() {
    return getAbsentEmployeesByDate(AppDateHelper.todayDatabaseFormat());
  }

  Future<List<EmployeeModel>> getEmployeesAttendanceByDate(String date) async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery(
      '''
      SELECT
        employees.id,
        employees.name,
        employees.age,
        employees.salary,
        employees.createdAt,

        CASE
          WHEN EXISTS (
            SELECT 1
            FROM employee_absences
            WHERE employee_absences.employeeId =
              employees.id
            AND substr(
              employee_absences.absenceDate,
              1,
              10
            ) = ?
          )
          THEN 0
          ELSE 1
        END AS isPresent,

        0 AS absentDays

      FROM employees

      ORDER BY employees.id DESC
      ''',
      [date],
    );

    return result.map(EmployeeModel.fromMap).toList();
  }
}
