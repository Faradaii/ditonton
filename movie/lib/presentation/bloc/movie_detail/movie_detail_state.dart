part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();
}

final class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}
