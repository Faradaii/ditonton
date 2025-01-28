import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/data/datasources/db/database_movie.dart';
import 'package:movie/data/models/movie_table.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late DatabaseMovie databaseMovie;
  late MockDatabaseHelper mockDatabaseHelper;

  setUpAll(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    databaseMovie = DatabaseMovie(databaseHelper: mockDatabaseHelper);
  });

  group('DatabaseMovie', () {
    test('should insert a movie into the watchlist', () async {
      // Arrange
      final movie = MovieTable(
        id: 1,
        title: 'Test Movie',
        overview: 'Overview',
        posterPath: '/path.jpg',
      );

      when(databaseMovie.insertWatchlistMovie(movie))
          .thenAnswer((_) async => 1);

      // Act
      final result = await databaseMovie.insertWatchlistMovie(movie);

      // Assert
      expect(result, 1);
      verify(databaseMovie.insertWatchlistMovie(movie)).called(1);
    });

    test('should remove a movie from the watchlist', () async {
      // Arrange
      final movie = MovieTable(
        id: 1,
        title: 'Test Movie',
        overview: 'Overview',
        posterPath: '/path.jpg',
      );

      when(databaseMovie.removeWatchlistMovie(movie))
          .thenAnswer((_) async => 1);

      // Act
      final result = await databaseMovie.removeWatchlistMovie(movie);

      // Assert
      expect(result, 1);
      verify(databaseMovie.removeWatchlistMovie(movie)).called(1);
    });

    test('should get a movie by ID', () async {
      // Arrange
      const id = 1;
      final Map<String, dynamic> movieData = {
        'id': id,
        'title': 'Test Movie',
        'overview': 'Overview',
        'posterPath': '/path.jpg',
      };

      when(databaseMovie.getMovieById(id)).thenAnswer((_) async => [movieData]);

      // Act
      final result = await databaseMovie.getMovieById(id);

      // Assert
      expect(result!.first, movieData);
      verify(databaseMovie.getMovieById(id)).called(1);
    });

    test('should return null if no movie is found by ID', () async {
      // Arrange
      const id = 2;

      when(databaseMovie.getMovieById(id)).thenAnswer((_) async => null);

      // Act
      final result = await databaseMovie.getMovieById(id);

      // Assert
      expect(result, null);
      verify(databaseMovie.getMovieById(id)).called(1);
    });

    test('should get all movies from the watchlist', () async {
      // Arrange
      final moviesData = [
        {
          'id': 1,
          'title': 'Test Movie 1',
          'overview': 'Overview 1',
          'posterPath': '/path1.jpg',
        },
        {
          'id': 2,
          'title': 'Test Movie 2',
          'overview': 'Overview 2',
          'posterPath': '/path2.jpg',
        },
      ];

      when(databaseMovie.getWatchlistMovies())
          .thenAnswer((_) async => moviesData);

      // Act
      final result = await databaseMovie.getWatchlistMovies();

      // Assert
      expect(result, moviesData);
      verify(databaseMovie.getWatchlistMovies()).called(1);
    });
  });
}
