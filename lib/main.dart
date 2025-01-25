import 'dart:ui';

import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:about/presentation/page/about_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/now_playing_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/movie_search_notifier.dart';
import 'package:movie/presentation/provider/now_playing_movie_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:tv/presentation/pages/tv/tv_home_page.dart';
import 'package:tv/presentation/pages/tv/tv_now_playing_page.dart';
import 'package:tv/presentation/pages/tv/tv_popular_page.dart';
import 'package:tv/presentation/pages/tv/tv_search_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_season_episode_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_season_page.dart';
import 'package:tv/presentation/pages/tv/tv_top_rated_page.dart';
import 'package:tv/presentation/pages/tv/tv_watchlist_page.dart';
import 'package:tv/presentation/provider/tv/tv_now_playing_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_top_rated_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_detail_season_episode_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_detail_season_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_list_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_search_notifier.dart';
import 'package:tv/presentation/provider/tv/tv_watchlist_notifier.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvNowPlayingNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailSeasonNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailSeasonEpisodeNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvWatchlistNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case routeHomeMovie:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case routeNowPlayingMovie:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviePage());
            case routePopularMovie:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case routeTopRatedMovie:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case routeDetailMovie:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case routeSearchMovie:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case routeWatchlistMovie:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case routeHomeTv:
              return MaterialPageRoute(builder: (_) => TvHomePage());
            case routeNowPlayingTv:
              return MaterialPageRoute(builder: (_) => TvNowPlayingPage());
            case routePopularTv:
              return MaterialPageRoute(builder: (_) => TvPopularPage());
            case routeTopRatedTv:
              return MaterialPageRoute(builder: (_) => TvTopRatedPage());
            case routeDetailTv:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case routeDetailSeasonTv:
              final arguments = settings.arguments as Map<String, dynamic>;
              final id = arguments['id'] as int;
              final seasonNumber = arguments['seasonNumber'] as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailSeasonPage(
                  id: id,
                  seasonNumber: seasonNumber,
                ),
                settings: settings,
              );
            case routeDetailSeasonEpisodeTv:
              final arguments = settings.arguments as Map<String, dynamic>;
              final id = arguments['id'] as int;
              final seasonNumber = arguments['seasonNumber'] as int;
              final episodeNumber = arguments['episodeNumber'] as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailSeasonEpisodePage(
                  id: id,
                  seasonNumber: seasonNumber,
                  episodeNumber: episodeNumber,
                ),
                settings: settings,
              );
            case routeSearchTv:
              return MaterialPageRoute(builder: (_) => TvSearchPage());
            case routeWatchlistTv:
              return MaterialPageRoute(builder: (_) => TvWatchlistPage());

            case routeAbout:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
