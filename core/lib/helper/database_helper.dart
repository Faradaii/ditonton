import 'package:sqflite/sqflite.dart';

import '../common/constants.dart';

class CreateDatabase {
  static CreateDatabase? _databaseHelper;

  CreateDatabase._instance() {
    _databaseHelper = this;
  }

  factory CreateDatabase() => _databaseHelper ?? CreateDatabase._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$databaseName';

    var db = await openDatabase(databasePath,
        version: databaseVersion, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $tableWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $tableWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }
}

abstract class DatabaseHelper {
  Future<int> insert(String table, Map<String, dynamic> values);

  Future<int> delete(String table, {String? where, List<Object?>? whereArgs});

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs});

  Future<List<Map<String, dynamic>?>?> queryGetOne(String table,
      {String? where, List<Object?>? whereArgs});
}

class DatabaseHelperImpl implements DatabaseHelper {
  final Database database;

  DatabaseHelperImpl(this.database);

  @override
  Future<int> insert(String table, Map<String, dynamic> values) {
    return database.insert(table, values);
  }

  @override
  Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) {
    return database.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs}) {
    return database.query(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>?>?> queryGetOne(String table,
      {String? where, List<Object?>? whereArgs}) {
    return database
        .query(table, where: where, whereArgs: whereArgs)
        .then((value) => value);
  }
}
