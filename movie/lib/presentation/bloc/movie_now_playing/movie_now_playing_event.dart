part of 'movie_now_playing_bloc.dart';

sealed class MovieNowPlayingEvent {
  const MovieNowPlayingEvent();

}

class GetMovieNowPlayingEvent extends MovieNowPlayingEvent {}
