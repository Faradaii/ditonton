part of 'tv_detail_season_episode_bloc.dart';

sealed class TvDetailSeasonEpisodeState extends Equatable {
  const TvDetailSeasonEpisodeState();
}

final class TvDetailSeasonEpisodeInitial extends TvDetailSeasonEpisodeState {
  @override
  List<Object> get props => [];
}
