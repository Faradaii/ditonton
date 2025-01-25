part of 'tv_now_playing_bloc.dart';

sealed class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();
}

final class TvNowPlayingInitial extends TvNowPlayingState {
  @override
  List<Object> get props => [];
}
