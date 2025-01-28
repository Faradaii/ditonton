part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

final class MovieNowPlayingEmpty extends MovieNowPlayingState {}

final class MovieNowPlayingLoading extends MovieNowPlayingState {}

final class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> movies;

  const MovieNowPlayingLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
