part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

final class MoviePopularEmpty extends MoviePopularState {}

final class MoviePopularLoading extends MoviePopularState {}

final class MoviePopularError extends MoviePopularState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class MoviePopularLoaded extends MoviePopularState {
  final List<Movie> movies;

  const MoviePopularLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
