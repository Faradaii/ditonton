import 'package:equatable/equatable.dart';

import 'crew.dart';
import 'guest_stars.dart';

class Episodes extends Equatable {
  Episodes({
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
  final List<Crew>? crew;
  final List<GuestStars>? guestStars;

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
