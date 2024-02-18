import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:task_app/core/constants/db_const.dart';
import 'package:path/path.dart';
import 'package:task_app/core/model/db_model.dart';

class CartProvider {
  static late Database db;

  static Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db2, int v) async {
      await db2.execute('''
create table $tableName ( 
  $columnId integer primary key unique, 
  $columnTitle text not null,
  $columnContent text not null,
  $columnThumbnail text not null,
  $columnPrice num real,
  $columnQuantity integer not null,
  $columnTotal num real)
''');
    });

    log("${db.isOpen}");
  }

  static Future<String> insert(DbProductModel dbProductModel) async {
    DbProductModel model = await getSingleCartItem(dbProductModel.id ?? 0);
    if (model.id != null) {
      return "Already in cart";
    }
    dbProductModel.id = await db.insert(tableName, dbProductModel.toJson());
    return "Added to cart";
  }

  static Future<DbProductModel> getSingleCartItem(int id) async {
    List<Map> maps = await db.query(tableName,
        columns: [
          columnId,
          columnTitle,
          columnContent,
          columnThumbnail,
          columnPrice,
          columnQuantity,
          columnTotal,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return DbProductModel.fromJson(maps.first);
    }
    return DbProductModel();
  }

  static Future<List<DbProductModel>> getCartList() async {
    List<Map> maps = await db.query(tableName, columns: [
      columnId,
      columnTitle,
      columnContent,
      columnThumbnail,
      columnPrice,
      columnQuantity,
      columnTotal,
    ]);
    if (maps.isNotEmpty) {
      return maps.map((e) => DbProductModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<int> delete(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<int> deleteTable() async {
    return await db.delete(tableName);
  }

  static Future<int> update(DbProductModel dbProductModel) async {
    return await db.update(tableName, dbProductModel.toJson(),
        where: '$columnId = ?', whereArgs: [dbProductModel.id]);
  }

  static Future close() async => db.close();
}
