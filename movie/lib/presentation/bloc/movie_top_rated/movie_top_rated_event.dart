part of 'movie_top_rated_bloc.dart';

sealed class MovieTopRatedEvent {
  const MovieTopRatedEvent();
}

class GetMovieTopRatedEvent extends MovieTopRatedEvent {}

