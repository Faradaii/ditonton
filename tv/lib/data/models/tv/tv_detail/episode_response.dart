import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/episode/episode.dart';
import 'crew_model.dart';
import 'guest_stars.dart';

class EpisodeResponse extends Equatable {
  const EpisodeResponse({
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
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['crew'] = crew?.map((e) => e.toJson()).toList();
    data['episode_number'] = episodeNumber;
    data['guest_stars'] = guestStars?.map((e) => e.toJson()).toList();
    data['name'] = name;
    data['overview'] = overview;
    data['id'] = id;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  Episode toEntity() => Episode(
      airDate: airDate,
      crew: crew?.map((e) => e.toEntity()).toList(),
      episodeNumber: episodeNumber,
      guestStars: guestStars?.map((e) => e.toEntity()).toList(),
      name: name,
      overview: overview,
      id: id,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount);

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
