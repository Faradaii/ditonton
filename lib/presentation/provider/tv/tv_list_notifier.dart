import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <TvSeries>[];

  List<TvSeries> get nowPlayingTv => _nowPlayingTv;

  var _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTv = <TvSeries>[];

  List<TvSeries> get popularTv => _popularTv;

  var _popularTvState = RequestState.Empty;

  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TvSeries>[];

  List<TvSeries> get topRatedTv => _topRatedTv;

  var _topRatedState = RequestState.Empty;

  RequestState get topRatedState => _topRatedState;

  String _message = '';

  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}