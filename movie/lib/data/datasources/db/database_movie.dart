import 'dart:async';

import 'package:core/core.dart';
import 'package:movie/data/models/movie_table.dart';

class DatabaseMovie {
  final DatabaseHelperNew databaseHelper;

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

  Future<List<Map<String, dynamic>?>?> getMovieById(int id) async {
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
