import 'package:ditonton/domain/entities/tv/season/season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:flutter/material.dart';

import '../../../common/state_enum.dart';

class TvDetailSeasonNotifier extends ChangeNotifier {
  final GetTvDetailSeason getTvDetailSeason;

  TvDetailSeasonNotifier({
    required this.getTvDetailSeason,
  });

  late Season _season;

  Season get season => _season;equestState _seasonState = RequestState.empty;

  RRequestState get seasonState => _seasonState;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvDetailSeason(int id, int seasonNumber) async {seasonState = RequestState.loading;
    nnotifyListeners();
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
