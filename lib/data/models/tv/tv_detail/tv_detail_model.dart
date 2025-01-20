import 'package:ditonton/data/models/tv/tv_detail/production_companies_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/production_countries_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/seasons_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/spoken_languages_model.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

import 'created_by_model.dart';
import 'genres_model.dart';
import 'last_episode_to_air_model.dart';
import 'networks_model.dart';
import 'next_episode_to_air_model.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
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
  late final bool adult;
  late final String backdropPath;
  late final List<CreatedByModel> createdBy;
  late final List<int> episodeRunTime;
  late final String firstAirDate;
  late final List<GenresModel> genres;
  late final String homepage;
  late final int id;
  late final bool inProduction;
  late final List<String> languages;
  late final String lastAirDate;
  late final LastEpisodeToAirModel lastEpisodeToAir;
  late final String name;
  late final NextEpisodeToAirModel nextEpisodeToAir;
  late final List<NetworksModel> networks;
  late final int numberOfEpisodes;
  late final int numberOfSeasons;
  late final List<String> originCountry;
  late final String originalLanguage;
  late final String originalName;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final List<ProductionCompaniesModel> productionCompanies;
  late final List<ProductionCountriesModel> productionCountries;
  late final List<SeasonsModel> seasons;
  late final List<SpokenLanguagesModel> spokenLanguages;
  late final String status;
  late final String tagline;
  late final String type;
  late final int voteAverage;
  late final int voteCount;

  TvSeriesDetailResponse.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    createdBy = List.from(json['created_by']).map((e)=>CreatedByModel.fromJson(e)).toList();
    episodeRunTime = List.from(json['episode_run_time']);
    firstAirDate = json['first_air_date'];
    genres = List.from(json['genres']).map((e)=>GenresModel.fromJson(e)).toList();
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = List.castFrom<dynamic, String>(json['languages']);
    lastAirDate = json['last_air_date'];
    lastEpisodeToAir = LastEpisodeToAirModel.fromJson(json['last_episode_to_air']);
    name = json['name'];
    nextEpisodeToAir = NextEpisodeToAirModel.fromJson(json['next_episode_to_air']);
    networks = List.from(json['networks']).map((e)=>NetworksModel.fromJson(e)).toList();
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    productionCompanies = List.from(json['production_companies']).map((e)=>ProductionCompaniesModel.fromJson(e)).toList();
    productionCountries = List.from(json['production_countries']).map((e)=>ProductionCountriesModel.fromJson(e)).toList();
    seasons = List.from(json['seasons']).map((e)=>SeasonsModel.fromJson(e)).toList();
    spokenLanguages = List.from(json['spoken_languages']).map((e)=>SpokenLanguagesModel.fromJson(e)).toList();
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['backdrop_path'] = backdropPath;
    _data['created_by'] = createdBy.map((e)=>e.toJson()).toList();
    _data['episode_run_time'] = episodeRunTime;
    _data['first_air_date'] = firstAirDate;
    _data['genres'] = genres.map((e)=>e.toJson()).toList();
    _data['homepage'] = homepage;
    _data['id'] = id;
    _data['in_production'] = inProduction;
    _data['languages'] = languages;
    _data['last_air_date'] = lastAirDate;
    _data['last_episode_to_air'] = lastEpisodeToAir.toJson();
    _data['name'] = name;
    _data['next_episode_to_air'] = nextEpisodeToAir.toJson();
    _data['networks'] = networks.map((e)=>e.toJson()).toList();
    _data['number_of_episodes'] = numberOfEpisodes;
    _data['number_of_seasons'] = numberOfSeasons;
    _data['origin_country'] = originCountry;
    _data['original_language'] = originalLanguage;
    _data['original_name'] = originalName;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['production_companies'] = productionCompanies.map((e)=>e.toJson()).toList();
    _data['production_countries'] = productionCountries.map((e)=>e.toJson()).toList();
    _data['seasons'] = seasons.map((e)=>e.toJson()).toList();
    _data['spoken_languages'] = spokenLanguages.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    _data['tagline'] = tagline;
    _data['type'] = type;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }

  TvSeriesDetail toEntity() => TvSeriesDetail(
    adult: this.adult,
    backdropPath: this.backdropPath,
    createdBy: this.createdBy.map((e) => e.toEntity()).toList(),
    episodeRunTime: this.episodeRunTime,
    firstAirDate: this.firstAirDate,
    genres: this.genres.map((e) => e.toEntity()).toList(),
    homepage: this.homepage,
    id: this.id,
    inProduction: this.inProduction,
    languages: this.languages,
    lastAirDate: this.lastAirDate,
    lastEpisodeToAir: this.lastEpisodeToAir.toEntity(),
    name: this.name,
    nextEpisodeToAir: this.nextEpisodeToAir.toEntity(),
    networks: this.networks.map((e) => e.toEntity()).toList(),
    numberOfEpisodes: this.numberOfEpisodes,
    numberOfSeasons: this.numberOfSeasons,
    originCountry: this.originCountry,
    originalLanguage: this.originalLanguage,
    originalName: this.originalName,
    overview: this.overview,
    popularity: this.popularity,
    posterPath: this.posterPath,
    productionCompanies: this.productionCompanies.map((e) => e.toEntity()).toList(),
    productionCountries: this.productionCountries.map((e) => e.toEntity()).toList(),
    seasons: this.seasons.map((e) => e.toEntity()).toList(),
    spokenLanguages: this.spokenLanguages.map((e) => e.toEntity()).toList(),
    status: this.status,
    tagline: this.tagline,
    type: this.type,
    voteAverage: this.voteAverage,
    voteCount: this.voteCount,
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















