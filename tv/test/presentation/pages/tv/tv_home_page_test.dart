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
import 'package:tv/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_home_page.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

class MockTvListBloc extends MockBloc<TvListEvent, TvListState>
    implements TvListBloc {}

class FakeTvListEvent extends Fake implements TvListEvent {}

class FakeTvListState extends Fake implements TvListState {}

@GenerateMocks([NavigatorObserver])
void main() {
  late MockTvListBloc mockBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() async {
    mockNavigatorObserver = MockNavigatorObserver();
    registerFallbackValue(FakeTvListEvent());
    registerFallbackValue(FakeTvListState());
    await rootBundle.load('../../../assets/circle-g.png');
    mockBloc = MockTvListBloc();
    mockito.when(mockNavigatorObserver.navigator).thenReturn(null);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      navigatorObservers: [mockNavigatorObserver],
      routes: {
        routeHomeTv: (context) => Scaffold(body: const Text('Tv Series')),
        routeNowPlayingTv: (context) =>
            Scaffold(body: const Text('Now Playing Tv Series')),
        routePopularTv: (context) =>
            Scaffold(body: const Text('Popular Tv Series')),
        routeTopRatedTv: (context) =>
            Scaffold(body: const Text('Top Rated Tv Series')),
        routeSearchTv: (context) => Scaffold(body: const Text('Search')),
      },
      home: BlocProvider<TvListBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('should display loading indicators while loading tvList',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvListLoaded(
      tvNowPlayingState: RequestState.loading,
      tvPopularState: RequestState.loading,
      tvTopRatedState: RequestState.loading,
      tvListNowPlaying: [],
      tvListPopular: [],
      tvListTopRated: [],
      message: '',
    ));

    await tester.pumpWidget(makeTestableWidget(const TvHomePage()));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('should display tvList when loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvListLoaded(
      tvNowPlayingState: RequestState.loaded,
      tvPopularState: RequestState.loaded,
      tvTopRatedState: RequestState.loaded,
      tvListNowPlaying: testTvSeriesList,
      tvListPopular: testTvSeriesList,
      tvListTopRated: testTvSeriesList,
      message: '',
    ));

    await tester.pumpWidget(makeTestableWidget(const TvHomePage()));

    // Verify
    expect(find.byType(CachedNetworkImage),
        findsNWidgets(testTvSeriesList.length * 3));
    expect(find.text('Now Playing Tv Series'), findsOneWidget);
    expect(find.text('Popular Tv Series'), findsOneWidget);
    expect(find.text('Top Rated Tv Series'), findsOneWidget);
  });

  testWidgets('should display error message when tvList fail to load',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvListLoaded(
      tvNowPlayingState: RequestState.error,
      tvPopularState: RequestState.error,
      tvTopRatedState: RequestState.error,
      tvListNowPlaying: [],
      tvListPopular: [],
      tvListTopRated: [],
      message: 'Failed to load tvList',
    ));

    await tester.pumpWidget(makeTestableWidget(const TvHomePage()));

    // Verify the error message
    expect(find.text('Failed to load tvList'), findsNWidgets(3));
  });

  group('navigation', () {
    Future<void> searchNavigationAndTap(
        {required WidgetTester tester,
        String? title,
        required String expectText,
        IconData? icon,
        Key? key,
        bool? inDrawer = false}) async {
      when(() => mockBloc.state).thenReturn(TvListLoaded(
        tvNowPlayingState: RequestState.loaded,
        tvPopularState: RequestState.loaded,
        tvTopRatedState: RequestState.loaded,
        tvListNowPlaying: [],
        tvListPopular: [],
        tvListTopRated: [],
        message: '',
      ));

      await tester.pumpWidget(makeTestableWidget(const TvHomePage()));

      if (key != null) await tester.tap(find.byKey(key));
      if (icon != null) await tester.tap(find.byIcon(icon));
      await tester.pumpAndSettle();

      if (inDrawer == true) {
        await tester.tap(find.text(title!));
        await tester.pumpAndSettle();
      }
      expect(find.text(expectText), findsOneWidget);
    }

    testWidgets('should navigate to Now Playing Tv Series',
        (WidgetTester tester) async {
      await searchNavigationAndTap(
          tester: tester,
          title: 'See More',
          expectText: 'Now Playing Tv Series',
          key: Key('now_playing'));
    });
    testWidgets('should navigate to Popular Tv Series',
        (WidgetTester tester) async {
      await searchNavigationAndTap(
          tester: tester,
          title: 'See More',
          expectText: 'Popular Tv Series',
          key: Key('popular'));
    });
    testWidgets('should navigate to Top Rated Tv Series',
        (WidgetTester tester) async {
      await searchNavigationAndTap(
          tester: tester,
          title: 'See More',
          expectText: 'Top Rated Tv Series',
          key: Key('top_rated'));
    });
    testWidgets('should navigate to search', (WidgetTester tester) async {
      await searchNavigationAndTap(
          tester: tester, expectText: 'Search', key: Key('search'));
    });
  });
}
