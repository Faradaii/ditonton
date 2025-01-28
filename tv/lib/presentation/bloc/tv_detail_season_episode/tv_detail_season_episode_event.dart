part of 'tv_detail_season_episode_bloc.dart';

abstract class TvDetailSeasonEpisodeEvent {
  const TvDetailSeasonEpisodeEvent();
}

class GetTvDetailSeasonEpisodeEvent extends TvDetailSeasonEpisodeEvent {
  final int id;
  final int seasonNumber;
  final int episodeNumber;

  const GetTvDetailSeasonEpisodeEvent(
      this.id, this.seasonNumber, this.episodeNumber);
}
