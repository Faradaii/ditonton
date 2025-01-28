import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvDetailState extends Fake implements TvDetailState {}

@GenerateMocks([NavigatorObserver])
void main() {
  late MockTvDetailBloc mockBloc;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    mockBloc = MockTvDetailBloc();
    mockObserver = MockNavigatorObserver();
    mockito.when(mockObserver.navigator).thenReturn(null);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      navigatorObservers: [mockObserver],
      onGenerateRoute: (settings) {
        if (settings.name == routeDetailMovie) {
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Text('Movie ID: $id'),
            ),
          );
        }
        return null;
      },
      home: BlocProvider<TvDetailBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  group('TvDetailPage Tests', () {
    testWidgets(
      'should display loading indicator when state is TvDetailLoading',
      (WidgetTester tester) async {
        // Arrange
        when(() => mockBloc.state).thenReturn(TvDetailLoading());

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should display tv details when state is TvDetailLoaded',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        expect(find.text(testTvSeriesDetail.name!), findsOneWidget);
        expect(find.text(testTvSeriesDetail.overview!), findsOneWidget);
        expect(
            find.text(testTvSeriesDetail.genres!.first.name!), findsOneWidget);
      },
    );

    testWidgets(
      'should display error message when state is TvDetailError',
      (WidgetTester tester) async {
        // Arrange
        const errorMessage = 'Failed to load tv details';
        when(() => mockBloc.state)
            .thenReturn(TvDetailError(message: errorMessage));

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        expect(find.text(errorMessage), findsOneWidget);
      },
    );
  });

  group('watchlist', () {
    testWidgets(
        'should display add to watchlist button when tv is not in watchlist',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(TvDetailLoaded(
        tv: testTvSeriesDetail,
        recommendationState: RequestState.loaded,
        recommendations: [],
        watchlistMessage: '',
        isAddedToWatchlist: false,
      ));

      // Act
      await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

      // Assert
      expect(find.text('Watchlist'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets(
      'should execute watchlist add and display snackbar when tv is not in watchlist',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));
        whenListen(
          mockBloc,
          Stream.fromIterable([
            TvDetailLoaded(
              tv: testTvSeriesDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: '',
              isAddedToWatchlist: false,
            ),
            TvDetailLoaded(
              tv: testTvSeriesDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: TvDetailBloc.watchlistAddSuccessMessage,
              isAddedToWatchlist: true,
            ),
          ]),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));
        await tester.tap(find.byKey(Key('watchlist_button')));
        await tester.pump();

        // Assert
        verify(() => mockBloc.add(AddWatchlistEvent(testTvSeriesDetail)))
            .called(1);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(
            find.text(TvDetailBloc.watchlistAddSuccessMessage), findsOneWidget);
      },
    );

    testWidgets(
      'should execute watchlist remove and display snackbar when tv is in watchlist',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: true,
        ));
        whenListen(
          mockBloc,
          Stream.fromIterable([
            TvDetailLoaded(
              tv: testTvSeriesDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: '',
              isAddedToWatchlist: true,
            ),
            TvDetailLoaded(
              tv: testTvSeriesDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: TvDetailBloc.watchlistRemoveSuccessMessage,
              isAddedToWatchlist: false,
            ),
          ]),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));
        await tester.tap(find.byKey(Key('watchlist_button')));
        await tester.pump();

        // Assert
        verify(() => mockBloc.add(RemoveWatchlistEvent(testTvSeriesDetail)))
            .called(1);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text(TvDetailBloc.watchlistRemoveSuccessMessage),
            findsOneWidget);
      },
    );

    testWidgets(
      'should display remove from watchlist button when tv is in watchlist',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: true,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        expect(find.text('Watchlist'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
      },
    );
  });

  group('tv detail recommendations', () {
    testWidgets(
      'should display CircularProgressIndicator when recommendations are loading',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.loading,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        expect(find.bySemanticsLabel('recommendation_loading'), findsOneWidget);
      },
    );

    testWidgets(
      'should display tv list when recommendations are loaded',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.loaded,
          recommendations: testTvSeriesList,
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        for (var tv in testTvSeriesList) {
          expect(find.bySemanticsLabel(tv.name!), findsOneWidget);
        }
        expect(find.bySemanticsLabel('recommendation_loading'), findsNothing);
      },
    );

    testWidgets(
      'should display error message when recommendations are error',
      (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvDetailLoaded(
          tv: testTvSeriesDetail,
          recommendationState: RequestState.error,
          recommendations: [],
          message: 'Failed to get recommendations',
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        // Assert
        expect(find.text('Failed to get recommendations'), findsOneWidget);
        expect(find.bySemanticsLabel('recommendation_loading'), findsNothing);
      },
    );
  });
}
