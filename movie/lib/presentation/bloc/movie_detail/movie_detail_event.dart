part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;
  const GetMovieDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetMovieRecommendationsEvent extends MovieDetailEvent {
  final int id;
  const GetMovieRecommendationsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatusEvent extends MovieDetailEvent {
  final int id;
  const LoadWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;
  const AddWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;
  const RemoveWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}