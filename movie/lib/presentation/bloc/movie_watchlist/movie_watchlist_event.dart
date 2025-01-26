part of 'movie_watchlist_bloc.dart';

sealed class MovieWatchlistEvent {
  const MovieWatchlistEvent();

}

class GetMovieWatchlistEvent extends MovieWatchlistEvent {}
