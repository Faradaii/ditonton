import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TvTopRatedNotifier({required this.getTopRatedTv});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvSeries> _tv = [];

  List<TvSeries> get tv => _tv;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
