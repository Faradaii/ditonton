import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';

import '../../repositories/tv_repository.dart';

class GetTvRecommendation {
  final TvRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute (int id) {
    return repository.getTvSeriesRecommendations(id);
  }
}