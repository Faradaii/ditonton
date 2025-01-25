part of 'tv_detail_season_bloc.dart';

sealed class TvDetailSeasonState extends Equatable {
  const TvDetailSeasonState();
}

final class TvDetailSeasonInitial extends TvDetailSeasonState {
  @override
  List<Object> get props => [];
}
