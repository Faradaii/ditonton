import 'package:equatable/equatable.dart';

import '../episodes.dart';

class Season extends Equatable {
  const Season({
    required this.id_alternative,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final String? id_alternative;
  final String? airDate;
  final List<Episodes>? episodes;
  final String? name;
  final String? overview;
  final int id;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  @override
  List<Object?> get props => [
        id_alternative,
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
