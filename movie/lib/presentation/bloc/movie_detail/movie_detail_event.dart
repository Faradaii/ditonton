part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
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
