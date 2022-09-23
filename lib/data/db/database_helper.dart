import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/restaurant.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  static const String _tableFav = 'favorites';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const textPrimaryType = 'TEXT PRIMARY KEY NOT NULL';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';

    await db.execute('''CREATE TABLE $_tableFav (
            id $textPrimaryType,
            name $textType,
            description $textType,
            city $textType,
            pictureId $textType,
            rating $doubleType
          )
        ''');
  }

  //Create
  Future<void> insertFavorite(RestaurantList resto) async {
    final db = await instance.database;
    await db.insert(_tableFav, resto.toJson());
  }

  //Read
  Future<List<RestaurantList>> getFavorites() async {
    final db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(_tableFav);
    return results.map((e) => RestaurantList.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await instance.database;

    List<Map<String, dynamic>> results = await db.query(
      _tableFav,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  //Delete
  Future<void> removeFavorite(String id) async {
    final db = await instance.database;

    await db.delete(
      _tableFav,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
