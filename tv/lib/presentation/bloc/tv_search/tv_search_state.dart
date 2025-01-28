part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

final class TvSearchEmpty extends TvSearchState {}

final class TvSearchLoading extends TvSearchState {}

final class TvSearchError extends TvSearchState {
  final String message;

  const TvSearchError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvSearchLoaded extends TvSearchState {
  final List<TvSeries> tvList;

  const TvSearchLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}
