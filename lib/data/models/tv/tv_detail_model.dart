import 'package:ditonton/domain/entities/tv/created_by.dart';
import 'package:ditonton/domain/entities/tv/genres.dart';
import 'package:ditonton/domain/entities/tv/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/tv/production_companies.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

import '../../../domain/entities/tv/networks.dart';
import '../../../domain/entities/tv/next_episode_to_air.dart';
import '../../../domain/entities/tv/production_countries.dart';
import '../../../domain/entities/tv/seasons.dart';
import '../../../domain/entities/tv/spoken_languages.dart';

class TvSeriesDetailResponse {
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
}

class CreatedByModel {
  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });
  late final int id;
  late final String creditId;
  late final String name;
  late final String originalName;
  late final int gender;
  late final Null profilePath;

  CreatedByModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    originalName = json['original_name'];
    gender = json['gender'];
    profilePath = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['credit_id'] = creditId;
    _data['name'] = name;
    _data['original_name'] = originalName;
    _data['gender'] = gender;
    _data['profile_path'] = profilePath;
    return _data;
  }

  CreatedBy toEntity () => CreatedBy(
    id: this.id,
    creditId: this.creditId,
    name: this.name,
    originalName: this.originalName,
    gender: this.gender,
    profilePath: this.profilePath
  );
}

class GenresModel {
  GenresModel({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  GenresModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }

  Genres toEntity () => Genres(
    id: this.id,
    name: this.name
  );
}

class LastEpisodeToAirModel {
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

  LastEpisodeToAirModel.fromJson(Map<String, dynamic> json){
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

  LastEpisodeToAir toEntity () => LastEpisodeToAir(
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
    stillPath: this.stillPath
  );
}

class NextEpisodeToAirModel {
  NextEpisodeToAirModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
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
  late final Null runtime;
  late final int seasonNumber;
  late final int showId;
  late final Null stillPath;

  NextEpisodeToAirModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    episodeType = json['episode_type'];
    productionCode = json['production_code'];
    runtime = null;
    seasonNumber = json['season_number'];
    showId = json['show_id'];
    stillPath = null;
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

  NextEpisodeToAir toEntity () => NextEpisodeToAir(
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
    stillPath: this.stillPath
  );
}

class NetworksModel {
  NetworksModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
  late final int id;
  late final String logoPath;
  late final String name;
  late final String originCountry;

  NetworksModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['logo_path'] = logoPath;
    _data['name'] = name;
    _data['origin_country'] = originCountry;
    return _data;
  }

  Networks toEntity () => Networks(
    id: this.id,
    logoPath: this.logoPath,
    name: this.name,
    originCountry: this.originCountry
  );
}

class ProductionCompaniesModel {
  ProductionCompaniesModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
  late final int id;
  late final String logoPath;
  late final String name;
  late final String originCountry;

  ProductionCompaniesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['logo_path'] = logoPath;
    _data['name'] = name;
    _data['origin_country'] = originCountry;
    return _data;
  }

  ProductionCompanies toEntity () => ProductionCompanies(
    id: this.id,
    logoPath: this.logoPath,
    name: this.name,
    originCountry: this.originCountry
  );
}

class ProductionCountriesModel {
  ProductionCountriesModel({
    required this.iso_3166_1,
    required this.name,
  });
  late final String iso_3166_1;
  late final String name;

  ProductionCountriesModel.fromJson(Map<String, dynamic> json){
    iso_3166_1 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iso_3166_1'] = iso_3166_1;
    _data['name'] = name;
    return _data;
  }

  ProductionCountries toEntity () => ProductionCountries(
    iso31661: this.iso_3166_1,
    name: this.name,
  );
}

class SeasonsModel {
  SeasonsModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });
  late final String airDate;
  late final int episodeCount;
  late final int id;
  late final String name;
  late final String overview;
  late final String posterPath;
  late final int seasonNumber;
  late final int voteAverage;

  SeasonsModel.fromJson(Map<String, dynamic> json){
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['episode_count'] = episodeCount;
    _data['id'] = id;
    _data['name'] = name;
    _data['overview'] = overview;
    _data['poster_path'] = posterPath;
    _data['season_number'] = seasonNumber;
    _data['vote_average'] = voteAverage;
    return _data;
  }

  Seasons toEntity () => Seasons(
    airDate: this.airDate,
    episodeCount: this.episodeCount,
    id: this.id,
    name: this.name,
    overview: this.overview,
    posterPath: this.posterPath,
    seasonNumber: this.seasonNumber,
    voteAverage: this.voteAverage,
  );
}

class SpokenLanguagesModel {
  SpokenLanguagesModel({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });
  late final String englishName;
  late final String iso_639_1;
  late final String name;

  SpokenLanguagesModel.fromJson(Map<String, dynamic> json){
    englishName = json['english_name'];
    iso_639_1 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['english_name'] = englishName;
    _data['iso_639_1'] = iso_639_1;
    _data['name'] = name;
    return _data;
  }

  SpokenLanguages toEntity () => SpokenLanguages(
    englishName: this.englishName,
    iso6391: this.iso_639_1,
    name: this.name,
  );
}