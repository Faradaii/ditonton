import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class SaveWatchlist {
  final TvRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
