import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/seasons.dart';

class SeasonsModel extends Equatable {
  SeasonsModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  factory SeasonsModel.fromJson(Map<String, dynamic> json) => SeasonsModel(
        airDate: json['air_date'],
        episodeCount: json['episode_count'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        voteAverage: json['vote_average'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['episode_count'] = episodeCount;
    _data['id'] = id;
    _data['name'] = name;
    _data['overview'] = overview;
    _data['poster_path'] = posterPath;
    _data['season_number'] = seasonNumber;
    _data['vote_average'] = voteAverage;
    return _data;
  }

  Seasons toEntity() => Seasons(
        airDate: this.airDate,
        episodeCount: this.episodeCount,
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
        voteAverage: this.voteAverage,
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
