import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  DbHelper.__();
  static final DbHelper getInstance = DbHelper.__();

  static final String TABLE_TRANSACTION = 'transactions';
  static final String COLUMN_ID = 'id';
  static final String COLUMN_TITLE = 'title';
  static final String COLUMN_AMOUNT = 'amount';
  static final String COLUMN_CATEGORY = 'category';
  static final String COLUMN_TYPE = 'type';
  static final String COLUMN_DATE = 'date';

  Database? myDb;

  Future<Database> getDb() async {
    myDb ??= await openDb();
    return myDb!;
  }

  Future<Database> openDb() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String dbPath = join(appdir.path, 'local.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $TABLE_TRANSACTION($COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,$COLUMN_TITLE TEXT, $COLUMN_AMOUNT REAL, $COLUMN_CATEGORY TEXT,$COLUMN_DATE TEXT, $COLUMN_TYPE TEXT)",
        );
      },
    );
  }

  Future<bool> insertTransaction({
    String? title,
    required double amount,
    String? category,
    String? type,
    required String date,
  }) async {
    var db = await getDb();
    int rowsAffected = await db.insert(TABLE_TRANSACTION, {
      COLUMN_AMOUNT: amount,
      COLUMN_CATEGORY: category,
      COLUMN_TITLE: title,
      COLUMN_TYPE: type,
      COLUMN_DATE: date,
    });
    return rowsAffected > 0;
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    var db = await getDb();
    return await db.query(TABLE_TRANSACTION);
  }

  Future<bool> deleteTransaction({required int id}) async {
    var db = await getDb();
    int rowsAffected = await db.delete(
      TABLE_TRANSACTION,
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
    return rowsAffected > 0;
  }

  Future<bool> updateTransaction({
    required int id,
    String? title,
    required double amount,
    String? category,
    required String date,
  }) async {
    var db = await getDb();
    int rowsAffected = await db.update(
      TABLE_TRANSACTION,
      {
        COLUMN_AMOUNT: amount,
        COLUMN_CATEGORY: category,
        COLUMN_TITLE: title,
        COLUMN_DATE: date,
      },
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
    return rowsAffected > 0;
  }
}
