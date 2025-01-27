import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';

class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

class FakeMovieListEvent extends Fake implements MovieListEvent {}

class FakeMovieListState extends Fake implements MovieListState {}

@GenerateMocks([NavigatorObserver])
void main() {
  late MockMovieListBloc mockBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() async {
    mockNavigatorObserver = MockNavigatorObserver();
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    await rootBundle.load('../../../assets/circle-g.png');
    mockBloc = MockMovieListBloc();
    mockito.when(mockNavigatorObserver.navigator).thenReturn(null);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      navigatorObservers: [mockNavigatorObserver],
      routes: {
        routeHomeMovie: (context) => Scaffold(body: const Text('Movies')),
        routeHomeTv: (context) => Scaffold(body: const Text('Tv Series')),
        routeWatchlistMovie: (context) => Scaffold(body: const Text('Watchlist Movie')),
        routeWatchlistTv: (context) => Scaffold(body: const Text('Watchlist Tv')),
        routeAbout: (context) => Scaffold(body: const Text('About')),
        routeNowPlayingMovie: (context) => Scaffold(body: const Text('Now Playing Movie')),
        routePopularMovie: (context) => Scaffold(body: const Text('Popular Movie')),
        routeTopRatedMovie: (context) => Scaffold(body: const Text('Top Rated Movie')),
      },
      home: BlocProvider<MovieListBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('should display loading indicators while loading movies', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieListLoaded(
      movieNowPlayingState: RequestState.loading,
      moviePopularState: RequestState.loading,
      movieTopRatedState: RequestState.loading,
      moviesNowPlaying: [],
      moviesPopular: [],
      moviesTopRated: [],
      message: '',
    ));

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('should display movies when loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieListLoaded(
      movieNowPlayingState: RequestState.loaded,
      moviePopularState: RequestState.loaded,
      movieTopRatedState: RequestState.loaded,
      moviesNowPlaying: testMovieList,
      moviesPopular: testMovieList,
      moviesTopRated: testMovieList,
      message: '',
    ));

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    // Verify
    expect(find.byType(CachedNetworkImage), findsNWidgets(testMovieList.length * 3));
    expect(find.text('Now Playing Movies'), findsOneWidget);
    expect(find.text('Popular Movies'), findsOneWidget);
    expect(find.text('Top Rated Movies'), findsOneWidget);
  });

  testWidgets('should display error message when movies fail to load', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieListLoaded(
      movieNowPlayingState: RequestState.error,
      moviePopularState: RequestState.error,
      movieTopRatedState: RequestState.error,
      moviesNowPlaying: [],
      moviesPopular: [],
      moviesTopRated: [],
      message: 'Failed to load movies',
    ));

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    // Verify the error message
    expect(find.text('Failed to load movies'), findsNWidgets(3));
  });

  group('drawer', () {
    Future<void> searchNavigationAndTap(
        {required WidgetTester tester, required String title, required String expectText, IconData? icon, Key? key, bool? inDrawer = false}) async {
      when(() => mockBloc.state).thenReturn(MovieListLoaded(
        movieNowPlayingState: RequestState.loaded,
        moviePopularState: RequestState.loaded,
        movieTopRatedState: RequestState.loaded,
        moviesNowPlaying: [],
        moviesPopular: [],
        moviesTopRated: [],
        message: '',
      ));

      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      if (key != null) await tester.tap(find.byKey(key));
      if (icon != null) await tester.tap(find.byIcon(icon));
      await tester.pumpAndSettle();

      if (inDrawer == true) {
        await tester.tap(find.text(title));
        await tester.pumpAndSettle();
      }
      expect(find.text(expectText), findsOneWidget);
    }

    testWidgets('should display drawer', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(MovieListLoaded(
        movieNowPlayingState: RequestState.loaded,
        moviePopularState: RequestState.loaded,
        movieTopRatedState: RequestState.loaded,
        moviesNowPlaying: [],
        moviesPopular: [],
        moviesTopRated: [],
        message: '',
      ));

      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verify
      expect(find.text('Tv Series'), findsOneWidget);
      expect(find.text('Movies'), findsOneWidget);
      expect(find.text('Watchlist Movie'), findsOneWidget);
      expect(find.text('Watchlist Tv'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('should display drawer and navigate to tv series', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'Tv Series', expectText: 'Tv Series',icon: Icons.menu, inDrawer: true);
    });
    testWidgets('should display drawer and navigate to Watchlist movie', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'Watchlist Movie', expectText: 'Watchlist Movie',icon: Icons.menu, inDrawer: true);
    });
    testWidgets('should display drawer and navigate to Watchlist Tv', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'Watchlist Tv', expectText: 'Watchlist Tv',  icon: Icons.menu, inDrawer: true);
    });
    testWidgets('should display drawer and navigate to About', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'About', expectText: 'About', icon: Icons.menu, inDrawer: true);
    });

    testWidgets('should navigate to Now Playing Movies', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'See More', expectText: 'Now Playing Movie', key: Key('now_playing'));
    });
    testWidgets('should navigate to Popular Movies', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'See More', expectText: 'Popular Movie', key: Key('popular'));
    });
    testWidgets('should navigate to Top Rated Movies', (WidgetTester tester) async {
      await searchNavigationAndTap(tester: tester, title: 'See More', expectText: 'Top Rated Movie', key: Key('top_rated'));
    });
  });
}