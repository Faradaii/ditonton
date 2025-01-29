import 'package:tv/data/models/tv/tv_model.dart';
import 'package:tv/data/models/tv/tv_table.dart';
import 'package:tv/domain/entities/tv/created_by.dart';
import 'package:tv/domain/entities/tv/crew.dart';
import 'package:tv/domain/entities/tv/episode/episode.dart';
import 'package:tv/domain/entities/tv/episodes.dart';
import 'package:tv/domain/entities/tv/genres.dart';
import 'package:tv/domain/entities/tv/guest_stars.dart';
import 'package:tv/domain/entities/tv/last_episode_to_air.dart';
import 'package:tv/domain/entities/tv/networks.dart';
import 'package:tv/domain/entities/tv/next_episode_to_air.dart';
import 'package:tv/domain/entities/tv/production_companies.dart';
import 'package:tv/domain/entities/tv/production_countries.dart';
import 'package:tv/domain/entities/tv/season/season_detail.dart';
import 'package:tv/domain/entities/tv/seasons.dart';
import 'package:tv/domain/entities/tv/spoken_languages.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';

final testTvSeries = TvSeries(
  adult: true,
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3, 4],
  id: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: true,
  backdropPath: "backdropPath",
  createdBy: [
    CreatedBy(
        id: 1,
        creditId: "creditId",
        name: "created by name",
        originalName: "originalName",
        gender: 1,
        profilePath: "profilePath")
  ],
  episodeRunTime: [1, 2, 3, 4],
  firstAirDate: "firstAirDate",
  genres: [Genres(id: 1, name: "genre name")],
  homepage: "homepage",
  id: 1,
  inProduction: false,
  languages: ["languages"],
  lastAirDate: "lastAirDate",
  lastEpisodeToAir: LastEpisodeToAir(
      id: 1,
      name: "last episode name",
      overview: "overview",
      voteAverage: 1.0,
      voteCount: 1,
      airDate: "airDate",
      episodeNumber: 1,
      episodeType: "episodeType",
      productionCode: "productionCode",
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: "stillPath"),
  name: "tv name",
  nextEpisodeToAir: NextEpisodeToAir(
      id: 1,
      name: "next episode name",
      overview: "overview",
      voteAverage: 1.0,
      voteCount: 1,
      airDate: "airDate",
      episodeNumber: 1,
      episodeType: "episodeType",
      productionCode: "productionCode",
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: "stillPath"),
  networks: [
    Networks(
        id: 1,
        logoPath: "logoPath",
        name: "networks name",
        originCountry: "originCountry")
  ],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ["originCountry"],
  originalLanguage: "originalLanguage",
  originalName: "originalName",
  overview: "overview",
  popularity: 1.0,
  posterPath: "posterPath",
  productionCompanies: [
    ProductionCompanies(
        id: 1,
        logoPath: "logoPath",
        name: "product comp name",
        originCountry: "originCountry")
  ],
  productionCountries: [
    ProductionCountries(iso31661: "iso31661", name: "product country name")
  ],
  seasons: [
    Seasons(
        airDate: "airDate",
        episodeCount: 1,
        id: 1,
        name: "season name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 1,
        voteAverage: 1.0)
  ],
  spokenLanguages: [
    SpokenLanguages(
        englishName: "englishName", iso6391: "iso6391", name: "language name")
  ],
  status: "status",
  tagline: "tagline",
  type: "type",
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvSeriesDetailUpdated = TvSeriesDetail(
  adult: false,
  backdropPath: "backdropPath updated",
  createdBy: [
    CreatedBy(
        id: 2,
        creditId: "creditId updated",
        name: "created byname updated",
        originalName: "originalName updated",
        gender: 2,
        profilePath: "profilePath updated")
  ],
  episodeRunTime: [2, 2, 3, 4],
  firstAirDate: "firstAirDate updated",
  genres: [Genres(id: 2, name: "genre name updated")],
  homepage: "homepage updated",
  id: 2,
  inProduction: false,
  languages: ["languages updated"],
  lastAirDate: "lastAirDate updated",
  lastEpisodeToAir: LastEpisodeToAir(
      id: 2,
      name: "last episode name updated",
      overview: "overview updated",
      voteAverage: 2.0,
      voteCount: 2,
      airDate: "airDate updated",
      episodeNumber: 2,
      episodeType: "episodeType updated",
      productionCode: "productionCode updated",
      runtime: 2,
      seasonNumber: 2,
      showId: 2,
      stillPath: "stillPath updated"),
  name: "tv name updated",
  nextEpisodeToAir: NextEpisodeToAir(
      id: 2,
      name: "next episode name updated",
      overview: "overview updated",
      voteAverage: 2.0,
      voteCount: 2,
      airDate: "airDate updated",
      episodeNumber: 2,
      episodeType: "episodeType updated",
      productionCode: "productionCode updated",
      runtime: 2,
      seasonNumber: 2,
      showId: 2,
      stillPath: "stillPath updated"),
  networks: [
    Networks(
        id: 2,
        logoPath: "logoPath updated",
        name: "networks name updated",
        originCountry: "originCountry updated")
  ],
  numberOfEpisodes: 2,
  numberOfSeasons: 2,
  originCountry: ["originCountry updated"],
  originalLanguage: "originalLanguage updated",
  originalName: "originalName updated",
  overview: "overview updated",
  popularity: 2.0,
  posterPath: "posterPath updated",
  productionCompanies: [
    ProductionCompanies(
        id: 2,
        logoPath: "logoPath updated",
        name: "product comp name updated",
        originCountry: "originCountry updated")
  ],
  productionCountries: [
    ProductionCountries(
        iso31661: "iso31661 updated", name: "product country name updated")
  ],
  seasons: [
    Seasons(
        airDate: "airDate updated",
        episodeCount: 2,
        id: 2,
        name: "season name updated",
        overview: "overview updated",
        posterPath: "posterPath updated",
        seasonNumber: 2,
        voteAverage: 2.0)
  ],
  spokenLanguages: [
    SpokenLanguages(
        englishName: "englishName updated",
        iso6391: "iso6391 updated",
        name: "language name updated")
  ],
  status: "status updated",
  tagline: "tagline updated",
  type: "type updated",
  voteAverage: 2.0,
  voteCount: 2,
);

