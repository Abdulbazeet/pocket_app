import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/product_group.dart';

class DBHelper {
   static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }
  // static Future<void> createTables(sql.Database database) async {
  //   await database.execute(
  //       """CREATE TABLE carts(id INTEGER PRIMARY KEY AUTOINCREMENT, customerName TEXT,
  //           orderId INTEGER,
  //           amount REAL)""");
  // }
   Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE carts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerName TEXT,
            orderId INTEGER,
            amount REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cartId INTEGER,
            productName TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }
  Future<int> saveItemToDatabase(Item item, int cartId) async {
    final db = await database;
    return await db.insert('items', {
      'cartId': cartId,
      'productName': item.productName,
      'price': item.price,
      'quantity': item.quantity,
    });
  }
}
