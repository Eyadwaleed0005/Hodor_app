import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'sql_lite_migrations.dart';
import 'sql_lite_schema.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'Hodor.db',
    );

    return openDatabase(
      path,
      version: 5,
      onConfigure: (database) async {
        await database.execute(
          'PRAGMA foreign_keys = ON',
        );
      },
      onCreate: SqlLiteSchema.create,
      onUpgrade: SqlLiteMigrations.upgrade,
    );
  }

  Future<void> closeDatabase() async {
    if (_database == null) {
      return;
    }

    await _database!.close();

    _database = null;
  }
}