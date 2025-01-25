part of 'tv_top_rated_bloc.dart';

sealed class TvTopRatedState extends Equatable {
  const TvTopRatedState();
}

final class TvTopRatedInitial extends TvTopRatedState {
  @override
  List<Object> get props => [];
}
