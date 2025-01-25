import 'package:tv/data/models/tv/tv_model.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: true,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    name: "name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    adult: true,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    name: "name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
