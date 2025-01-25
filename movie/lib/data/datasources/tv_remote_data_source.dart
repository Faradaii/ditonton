import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_detail/episode_response.dart';
import 'package:ditonton/data/models/tv/tv_detail/season_response.dart';
import 'package:ditonton/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTv();

  Future<List<TvSeriesModel>> getPopularTv();

  Future<List<TvSeriesModel>> getTopRatedTv();

  Future<TvSeriesDetailResponse> getTvDetail(int id);

  Future<List<TvSeriesModel>> getTvRecommendations(int id);

  Future<List<TvSeriesModel>> searchTv(String query);

  Future<SeasonResponse> getTvDetailSeason(
      {required int id, required int seasonNumber});

  Future<EpisodeResponse> getTvDetailSeasonEpisode(
      {required int id, required int seasonNumber, required int episodeNumber});
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getNowPlayingTv() async {
    final response =
    await client.get(Uri.parse('$baseUrl/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTv() async {
    final response =
    await client.get(Uri.parse('$baseUrl/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTv() async {
    final response =
    await client.get(Uri.parse('$baseUrl/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonResponse> getTvDetailSeason(
      {required int id, required int seasonNumber}) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EpisodeResponse> getTvDetailSeasonEpisode(
      {required int id,
      required int seasonNumber,
      required int episodeNumber}) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/tv/$id/season/$seasonNumber/episode/$episodeNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return EpisodeResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
