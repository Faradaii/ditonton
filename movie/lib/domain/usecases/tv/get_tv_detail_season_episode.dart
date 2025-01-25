import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/episode/episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

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
