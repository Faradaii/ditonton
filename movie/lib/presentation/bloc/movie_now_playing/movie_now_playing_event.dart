part of 'movie_now_playing_bloc.dart';

sealed class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class GetMovieNowPlayingEvent extends MovieNowPlayingEvent {}
