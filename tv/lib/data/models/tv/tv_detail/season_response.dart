import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv/tv_detail/episodes_model.dart';

import '../../../../domain/entities/tv/season/season_detail.dart';

class SeasonResponse extends Equatable {
  const SeasonResponse({
    required this.idAlternative,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final String? idAlternative;
  final String? airDate;
  final List<EpisodesModel>? episodes;
  final String? name;
  final String? overview;
  final int id;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => SeasonResponse(
    idAlternative: json['_id'],
        airDate: json['air_date'],
        episodes: List.from(json['episodes'])
            .map((e) => EpisodesModel.fromJson(e))
            .toList(),
        name: json['name'],
        overview: json['overview'],
        id: json['id'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        voteAverage: json['vote_average'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = idAlternative;
    data['air_date'] = airDate;
    data['episodes'] = episodes?.map((e) => e.toJson()).toList();
    data['name'] = name;
    data['overview'] = overview;
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    data['vote_average'] = voteAverage;
    return data;
  }

  Season toEntity() => Season(
    idAlternative: idAlternative,
        airDate: airDate,
        episodes: episodes?.map((e) => e.toEntity()).toList(),
        name: name,
        overview: overview,
        id: id,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [
    idAlternative,
        airDate,
        episodes,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
