part of 'movie_top_rated_bloc.dart';

sealed class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();
}

final class MovieTopRatedInitial extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}
