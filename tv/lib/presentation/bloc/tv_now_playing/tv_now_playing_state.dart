part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();

  @override
  List<Object> get props => [];
}

final class TvNowPlayingEmpty extends TvNowPlayingState {}

final class TvNowPlayingLoading extends TvNowPlayingState {}

final class TvNowPlayingError extends TvNowPlayingState {
  final String message;

  const TvNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvNowPlayingLoaded extends TvNowPlayingState {
  final List<TvSeries> tvList;

  const TvNowPlayingLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}
