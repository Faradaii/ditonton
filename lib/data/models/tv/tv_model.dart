import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv/tv.dart';

class TvSeriesModel extends Equatable {
  TvSeriesModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String firstAirDate;
  final String name;
  final int? voteAverage;
  final int voteCount;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List.castFrom<dynamic, int>(json['genre_ids']),
        id: json['id'],
        originCountry: List.castFrom<dynamic, String>(json['origin_country']),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        firstAirDate: json['first_air_date'],
        name: json['name'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['backdrop_path'] = backdropPath;
    _data['genre_ids'] = genreIds;
    _data['id'] = id;
    _data['origin_country'] = originCountry;
    _data['original_language'] = originalLanguage;
    _data['original_name'] = originalName;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['first_air_date'] = firstAirDate;
    _data['name'] = name;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }

  TvSeries toEntity() {
    return TvSeries(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      name: this.name,
      firstAirDate: this.firstAirDate,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount
    );
  }

  @override
  List<Object?> get props =>
      [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount
      ];
}