part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedEvent {
  const MovieTopRatedEvent();
}

class GetMovieTopRatedEvent extends MovieTopRatedEvent {}
