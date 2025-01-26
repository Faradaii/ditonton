part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailEmpty extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final RequestState recommendationState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const MovieDetailLoaded({
    required this.movie,
    this.isAddedToWatchlist = false,
    this.recommendations = const [],
    this.recommendationState = RequestState.empty,
    this.watchlistMessage = ''});

  MovieDetailLoaded copyWith({
    MovieDetail? movie,
    List<Movie>? recommendations,
    RequestState? recommendationState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return MovieDetailLoaded(
      movie: movie ?? this.movie,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
    movie,
    recommendations,
    recommendationState,
    isAddedToWatchlist,
    watchlistMessage,
  ];
}
