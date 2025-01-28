part of 'tv_detail_season_episode_bloc.dart';

abstract class TvDetailSeasonEpisodeState extends Equatable {
  const TvDetailSeasonEpisodeState();

  @override
  List<Object> get props => [];
}

final class TvDetailSeasonEpisodeEmpty extends TvDetailSeasonEpisodeState {}

final class TvDetailSeasonEpisodeLoading extends TvDetailSeasonEpisodeState {}

final class TvDetailSeasonEpisodeError extends TvDetailSeasonEpisodeState {
  final String message;

  const TvDetailSeasonEpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvDetailSeasonEpisodeLoaded extends TvDetailSeasonEpisodeState {
  final Episode episode;

  const TvDetailSeasonEpisodeLoaded(this.episode);

  @override
  List<Object> get props => [episode];
}
