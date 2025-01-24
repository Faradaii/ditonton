import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/last_episode_to_air.dart';

class LastEpisodeToAirModel extends Equatable {
  const LastEpisodeToAirModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  final int id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        episodeType: json['episode_type'],
        productionCode: json['production_code'],
        runtime: json['runtime'],
        seasonNumber: json['season_number'],
        showId: json['show_id'],
        stillPath: json['still_path'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['episode_type'] = episodeType;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    return data;
  }

  LastEpisodeToAir toEntity() => LastEpisodeToAir(
      id: id,
      name: name,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      airDate: airDate,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath);

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        voteAverage,
        voteCount,
        airDate,
        episodeNumber,
        episodeType,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
      ];
}