final testSeasonDetail = Season(
    idAlternative: "1",
    airDate: "1994-11-19",
    episodes: [
      Episodes(
          airDate: "1994-11-19",
          episodeNumber: 1,
          episodeType: "standard",
          id: 1,
          name: "Name",
          overview: "overview",
          productionCode: "",
          runtime: 1,
          seasonNumber: 1,
          showId: 1,
          stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
          voteAverage: 1.0,
          voteCount: 1,
          crew: [
            Crew(
                department: "department",
                job: "job",
                creditId: "52540b6e19c29579402f9a93",
                adult: false,
                gender: 2,
                id: 1,
                knownForDepartment: "Writing",
                name: "Jname",
                originalName: "original_name",
                popularity: 3.21,
                profilePath: "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"),
          ],
          guestStars: [
            GuestStars(
                character: "character",
                creditId: "credit_id",
                order: 1,
                adult: false,
                gender: 2,
                id: 1,
                knownForDepartment: "known_for_department",
                name: "name",
                originalName: "original_name",
                popularity: 0.938,
                profilePath: "profile_path"),
          ]),
    ],
    name: "Season 1",
    overview: "",
    id: 1,
    posterPath: "/f1Dy2F8of9uZiSz6Z3kTlzpWz6L.jpg",
    seasonNumber: 1,
    voteAverage: 1.0);

final testEpisodeDetail = Episode(
    airDate: "1994-11-19",
    crew: [
      Crew(
          department: "department",
          job: "job",
          creditId: "credit_id",
          adult: false,
          gender: 2,
          id: 1,
          knownForDepartment: "known_for_department",
          name: "name",
          originalName: "original_name",
          popularity: 2.293,
          profilePath: "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"),
    ],
    episodeNumber: 1,
    guestStars: [
      GuestStars(
          character: "character",
          creditId: "credit_id",
          order: 1,
          adult: false,
          gender: 2,
          id: 1,
          knownForDepartment: "known_for_department",
          name: "name",
          originalName: "original_name",
          popularity: 0.938,
          profilePath: "profile_path"),
    ],
    name: "name",
    overview: "overview",
    id: 1,
    productionCode: "",
    runtime: 1,
    seasonNumber: 1,
    stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
    voteAverage: 1.0,
    voteCount: 1);

final testWatchlistTv = TvSeries.watchlist(
  id: 1,
  name: 'tv name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'tv name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvModel = TvSeriesModel(
  adult: true,
  backdropPath: "backdropPath",
  genreIds: [1, 2, 3, 4],
  id: 1,
  originCountry: ["originCountry"],
  originalLanguage: "originalLanguage",
  originalName: "originalName",
  overview: "overview",
  popularity: 1.0,
  posterPath: "posterPath",
  firstAirDate: "firstAirDate",
  name: "name",
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'tv name',
};
