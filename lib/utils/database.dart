import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

  class SQLiteDbProvider {
  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static var _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database =  await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MasterDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      db.execute(
              """CREATE TABLE itm_mastr(id INTEGER PRIMARY KEY AUTOINCREMENT,itm_id integer,itm_name text,itm_rate double,qty double,tot_rate double,group_id integer,is_selected text default 'N')""");
      db.execute(
              """CREATE TABLE party_mastr(id INTEGER PRIMARY KEY AUTOINCREMENT,party_id integer,party_name text,primary_address text,party_gstin text)""");
      db.execute(
          """CREATE TABLE group_mastr(id INTEGER PRIMARY KEY AUTOINCREMENT,group_id integer,group_name text)""");
        });

  }
}
