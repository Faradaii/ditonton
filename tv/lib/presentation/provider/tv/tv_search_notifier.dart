import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/search_tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTv searchTv;

  TvSearchNotifier({required this.searchTv});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvSeries> _searchResult = [];

  List<TvSeries> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTv.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (searchResult) {
        _searchResult = searchResult;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
