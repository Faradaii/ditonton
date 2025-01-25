part of 'movie_popular_bloc.dart';

sealed class MoviePopularState extends Equatable {
  const MoviePopularState();
}

final class MoviePopularInitial extends MoviePopularState {
  @override
  List<Object> get props => [];
}
