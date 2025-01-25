import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String q) {
    return repository.searchTvSeries(q);
  }
}
