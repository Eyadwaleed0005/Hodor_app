import 'package:sqflite/sqflite.dart';

class SqlLiteSchema {
  SqlLiteSchema._();

  static Future<void> create(
    Database database,
    int version,
  ) async {
    await _createEmployeesTable(database);

    await _createEmployeeAbsencesTable(database);

    await _createMonthlyArchivesTable(database);

    await _createMonthlyEmployeeArchivesTable(
      database,
    );

    await createAppSettingsTable(database);

    await insertAppStartedAtIfNeeded(database);
  }

  static Future<void> _createEmployeesTable(
    Database database,
  ) async {
    await database.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        salary REAL NOT NULL,
        isPresent INTEGER NOT NULL DEFAULT 1,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _createEmployeeAbsencesTable(
    Database database,
  ) async {
    await database.execute('''
      CREATE TABLE employee_absences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employeeId INTEGER NOT NULL,
        absenceDate TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        UNIQUE(employeeId, absenceDate),
        FOREIGN KEY (employeeId)
          REFERENCES employees(id)
          ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> _createMonthlyArchivesTable(
    Database database,
  ) async {
    await database.execute('''
      CREATE TABLE monthly_archives (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        monthKey TEXT NOT NULL UNIQUE,
        monthName TEXT NOT NULL,
        daysInMonth INTEGER NOT NULL,
        employeesCount INTEGER NOT NULL,
        totalAbsentDays INTEGER NOT NULL,
        commitmentPercentage REAL NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  static Future<void>
      _createMonthlyEmployeeArchivesTable(
    Database database,
  ) async {
    await database.execute('''
      CREATE TABLE monthly_employee_archives (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        archiveId INTEGER NOT NULL,
        employeeId INTEGER NOT NULL,
        employeeName TEXT NOT NULL,
        salary REAL NOT NULL,
        absentDays INTEGER NOT NULL,
        workDays INTEGER NOT NULL,
        commitmentPercentage REAL NOT NULL,
        createdAt TEXT NOT NULL,
        UNIQUE(archiveId, employeeId),
        FOREIGN KEY (archiveId)
          REFERENCES monthly_archives(id)
          ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> createAppSettingsTable(
    Database database,
  ) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS app_settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  static Future<void> insertAppStartedAtIfNeeded(
    Database database,
  ) async {
    final result = await database.query(
      'app_settings',
      where: 'key = ?',
      whereArgs: ['appStartedAt'],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return;
    }

    await database.insert(
      'app_settings',
      {
        'key': 'appStartedAt',
        'value': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}