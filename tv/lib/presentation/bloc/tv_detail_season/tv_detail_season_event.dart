part of 'tv_detail_season_bloc.dart';

abstract class TvDetailSeasonEvent {
  const TvDetailSeasonEvent();
}

class GetTvDetailSeasonEvent extends TvDetailSeasonEvent {
  final int id;
  final int seasonNumber;

  const GetTvDetailSeasonEvent(this.id, this.seasonNumber);
}
