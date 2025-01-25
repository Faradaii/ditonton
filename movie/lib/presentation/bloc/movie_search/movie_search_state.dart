part of 'movie_search_bloc.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();
}

final class MovieSearchInitial extends MovieSearchState {
  @override
  List<Object> get props => [];
}
