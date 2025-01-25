part of 'movie_list_bloc.dart';

sealed class MovieListState extends Equatable {
  const MovieListState();
}

final class MovieListInitial extends MovieListState {
  @override
  List<Object> get props => [];
}
