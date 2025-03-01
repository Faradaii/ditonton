part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

final class MovieSearchEmpty extends MovieSearchState {}

final class MovieSearchLoading extends MovieSearchState {}

final class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;

  const MovieSearchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
