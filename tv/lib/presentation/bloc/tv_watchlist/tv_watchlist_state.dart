part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

final class TvWatchlistEmpty extends TvWatchlistState {}

final class TvWatchlistLoading extends TvWatchlistState {}

final class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvWatchlistLoaded extends TvWatchlistState {
  final List<TvSeries> tvList;

  const TvWatchlistLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}
