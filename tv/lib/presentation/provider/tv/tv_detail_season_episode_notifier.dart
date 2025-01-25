import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv/episode/episode.dart';
import '../../../domain/usecases/tv/get_tv_detail_season_episode.dart';

class TvDetailSeasonEpisodeNotifier extends ChangeNotifier {
  final GetTvDetailSeasonEpisode getTvDetailSeasonEpisode;

  TvDetailSeasonEpisodeNotifier({
    required this.getTvDetailSeasonEpisode,
  });

  late Episode _episode;

  Episode get episode => _episode;

  RequestState _episodeState = RequestState.empty;

  RequestState get episodeState => _episodeState;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvDetailSeasonEpisode(
      {required int id,
      required int seasonNumber,
      required int episodeNumber}) async {
    _episodeState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetailSeasonEpisode.execute(
        id: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber);
    detailResult.fold(
      (failure) {
        _episodeState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (episode) {
        _episode = episode;
        notifyListeners();
        _episodeState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
