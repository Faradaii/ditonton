part of 'tv_detail_season_bloc.dart';

abstract class TvDetailSeasonState extends Equatable {
  const TvDetailSeasonState();

  @override
  List<Object> get props => [];
}

final class TvDetailSeasonEmpty extends TvDetailSeasonState {}

final class TvDetailSeasonLoading extends TvDetailSeasonState {}

final class TvDetailSeasonError extends TvDetailSeasonState {
  final String message;

  const TvDetailSeasonError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvDetailSeasonLoaded extends TvDetailSeasonState {
  final Season season;

  const TvDetailSeasonLoaded(this.season);

  @override
  List<Object> get props => [season];
}
