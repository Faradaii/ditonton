import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';

import '../../json_reader.dart';

void main() {
  final tMovieModelResponse = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
    budget: 1,
    genres: [GenreModel(id: 1, name: "name")],
    homepage: '',
    imdbId: '',
    originalLanguage: '',
    revenue: 1,
    runtime: 1,
    status: '',
    tagline: '',
  );

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
    json.decode(readJson('dummy_data/movie_detail_response.json'));
    // act
    final result = MovieDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, tMovieModelResponse);
  });

  test('toJson', () {
    // Act
    final result = tMovieModelResponse.toJson();

    // Assert
    expect(result, {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "original_title": "Original Title",
      "overview": "Overview",
      "popularity": 1.0,
      "poster_path": "/path.jpg",
      "release_date": "2020-05-05",
      "title": "Title",
      "video": false,
      "vote_average": 1.0,
      "vote_count": 1,
      "budget": 1,
      "genres": [{"id": 1, "name": "name"}],
      "homepage": "",
      "imdb_id": "",
      "original_language": "",
      "revenue": 1,
      "runtime": 1,
      "status": "",
      "tagline": ""
    });
  });
}
