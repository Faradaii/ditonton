part of 'movie_search_bloc.dart';

sealed class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
}

class OnQueryChangedEvent extends MovieSearchEvent {
  final String query;

  const OnQueryChangedEvent(this.query);

  @override
  List<Object?> get props => [
    query,
  ];
}