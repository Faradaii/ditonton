part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingEvent {
  const MovieNowPlayingEvent();
}

class GetMovieNowPlayingEvent extends MovieNowPlayingEvent {}
