import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/season/season_detail.dart';
import '../../repositories/tv_repository.dart';

class GetTvDetailSeason {
  final TvRepository repository;

  GetTvDetailSeason(this.repository);

  Future<Either<Failure, Season>> execute(
      {required int id, required int seasonNumber}) {
    return repository.getTvSeriesSeasonDetail(
        id: id, seasonNumber: seasonNumber);
  }
}
