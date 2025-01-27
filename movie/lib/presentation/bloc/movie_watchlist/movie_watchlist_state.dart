part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();
  @override
  List<Object> get props => [];
}

final class MovieWatchlistEmpty extends MovieWatchlistState {}

final class MovieWatchlistLoading extends MovieWatchlistState {}

final class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieWatchlistLoaded extends MovieWatchlistState {
  final List<Movie> movies;

  const MovieWatchlistLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
