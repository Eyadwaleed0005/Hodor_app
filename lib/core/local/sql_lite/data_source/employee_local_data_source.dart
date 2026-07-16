import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/local/sql_lite/sql_lite_app_database.dart';
import 'package:Hodor/core/models/employee_model.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeLocalDataSource {
  final AppDatabase _appDatabase;

  EmployeeLocalDataSource({AppDatabase? appDatabase})
    : _appDatabase = appDatabase ?? AppDatabase.instance;

  Future<int> addEmployee(EmployeeModel employee) async {
    final database = await _appDatabase.database;

    return database.insert('employees', employee.toInsertMap());
  }

  Future<List<EmployeeModel>> getEmployees() async {
    final database = await _appDatabase.database;

    final today = AppDateHelper.todayDatabaseFormat();

    final monthKey = AppDateHelper.currentMonthDatabasePrefix();

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
            WHERE employee_absences.employeeId = employees.id
              AND employee_absences.absenceDate = ?
          )
          THEN 0
          ELSE 1
        END AS isPresent,

        COUNT(employee_absences.id) AS absentDays

      FROM employees

      LEFT JOIN employee_absences
        ON employees.id = employee_absences.employeeId
        AND substr(employee_absences.absenceDate, 1, 7) = ?

      GROUP BY
        employees.id,
        employees.name,
        employees.age,
        employees.salary,
        employees.createdAt

      ORDER BY employees.id DESC
      ''',
      [today, monthKey],
    );

    return result.map(EmployeeModel.fromMap).toList();
  }

  Future<EmployeeModel?> getEmployeeById(int employeeId) async {
    final database = await _appDatabase.database;

    final today = AppDateHelper.todayDatabaseFormat();

    final monthKey = AppDateHelper.currentMonthDatabasePrefix();

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
            WHERE employee_absences.employeeId = employees.id
              AND employee_absences.absenceDate = ?
          )
          THEN 0
          ELSE 1
        END AS isPresent,

        COUNT(employee_absences.id) AS absentDays

      FROM employees

      LEFT JOIN employee_absences
        ON employees.id = employee_absences.employeeId
        AND substr(employee_absences.absenceDate, 1, 7) = ?

      WHERE employees.id = ?

      GROUP BY
        employees.id,
        employees.name,
        employees.age,
        employees.salary,
        employees.createdAt

      LIMIT 1
      ''',
      [today, monthKey, employeeId],
    );

    if (result.isEmpty) {
      return null;
    }

    return EmployeeModel.fromMap(result.first);
  }

  Future<int> updateEmployee(EmployeeModel employee) async {
    if (employee.id == null) {
      throw ArgumentError('Employee id is required for update');
    }

    final database = await _appDatabase.database;

    return database.update(
      'employees',
      employee.toUpdateMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int employeeId) async {
    final database = await _appDatabase.database;

    return database.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [employeeId],
    );
  }

  Future<int> getEmployeesCount() async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery('''
    SELECT COUNT(*) AS count
    FROM employees
    ''');

    return (result.first['count'] as num?)?.toInt() ?? 0;
  }

  Future<int> getTodayAbsentCount() async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery(
      '''
    SELECT COUNT(DISTINCT employeeId) AS count
    FROM employee_absences
    WHERE absenceDate = ?
    ''',
      [AppDateHelper.todayDatabaseFormat()],
    );

    return (result.first['count'] as num?)?.toInt() ?? 0;
  }

  Future<List<EmployeeModel>> getTodayAbsentEmployees() async {
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
      COUNT(employee_absences.id) AS absentDays

    FROM employees

    INNER JOIN employee_absences
      ON employees.id = employee_absences.employeeId

    WHERE employee_absences.absenceDate = ?

    GROUP BY
      employees.id,
      employees.name,
      employees.age,
      employees.salary,
      employees.createdAt

    ORDER BY employees.id DESC
    ''',
      [AppDateHelper.todayDatabaseFormat()],
    );

    return result.map(EmployeeModel.fromMap).toList();
  }

  Future<int> getMonthAbsencesCount() async {
    final database = await _appDatabase.database;

    final result = await database.rawQuery(
      '''
    SELECT COUNT(*) AS count
    FROM employee_absences
    WHERE substr(absenceDate, 1, 7) = ?
    ''',
      [AppDateHelper.currentMonthDatabasePrefix()],
    );

    return (result.first['count'] as num?)?.toInt() ?? 0;
  }

  Future<int> markEmployeeAbsent(int employeeId) async {
    final database = await _appDatabase.database;

    return database.insert('employee_absences', {
      'employeeId': employeeId,
      'absenceDate': AppDateHelper.todayDatabaseFormat(),
      'createdAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getEmployeeAbsenceDays(
    int employeeId,
  ) async {
    final database = await _appDatabase.database;

    return database.query(
      'employee_absences',
      where: 'employeeId = ?',
      whereArgs: [employeeId],
      orderBy: 'absenceDate DESC',
    );
  }
}
