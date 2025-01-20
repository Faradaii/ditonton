import 'package:ditonton/domain/entities/tv/production_companies_model.dart';
import 'package:ditonton/domain/entities/tv/production_countries_model.dart';
import 'package:ditonton/domain/entities/tv/seasons_model.dart';
import 'package:ditonton/domain/entities/tv/spoken_languages_model.dart';
import 'package:equatable/equatable.dart';

import 'created_by_model.dart';
import 'genres_model.dart';
import 'last_episode_to_air_model.dart';
import 'networks_model.dart';
import 'next_episode_to_air_model.dart';

class TvSeriesDetail extends Equatable {
  bool? adult;
  String? backdropPath;
  List<CreatedByModel>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<GenresModel>? genres;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAirModel? lastEpisodeToAir;
  String? name;
  NextEpisodeToAirModel? nextEpisodeToAir;
  List<NetworksModel>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompaniesModel>? productionCompanies;
  List<ProductionCountriesModel>? productionCountries;
  List<SeasonsModel>? seasons;
  List<SpokenLanguagesModel>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  int? voteAverage;
  int? voteCount;

  TvSeriesDetail(
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