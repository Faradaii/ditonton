import 'dart:async';

import 'package:core/core.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:sqflite/sqflite.dart';


abstract class DatabaseHelper {
  Future<int> insert(String table, Map<String, dynamic> values);
  Future<int> delete(String table, {String? where, List<Object?>? whereArgs});
  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<Object?>? whereArgs});
  Future<Map<String, dynamic>?>? queryGetOne(String table, {String? where, List<Object?>? whereArgs});
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
  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<Object?>? whereArgs}) {
    return database.query(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<Map<String, dynamic>?>? queryGetOne(String table, {String? where, List<Object?>? whereArgs}) {
    return database.query(table, where: where, whereArgs: whereArgs).then((value) => value.first);
  }
}

class DatabaseMovie {
  final DatabaseHelper databaseHelper;

  DatabaseMovie({required this.databaseHelper});

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = databaseHelper;
    return await db.insert(tableWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = databaseHelper;
    return await db.delete(
      tableWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?>? getMovieById(int id) async {
    final db = databaseHelper;
    final results = await db.queryGetOne(
      tableWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results != null && results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = databaseHelper;
    final List<Map<String, dynamic>> results =
        await db.query(tableWatchlistMovie);

    return results;
  }
}
