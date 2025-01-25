import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv/episode/episode.dart';
import '../entities/tv/season/season_detail.dart';
import '../entities/tv/tv.dart';
import '../entities/tv/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();

  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();

  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();

  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);

  Future<Either<Failure, Season>> getTvSeriesSeasonDetail(
      {required int id, required int seasonNumber});

  Future<Either<Failure, Episode>> getTvSeriesSeasonEpisodeDetail(
      {required int id, required int seasonNumber, required int episodeNumber});

  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);

  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);

  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeries);

  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tvSeries);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
