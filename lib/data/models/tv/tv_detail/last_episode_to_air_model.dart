import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/last_episode_to_air.dart';

class LastEpisodeToAirModel extends Equatable {
  LastEpisodeToAirModel({
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

  late final int id;
  late final String name;
  late final String overview;
  late final int voteAverage;
  late final int voteCount;
  late final String airDate;
  late final int episodeNumber;
  late final String episodeType;
  late final String productionCode;
  late final int runtime;
  late final int seasonNumber;
  late final int showId;
  late final String stillPath;

  LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    episodeType = json['episode_type'];
    productionCode = json['production_code'];
    runtime = json['runtime'];
    seasonNumber = json['season_number'];
    showId = json['show_id'];
    stillPath = json['still_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['overview'] = overview;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    _data['air_date'] = airDate;
    _data['episode_number'] = episodeNumber;
    _data['episode_type'] = episodeType;
    _data['production_code'] = productionCode;
    _data['runtime'] = runtime;
    _data['season_number'] = seasonNumber;
    _data['show_id'] = showId;
    _data['still_path'] = stillPath;
    return _data;
  }

  LastEpisodeToAir toEntity() => LastEpisodeToAir(
      id: this.id,
      name: this.name,
      overview: this.overview,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      episodeType: this.episodeType,
      productionCode: this.productionCode,
      runtime: this.runtime,
      seasonNumber: this.seasonNumber,
      showId: this.showId,
      stillPath: this.stillPath);

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
