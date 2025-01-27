import 'package:core/core.dart';
import 'package:core/helper/database_helper_old.dart' as db_helper;
import 'package:get_it/get_it.dart';
import 'package:movie/data/datasources/db/database_movie.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tv/data/datasources/db/database_tv.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season_episode.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_status.dart'
    as getWatchListStatus;
import 'package:tv/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist.dart'
    as removeWatchlistTv;
import 'package:tv/domain/usecases/tv/save_watchlist.dart' as saveWatchlistTv;
import 'package:tv/domain/usecases/tv/search_tv.dart';
import 'package:tv/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_detail_season_episode_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_detail_season_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_list_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_now_playing_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_search_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_top_rated_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_watchlist_notifier.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(
          () => locator<db_helper.DatabaseHelper>().database);
  locator.registerLazySingletonAsync<Database>(() async {
    final database = await db_helper
        .DatabaseHelper()
        .database;
    return database as Database;
  });

  // helper
  await locator.isReady<Database>();
  locator.registerLazySingleton<DatabaseHelperNew>(
          () => DatabaseHelperNewImpl(locator()));
  locator.registerLazySingleton<NetworkHelper>(() => NetworkHelper());

  locator.registerLazySingleton<DatabaseMovie>(
          () => DatabaseMovie(databaseHelper: locator<DatabaseHelperNew>()));
  locator.registerLazySingleton<DatabaseTv>(
          () =>
          DatabaseTv(database: locator<db_helper.DatabaseHelper>().database));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () =>
          MovieRemoteDataSourceImpl(client: locator<NetworkHelper>().client));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseMovie: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
          () =>
          TvRemoteDataSourceImpl(client: locator<NetworkHelper>().client));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseTv: locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () =>
        MovieRepositoryImpl(
          remoteDataSource: locator(),
          localDataSource: locator(),
        ),
  );
  locator.registerLazySingleton<TvRepository>(
        () =>
        TvRepositoryImpl(
            remoteDataSource: locator(), localDataSource: locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvDetailSeason(locator()));
  locator.registerLazySingleton(() => GetTvDetailSeasonEpisode(locator()));
  locator.registerLazySingleton(() => GetTvRecommendation(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(
          () => getWatchListStatus.GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => saveWatchlistTv.SaveWatchlist(locator()));
  locator.registerLazySingleton(
          () => removeWatchlistTv.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // bloc
  locator.registerFactory(
        () =>
        MovieListBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () =>
        MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () =>
        MovieSearchBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
        () =>
        MovieNowPlayingBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
        () =>
        MoviePopularBloc(
          getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
        () =>
        MovieTopRatedBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () =>
        MovieWatchlistBloc(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendation: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailSeasonNotifier(
      getTvDetailSeason: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailSeasonEpisodeNotifier(
      getTvDetailSeasonEpisode: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularNotifier(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvNowPlayingNotifier(
      getNowPlayingTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistNotifier(
      getWatchlistTv: locator(),
    ),
  );
}
