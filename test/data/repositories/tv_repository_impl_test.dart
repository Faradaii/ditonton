import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv/tv_detail/created_by_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/crew_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/episode_response.dart';
import 'package:ditonton/data/models/tv/tv_detail/episodes_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/genres_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/guest_stars.dart';
import 'package:ditonton/data/models/tv/tv_detail/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/networks_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/next_episode_to_air_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/production_companies_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/production_countries_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/season_response.dart';
import 'package:ditonton/data/models/tv/tv_detail/seasons_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/spoken_languages_model.dart';
import 'package:ditonton/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
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

  final tTvSeries = TvSeries(
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

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvDetailResponse = TvSeriesDetailResponse(
      adult: true,
      backdropPath: "backdropPath",
      createdBy: [
        CreatedByModel(
            id: 1,
            creditId: "creditId",
            name: "name",
            originalName: "originalName",
            gender: 1,
            profilePath: "profilePath")
      ],
      episodeRunTime: [1, 2, 3, 4],
      firstAirDate: "firstAirDate",
      genres: [GenresModel(id: 1, name: "name")],
      homepage: "homepage",
      id: 1,
      inProduction: false,
      languages: ["languages"],
      lastAirDate: "lastAirDate",
      lastEpisodeToAir: LastEpisodeToAirModel(
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
      nextEpisodeToAir: NextEpisodeToAirModel(
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
        NetworksModel(
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
        ProductionCompaniesModel(
            id: 1,
            logoPath: "logoPath",
            name: "name",
            originCountry: "originCountry")
      ],
      productionCountries: [
        ProductionCountriesModel(iso_3166_1: "iso31661", name: "name")
      ],
      seasons: [
        SeasonsModel(
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
        SpokenLanguagesModel(
            englishName: "englishName", iso_639_1: "iso6391", name: "name")
      ],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 1.0,
      voteCount: 1,
    );

    test(
        'should return Tv series detail data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvDetailResponse);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Season Detail', () {
    final tId = 1;
    final tSeasonNumber = 1;
    final tSeasonResponse = SeasonResponse(
        id_alternative: "1",
        airDate: "1994-11-19",
        episodes: [
          EpisodesModel(
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
                CrewModel(
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
                GuestStarsModel(
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

    test(
        'should return Tv series season detail data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetailSeason(
              id: tId, seasonNumber: tSeasonNumber))
          .thenAnswer((_) async => tSeasonResponse);
      // act
      final result = await repository.getTvSeriesSeasonDetail(
          id: tId, seasonNumber: tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvDetailSeason(
          id: tId, seasonNumber: tSeasonNumber));
      expect(result, equals(Right(testSeasonDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetailSeason(
              id: tId, seasonNumber: tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesSeasonDetail(
          id: tId, seasonNumber: tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvDetailSeason(
          id: tId, seasonNumber: tSeasonNumber));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetailSeason(
              id: tId, seasonNumber: tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesSeasonDetail(
          id: tId, seasonNumber: tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvDetailSeason(
          id: tId, seasonNumber: tSeasonNumber));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Season Episode Detail', () {
    final tId = 1;
    final tSeasonNumber = 1;
    final tEpisodeNumber = 1;
    final tEpisodeResponse = EpisodeResponse(
        airDate: "1994-11-19",
        crew: [
          CrewModel(
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
          GuestStarsModel(
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

    test(
        'should return Tv series season episode detail data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetailSeasonEpisode(
              id: tId,
              seasonNumber: tSeasonNumber,
              episodeNumber: tEpisodeNumber))
          .thenAnswer((_) async => tEpisodeResponse);
      // act
      final result = await repository.getTvSeriesSeasonEpisodeDetail(
          id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber);
      // assert
      verify(mockRemoteDataSource.getTvDetailSeasonEpisode(
          id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber));
      expect(result, equals(Right(testEpisodeDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetailSeasonEpisode(
              id: tId,
              seasonNumber: tSeasonNumber,
              episodeNumber: tEpisodeNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesSeasonEpisodeDetail(
          id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber);
      // assert
      verify(mockRemoteDataSource.getTvDetailSeasonEpisode(
          id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetailSeasonEpisode(
              id: tId,
              seasonNumber: tSeasonNumber,
              episodeNumber: tEpisodeNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesSeasonEpisodeDetail(
          id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber);
      // assert
      verify(mockRemoteDataSource.getTvDetailSeasonEpisode(
          id: tId, seasonNumber: tSeasonNumber, episodeNumber: tEpisodeNumber));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Series', () {
    final tQuery = 'spiderman';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of tv series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
