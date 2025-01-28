part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();

  @override
  List<Object> get props => [];
}

final class TvTopRatedEmpty extends TvTopRatedState {}

final class TvTopRatedLoading extends TvTopRatedState {}

final class TvTopRatedError extends TvTopRatedState {
  final String message;

  const TvTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvTopRatedLoaded extends TvTopRatedState {
  final List<TvSeries> tvList;

  const TvTopRatedLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}
