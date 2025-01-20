class TvSeriesDetail {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<Genres>? genres;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  NextEpisodeToAir? nextEpisodeToAir;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
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
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({required this.id, required this.logoPath, required this.name, required this.originCountry});
}

class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  String? originalName;
  int? gender;
  String? profilePath;

  CreatedBy(
      {required this.id,
        required this.creditId,
        required this.name,
        required this.originalName,
        required this.gender,
        required this.profilePath});
}

class Genres {
  int? id;
  String? name;

  Genres({required this.id, required this.name});
}

class LastEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  int? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  LastEpisodeToAir(
      {required this.id,
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
        required this.stillPath});
}

class NextEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  int? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  NextEpisodeToAir(
      {required this.id,
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
        required this.stillPath});
}

class Networks {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Networks({required this.id, required this.logoPath, required this.name, required this.originCountry});
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({required this.iso31661, required this.name});
}

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  int? voteAverage;

  Seasons(
      {required this.airDate,
        required this.episodeCount,
        required this.id,
        required this.name,
        required this.overview,
        required this.posterPath,
        required this.seasonNumber,
        required this.voteAverage});
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({required this.englishName, required this.iso6391, required this.name});
}
