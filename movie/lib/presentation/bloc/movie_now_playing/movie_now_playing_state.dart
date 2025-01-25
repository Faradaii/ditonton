part of 'movie_now_playing_bloc.dart';

sealed class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();
}

final class MovieNowPlayingInitial extends MovieNowPlayingState {
  @override
  List<Object> get props => [];
}
