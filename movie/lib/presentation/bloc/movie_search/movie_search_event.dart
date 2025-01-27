part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent {
  const MovieSearchEvent();
}

class OnQueryChangedEvent extends MovieSearchEvent {
  final String query;

  const OnQueryChangedEvent(this.query);
}