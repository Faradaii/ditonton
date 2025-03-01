import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/domain/entities/movie.dart';

void main() {
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('toJson', () {
    final result = tMovieModel.toJson();
    expect(result, {
      "adult": false,
      "backdrop_path": 'backdropPath',
      "genre_ids": [1, 2, 3],
      "id": 1,
      "original_title": 'originalTitle',
      "overview": 'overview',
      "popularity": 1,
      "poster_path": 'posterPath',
      "release_date": 'releaseDate',
      "title": 'title',
      "video": false,
      "vote_average": 1,
      "vote_count": 1,
    });
  });
}
