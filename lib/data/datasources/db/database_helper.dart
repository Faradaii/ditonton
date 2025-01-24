import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistMovies = 'watchlist_movies';
  static const String _tblWatchlistTv = 'watchlist_tv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistMovies (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlistMovies, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovies,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovies,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistMovies);

    return results;
  }

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);

    return results;
  }
}
