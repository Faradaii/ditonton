import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelperNew {
  Future<int> insert(String table, Map<String, dynamic> values);

  Future<int> delete(String table, {String? where, List<Object?>? whereArgs});

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs});

  Future<List<Map<String, dynamic>?>?> queryGetOne(String table,
      {String? where, List<Object?>? whereArgs});
}

class DatabaseHelperNewImpl implements DatabaseHelperNew {
  final Database database;

  DatabaseHelperNewImpl(this.database);

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
