import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_now_playing_tv.dart';
import '../../../domain/usecases/tv/get_popular_tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <TvSeries>[];

  List<TvSeries> get nowPlayingTv => _nowPlayingTv;

  var _nowPlayingState = RequestState.empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTv = <TvSeries>[];

  List<TvSeries> get popularTv => _popularTv;

  var _popularTvState = RequestState.empty;

  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TvSeries>[];

  List<TvSeries> get topRatedTv => _topRatedTv;

  var _topRatedState = RequestState.empty;

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
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayingTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedState = RequestState.loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}
