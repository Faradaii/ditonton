part of 'movie_list_bloc.dart';

sealed class MovieListState extends Equatable {
  final String message;
  const MovieListState({this.message = ''});
  @override
  List<Object> get props => [message];
}

final class MovieListEmpty extends MovieListState {}

final class MovieListLoaded extends MovieListState {
  final List<Movie> moviesNowPlaying;
  final RequestState movieNowPlayingState;
  final List<Movie> moviesPopular;
  final RequestState moviePopularState;
  final List<Movie> moviesTopRated;
  final RequestState movieTopRatedState;

  const MovieListLoaded({
    this.moviesNowPlaying = const [],
    this.movieNowPlayingState = RequestState.empty,
    this.moviesPopular = const [],
    this.moviePopularState = RequestState.empty,
    this.moviesTopRated = const [],
    this.movieTopRatedState = RequestState.empty,
    super.message,
  });

  MovieListLoaded copyWith({
    List<Movie>? moviesNowPlaying,
    RequestState? movieNowPlayingState,
    List<Movie>? moviesPopular,
    RequestState? moviePopularState,
    List<Movie>? moviesTopRated,
    RequestState? movieTopRatedState,
    String? message,
  }) {
    return MovieListLoaded(
      moviesNowPlaying: moviesNowPlaying ?? this.moviesNowPlaying,
      movieNowPlayingState: movieNowPlayingState ?? this.movieNowPlayingState,
      moviesPopular: moviesPopular ?? this.moviesPopular,
      moviePopularState: moviePopularState ?? this.moviePopularState,
      moviesTopRated: moviesTopRated ?? this.moviesTopRated,
      movieTopRatedState: movieTopRatedState ?? this.movieTopRatedState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    moviesNowPlaying,
    movieNowPlayingState,
    moviesPopular,
    moviePopularState,
    moviesTopRated,
    movieTopRatedState,
    message,
  ];
}
