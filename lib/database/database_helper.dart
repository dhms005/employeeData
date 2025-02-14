import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/employee_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    late DatabaseFactory dbFactory;
    String path;

    if (kIsWeb) {
      // Use Web Database Factory
      dbFactory = databaseFactoryFfiWeb;
      path = 'employee.db';  // Web does not use file paths
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Use sqflite_common_ffi for Desktop
      sqfliteFfiInit();
      dbFactory = databaseFactoryFfi;
      path = join(await getDatabasesPath(), 'employee.db');
    } else {
      // Use Default SQLite for Mobile (Android/iOS)
      dbFactory = databaseFactory; // Fix for mobile
      path = join(await getDatabasesPath(), 'employee.db');
    }

    return await dbFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE employees (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              employeeName TEXT,
              employeeRole TEXT,
              employeeStartDate TEXT,
              employeeEndDate TEXT
            )
          ''');
        },
      ),
    );
  }

  Future<int> insertEmployee(Employee employee) async {
    final db = await database;
    return await db.insert('employees', employee.toMap());
  }

  Future<List<Employee>> fetchEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(maps.length, (i) => Employee.fromMap(maps[i]));
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
