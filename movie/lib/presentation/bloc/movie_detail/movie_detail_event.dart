part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent {
  const MovieDetailEvent();
}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;
  const GetMovieDetailEvent(this.id);
}

class GetMovieRecommendationsEvent extends MovieDetailEvent {
  final int id;
  const GetMovieRecommendationsEvent(this.id);
}

class LoadWatchlistStatusEvent extends MovieDetailEvent {
  final int id;
  const LoadWatchlistStatusEvent(this.id);
}

class AddWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;
  const AddWatchlistEvent(this.movie);
}

class RemoveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;
  const RemoveWatchlistEvent(this.movie);
}