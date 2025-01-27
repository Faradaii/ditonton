import 'package:core/common/exception.dart';
import 'package:movie/data/datasources/db/database_movie.dart';
import 'package:movie/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseMovie databaseMovie;

  MovieLocalDataSourceImpl({required this.databaseMovie});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseMovie.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseMovie.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseMovie.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result.first!);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseMovie.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
