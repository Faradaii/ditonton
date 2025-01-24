import 'package:ditonton/domain/entities/tv/episodes.dart';
import 'package:equatable/equatable.dart';

import 'crew_model.dart';
import 'guest_stars.dart';

class EpisodesModel extends Equatable {
  const EpisodesModel({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final int id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;
  final List<CrewModel>? crew;
  final List<GuestStarsModel>? guestStars;

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => EpisodesModel(
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        episodeType: json['episode_type'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        productionCode: json['production_code'],
        runtime: json['runtime'],
        seasonNumber: json['season_number'],
        showId: json['show_id'],
        stillPath: json['still_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        crew:
            List.from(json['crew']).map((e) => CrewModel.fromJson(e)).toList(),
        guestStars: List.from(json['guest_stars'])
            .map((e) => GuestStarsModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['episode_type'] = episodeType;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['crew'] = crew?.map((e) => e.toJson()).toList();
    data['guest_stars'] = guestStars?.map((e) => e.toJson()).toList();
    return data;
  }

  Episodes toEntity() => Episodes(
        airDate: airDate,
        episodeNumber: episodeNumber,
        episodeType: episodeType,
        id: id,
        name: name,
        overview: overview,
        productionCode: productionCode,
        runtime: runtime,
        seasonNumber: seasonNumber,
        showId: showId,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
        crew: crew?.map((e) => e.toEntity()).toList(),
        guestStars: guestStars?.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        episodeType,
        id,
        name,
        overview,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
        crew,
        guestStars,
      ];
}
