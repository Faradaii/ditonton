import 'dart:async';

import 'package:core/core.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMovie {
  final Future<Database?> database;

  DatabaseMovie({required this.database});

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(tableWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      tableWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      tableWatchlistMovie,
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
        await db!.query(tableWatchlistMovie);

    return results;
  }
}
