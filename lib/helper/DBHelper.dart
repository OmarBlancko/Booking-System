import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static sql.Database? _database1;
  // static DBHelper? _databaseHelper;
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  // static DBHelper? getInstance() {
  //   if (_databaseHelper == null) {
  //     _databaseHelper = new DBHelper._privateInstance() ;
  //   }
  //   return _databaseHelper;
  // }
  Future<sql.Database?> get database async {
    if (_database1 == null) {
      print('initialize database');
      _database1 = await initializeDatabase();
    }
    return _database1;
  }
   initializeDatabase() async {
    // print('initialize');
    var dbDir = await sql.getDatabasesPath();
    var dbPath = path.join(dbDir, "app.db");
    try {
      await sql.deleteDatabase(dbPath);

// Create the writable database file from the bundled demo database file:
      ByteData data = await rootBundle.load("assets/bookingsystem.db");
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    } catch (e) {
      print(e);
    }
    // print(dbPath);
    _database1 = await sql.openDatabase(dbPath);
    return _database1;
  }
  // Future<void >saveChanges (String table,Map<String,dynamic> data)async {
  //   Database db;
  //   try{
  //   db =await sql.openDatabase('/assets/bookingsystem.db');
  //   await db.insert(table, data);
  //   }
  //   catch(e) {print(e);}
  // }
  Future<dynamic> getAllData () async {
    // await instance.initializeDatabase();
    final db = await instance.database;
    return db;
  }
  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await _database1!.query(table);
  }

Future<void> insert(String table,Map<String,dynamic> data) async
  {
    // await instance.saveChanges(table,data);
    await _database1!.insert(table, data);
    print(await _database1!.query(table));

  }

}
