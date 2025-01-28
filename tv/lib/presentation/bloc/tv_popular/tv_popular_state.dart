part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

final class TvPopularEmpty extends TvPopularState {}

final class TvPopularLoading extends TvPopularState {}

final class TvPopularError extends TvPopularState {
  final String message;

  const TvPopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvPopularLoaded extends TvPopularState {
  final List<TvSeries> tvList;

  const TvPopularLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}
