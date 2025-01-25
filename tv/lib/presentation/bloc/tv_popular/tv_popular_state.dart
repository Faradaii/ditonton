part of 'tv_popular_bloc.dart';

sealed class TvPopularState extends Equatable {
  const TvPopularState();
}

final class TvPopularInitial extends TvPopularState {
  @override
  List<Object> get props => [];
}
