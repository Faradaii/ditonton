import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/episode/episode.dart';
import 'crew_model.dart';
import 'guest_stars.dart';

class EpisodeResponse extends Equatable {
  EpisodeResponse({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? airDate;
  final List<CrewModel>? crew;
  final int? episodeNumber;
  final List<GuestStarsModel>? guestStars;
  final String? name;
  final String? overview;
  final int id;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
        airDate: json['air_date'],
        crew:
            List.from(json['crew']).map((e) => CrewModel.fromJson(e)).toList(),
        episodeNumber: json['episode_number'],
        guestStars: List.from(json['guest_stars'])
            .map((e) => GuestStarsModel.fromJson(e))
            .toList(),
        name: json['name'],
        overview: json['overview'],
        id: json['id'],
        productionCode: json['production_code'],
        runtime: json['runtime'],
        seasonNumber: json['season_number'],
        stillPath: json['still_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['crew'] = crew?.map((e) => e.toJson()).toList();
    _data['episode_number'] = episodeNumber;
    _data['guest_stars'] = guestStars?.map((e) => e.toJson()).toList();
    _data['name'] = name;
    _data['overview'] = overview;
    _data['id'] = id;
    _data['production_code'] = productionCode;
    _data['runtime'] = runtime;
    _data['season_number'] = seasonNumber;
    _data['still_path'] = stillPath;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }

  Episode toEntity() => Episode(
      airDate: this.airDate,
      crew: this.crew?.map((e) => e.toEntity()).toList(),
      episodeNumber: this.episodeNumber,
      guestStars: this.guestStars?.map((e) => e.toEntity()).toList(),
      name: this.name,
      overview: this.overview,
      id: this.id,
      productionCode: this.productionCode,
      runtime: this.runtime,
      seasonNumber: this.seasonNumber,
      stillPath: this.stillPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount);

  @override
  List<Object?> get props => [
        airDate,
        crew,
        episodeNumber,
        guestStars,
        name,
        overview,
        id,
        productionCode,
        runtime,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
