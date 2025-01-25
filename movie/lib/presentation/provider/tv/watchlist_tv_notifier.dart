import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <TvSeries>[];

  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTv});

  final GetWatchlistTv getWatchlistTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
