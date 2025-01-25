import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/episode/episode.dart';
import '../../repositories/tv_repository.dart';

class GetTvDetailSeasonEpisode {
  final TvRepository repository;

  GetTvDetailSeasonEpisode(this.repository);

  Future<Either<Failure, Episode>> execute(
      {required int id,
      required int seasonNumber,
      required int episodeNumber}) {
    return repository.getTvSeriesSeasonEpisodeDetail(
        id: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber);
  }
}
