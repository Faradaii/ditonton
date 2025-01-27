part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent {
  const MovieWatchlistEvent();

}

class GetMovieWatchlistEvent extends MovieWatchlistEvent {}
