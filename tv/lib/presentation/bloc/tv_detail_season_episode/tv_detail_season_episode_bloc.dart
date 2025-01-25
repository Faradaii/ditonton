import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_season_episode_event.dart';
part 'tv_detail_season_episode_state.dart';

class TvDetailSeasonEpisodeBloc
    extends Bloc<TvDetailSeasonEpisodeEvent, TvDetailSeasonEpisodeState> {
  TvDetailSeasonEpisodeBloc() : super(TvDetailSeasonEpisodeInitial()) {
    on<TvDetailSeasonEpisodeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
