import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../entities/tv/season/season_detail.dart';

class GetTvDetailSeason {
  final TvRepository repository;

  GetTvDetailSeason(this.repository);

  Future<Either<Failure, Season>> execute(
      {required int id, required int seasonNumber}) {
    return repository.getTvSeriesSeasonDetail(
        id: id, seasonNumber: seasonNumber);
  }
}
