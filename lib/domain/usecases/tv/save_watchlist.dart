import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class SaveWatchlist {
  final TvRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
