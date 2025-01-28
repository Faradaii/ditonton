import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/episode/episode.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season_episode.dart';

part 'tv_detail_season_episode_event.dart';
part 'tv_detail_season_episode_state.dart';

class TvDetailSeasonEpisodeBloc
    extends Bloc<TvDetailSeasonEpisodeEvent, TvDetailSeasonEpisodeState> {
  TvDetailSeasonEpisodeBloc(
      {required GetTvDetailSeasonEpisode getTvDetailSeasonEpisode})
      : super(TvDetailSeasonEpisodeEmpty()) {
    on<GetTvDetailSeasonEpisodeEvent>((event, emit) async {
      emit(TvDetailSeasonEpisodeLoading());

      final result = await getTvDetailSeasonEpisode.execute(
          id: event.id,
          seasonNumber: event.seasonNumber,
          episodeNumber: event.episodeNumber);
      result.fold((failure) {
        emit(TvDetailSeasonEpisodeError(failure.message));
      }, (tvList) {
        emit(TvDetailSeasonEpisodeLoaded(tvList));
      });
    });
  }
}
