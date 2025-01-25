import 'package:tv/data/models/tv/tv_detail/production_companies_model.dart';
import 'package:tv/data/models/tv/tv_detail/production_countries_model.dart';
import 'package:tv/data/models/tv/tv_detail/seasons_model.dart';
import 'package:tv/data/models/tv/tv_detail/spoken_languages_model.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

import 'created_by_model.dart';
import 'genres_model.dart';
import 'last_episode_to_air_model.dart';
import 'networks_model.dart';
import 'next_episode_to_air_model.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
    required this.adult,
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
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<CreatedByModel>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenresModel>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final LastEpisodeToAirModel? lastEpisodeToAir;
  final String? name;
  final NextEpisodeToAirModel? nextEpisodeToAir;
  final List<NetworksModel>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompaniesModel>? productionCompanies;
  final List<ProductionCountriesModel>? productionCountries;
  final List<SeasonsModel>? seasons;
  final List<SpokenLanguagesModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        createdBy: List.from(json['created_by'])
            .map((e) => CreatedByModel.fromJson(e))
            .toList(),
        episodeRunTime: List.from(json['episode_run_time']),
        firstAirDate: json['first_air_date'],
        genres: List.from(json['genres'])
            .map((e) => GenresModel.fromJson(e))
            .toList(),
        homepage: json['homepage'],
        id: json['id'],
        inProduction: json['in_production'],
        languages: List.castFrom<dynamic, String>(json['languages']),
        lastAirDate: json['last_air_date'],
        lastEpisodeToAir:
            LastEpisodeToAirModel.fromJson(json['last_episode_to_air']),
        name: json['name'],
        nextEpisodeToAir: json['next_episode_to_air'] != null
            ? NextEpisodeToAirModel.fromJson(json['next_episode_to_air'])
            : null,
        networks: List.from(json['networks'])
            .map((e) => NetworksModel.fromJson(e))
            .toList(),
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originCountry: List.castFrom<dynamic, String>(json['origin_country']),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        productionCompanies: List.from(json['production_companies'])
            .map((e) => ProductionCompaniesModel.fromJson(e))
            .toList(),
        productionCountries: List.from(json['production_countries'])
            .map((e) => ProductionCountriesModel.fromJson(e))
            .toList(),
        seasons: List.from(json['seasons'])
            .map((e) => SeasonsModel.fromJson(e))
            .toList(),
        spokenLanguages: List.from(json['spoken_languages'])
            .map((e) => SpokenLanguagesModel.fromJson(e))
            .toList(),
        status: json['status'],
        tagline: json['tagline'],
        type: json['type'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['created_by'] = createdBy?.map((e) => e.toJson()).toList();
    data['episode_run_time'] = episodeRunTime;
    data['first_air_date'] = firstAirDate;
    data['genres'] = genres?.map((e) => e.toJson()).toList();
    data['homepage'] = homepage;
    data['id'] = id;
    data['in_production'] = inProduction;
    data['languages'] = languages;
    data['last_air_date'] = lastAirDate;
    data['last_episode_to_air'] = lastEpisodeToAir?.toJson();
    data['name'] = name;
    data['next_episode_to_air'] = nextEpisodeToAir?.toJson();
    data['networks'] = networks?.map((e) => e.toJson()).toList();
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['production_companies'] =
        productionCompanies?.map((e) => e.toJson()).toList();
    data['production_countries'] =
        productionCountries?.map((e) => e.toJson()).toList();
    data['seasons'] = seasons?.map((e) => e.toJson()).toList();
    data['spoken_languages'] = spokenLanguages?.map((e) => e.toJson()).toList();
    data['status'] = status;
    data['tagline'] = tagline;
    data['type'] = type;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  TvSeriesDetail toEntity() => TvSeriesDetail(
        adult: adult,
        backdropPath: backdropPath,
        createdBy: createdBy?.map((e) => e.toEntity()).toList(),
        episodeRunTime: episodeRunTime,
        firstAirDate: firstAirDate,
        genres: genres?.map((e) => e.toEntity()).toList(),
        homepage: homepage,
        id: id,
        inProduction: inProduction,
        languages: languages,
        lastAirDate: lastAirDate,
        lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
        name: name,
        nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
        networks: networks?.map((e) => e.toEntity()).toList(),
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        productionCompanies:
            productionCompanies?.map((e) => e.toEntity()).toList(),
        productionCountries:
            productionCountries?.map((e) => e.toEntity()).toList(),
        seasons: seasons?.map((e) => e.toEntity()).toList(),
        spokenLanguages: spokenLanguages?.map((e) => e.toEntity()).toList(),
        status: status,
        tagline: tagline,
        type: type,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

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
        voteCount,
      ];
}
