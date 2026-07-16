import 'package:sqflite/sqflite.dart';

import 'sql_lite_schema.dart';

class SqlLiteMigrations {
  SqlLiteMigrations._();

  static Future<void> upgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 5) {
      await SqlLiteSchema.createAppSettingsTable(
        database,
      );

      await SqlLiteSchema.insertAppStartedAtIfNeeded(
        database,
      );
    }
  }
}