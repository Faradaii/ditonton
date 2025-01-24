import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class RemoveWatchlist {
  final TvRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
