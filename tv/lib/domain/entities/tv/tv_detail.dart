import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/production_companies.dart';
import 'package:tv/domain/entities/tv/production_countries.dart';
import 'package:tv/domain/entities/tv/seasons.dart';
import 'package:tv/domain/entities/tv/spoken_languages.dart';

import 'created_by.dart';
import 'genres.dart';
import 'last_episode_to_air.dart';
import 'networks.dart';
import 'next_episode_to_air.dart';

class TvSeriesDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<Genres>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final NextEpisodeToAir? nextEpisodeToAir;
  final List<Networks>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final List<Seasons>? seasons;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  const TvSeriesDetail(
      {required this.adult,
      required this.backdropPath,
      required this.createdBy,
      required this.episodeRunTime,
      required this.firstAirDate,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.inProduction,
      required this.languages,
      required this.lastAirDate,
      required this.lastEpisodeToAir,
      required this.name,
      required this.nextEpisodeToAir,
      required this.networks,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.productionCompanies,
      required this.productionCountries,
      required this.seasons,
      required this.spokenLanguages,
      required this.status,
      required this.tagline,
      required this.type,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount
      ];
}
