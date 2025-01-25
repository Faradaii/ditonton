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
        name: "name",
        originalName: "originalName",
        gender: 1,
        profilePath: "profilePath")
  ],
  episodeRunTime: [1, 2, 3, 4],
  firstAirDate: "firstAirDate",
  genres: [Genres(id: 1, name: "name")],
  homepage: "homepage",
  id: 1,
  inProduction: false,
  languages: ["languages"],
  lastAirDate: "lastAirDate",
  lastEpisodeToAir: LastEpisodeToAir(
      id: 1,
      name: "name",
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
  name: "name",
  nextEpisodeToAir: NextEpisodeToAir(
      id: 1,
      name: "name",
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
        name: "name",
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
        name: "name",
        originCountry: "originCountry")
  ],
  productionCountries: [
    ProductionCountries(iso31661: "iso31661", name: "name")
  ],
  seasons: [
    Seasons(
        airDate: "airDate",
        episodeCount: 1,
        id: 1,
        name: "name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 1,
        voteAverage: 1.0)
  ],
  spokenLanguages: [
    SpokenLanguages(
        englishName: "englishName", iso6391: "iso6391", name: "name")
  ],
  status: "status",
  tagline: "tagline",
  type: "type",
  voteAverage: 1.0,
  voteCount: 1,
);

final testSeasonDetail = Season(
    id_alternative: "1",
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
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
