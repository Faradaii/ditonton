import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_popular_tv.dart';

class TvPopularNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  TvPopularNotifier({required this.getPopularTv});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvSeries> _tv = [];

  List<TvSeries> get tv => _tv;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTv.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (tvData) {
      _tv = tvData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
