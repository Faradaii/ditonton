part of 'movie_popular_bloc.dart';

sealed class MoviePopularEvent {
  const MoviePopularEvent();
}

class GetMoviePopularEvent extends MoviePopularEvent {}

