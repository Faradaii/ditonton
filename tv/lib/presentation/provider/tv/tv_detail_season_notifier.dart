import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv/season/season_detail.dart';
import '../../../domain/usecases/tv/get_tv_detail_season.dart';

class TvDetailSeasonNotifier extends ChangeNotifier {
  final GetTvDetailSeason getTvDetailSeason;

  TvDetailSeasonNotifier({
    required this.getTvDetailSeason,
  });

  late Season _season;

  Season get season => _season;

  RequestState _seasonState = RequestState.empty;

  RequestState get seasonState => _seasonState;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvDetailSeason(int id, int seasonNumber) async {
    _seasonState = RequestState.loading;
    notifyListeners();
    final detailResult =
        await getTvDetailSeason.execute(id: id, seasonNumber: seasonNumber);
    detailResult.fold(
      (failure) {
        _seasonState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (season) {
        _season = season;
        notifyListeners();
        _seasonState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
