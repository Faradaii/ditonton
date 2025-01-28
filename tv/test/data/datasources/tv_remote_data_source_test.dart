import 'dart:convert';

import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv/tv_detail/episode_response.dart';
import 'package:tv/data/models/tv/tv_detail/season_response.dart';
import 'package:tv/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:tv/data/models/tv/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get Now Playing Tv', () {
    final tTvList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_tv.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing_tv.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTv();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv', () {
    final tTvList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvList;

    test('should return list of tv list when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv', () {
    final tTvList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvList;

    test('should return list of tv list when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey'))).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv list', () {
    final tSearchResult = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_tv.json')))
        .tvList;
    final tQuery = 'Spiderman';

    test('should return list of tv list when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_tv.json'), 200));
      // act
      final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTv(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series season detail', () {
    final tId = 1;
    final tSeasonNumber = 1;
    final tTvDetailSeason = SeasonResponse.fromJson(
        json.decode(readJson('dummy_data/tv_season_detail.json')));

    test('should return tv season detail when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_season_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetailSeason(
          id: tId, seasonNumber: tSeasonNumber);
      // assert
      expect(result, equals(tTvDetailSeason));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call =
          dataSource.getTvDetailSeason(id: tId, seasonNumber: tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series season episode detail', () {
    group('get tv detail', () {
      final tId = 1;
      final tSeasonNumber = 1;
      final tEpisodeNumber = 1;
      final tTvDetailSeasonEpisode = EpisodeResponse.fromJson(
          json.decode(readJson('dummy_data/tv_episode_detail.json')));

      test(
          'should return tv season episode detail when the response code is 200',
          () async {
        // arrange
        when(mockIOClient.get(Uri.parse(
                '$baseUrl/tv/$tId/season/$tSeasonNumber/episode/$tEpisodeNumber?$apiKey')))
            .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_episode_detail.json'), 200));
        // act
        final result = await dataSource.getTvDetailSeasonEpisode(
            id: tId,
            seasonNumber: tSeasonNumber,
            episodeNumber: tEpisodeNumber);
        // assert
        expect(result, equals(tTvDetailSeasonEpisode));
      });

      test(
          'should throw Server Exception when the response code is 404 or other',
          () async {
        // arrange
        when(mockIOClient.get(Uri.parse(
                '$baseUrl/tv/$tId/season/$tSeasonNumber/episode/$tEpisodeNumber?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvDetailSeasonEpisode(
            id: tId,
            seasonNumber: tSeasonNumber,
            episodeNumber: tEpisodeNumber);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });
}
