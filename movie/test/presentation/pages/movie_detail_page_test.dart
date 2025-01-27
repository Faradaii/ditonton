import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

@GenerateMocks([NavigatorObserver])
void main() {
  late MockMovieDetailBloc mockBloc;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    mockBloc = MockMovieDetailBloc();
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
      home: BlocProvider<MovieDetailBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  group('MovieDetailPage Tests', () {
    testWidgets(
      'should display loading indicator when state is MovieDetailLoading',
          (WidgetTester tester) async {
        // Arrange
        when(() => mockBloc.state).thenReturn(MovieDetailLoading());

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should display movie details when state is MovieDetailLoaded',
          (WidgetTester tester) async {

        when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
          movie: testMovieDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        expect(find.text('title'), findsOneWidget);
        expect(find.text('Action'), findsOneWidget);
        expect(find.text('overview'), findsOneWidget);
      },
    );

    testWidgets(
      'should display error message when state is MovieDetailError',
          (WidgetTester tester) async {
        // Arrange
        const errorMessage = 'Failed to load movie details';
        when(() => mockBloc.state).thenReturn(MovieDetailError(message: errorMessage));

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        expect(find.text(errorMessage), findsOneWidget);
      },
    );
  });

  group('watchlist', () {
    testWidgets(
      'should display add to watchlist button when movie is not in watchlist',
          (WidgetTester tester) async {
            when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
              movie: testMovieDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: '',
              isAddedToWatchlist: false,
            ));

            // Act
            await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

            // Assert
            expect(find.text('Watchlist'), findsOneWidget);
            expect(find.byIcon(Icons.add), findsOneWidget);
          });

    testWidgets(
      'should execute watchlist add and display snackbar when movie is not in watchlist',
          (WidgetTester tester) async {

        when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
          movie: testMovieDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));
        whenListen(
          mockBloc,
          Stream.fromIterable([
            MovieDetailLoaded(
              movie: testMovieDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: '',
              isAddedToWatchlist: false,
            ),
            MovieDetailLoaded(
              movie: testMovieDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage,
              isAddedToWatchlist: true,
            ),
          ]),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.tap(find.byKey(Key('watchlist_button')));
        await tester.pump();

        // Assert
        verify(() => mockBloc.add(AddWatchlistEvent(testMovieDetail))).called(1);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text(MovieDetailBloc.watchlistAddSuccessMessage), findsOneWidget);
        },
    );

    testWidgets(
      'should execute watchlist remove and display snackbar when movie is in watchlist',
          (WidgetTester tester) async {

            when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
              movie: testMovieDetail,
              recommendationState: RequestState.loaded,
              recommendations: [],
              watchlistMessage: '',
              isAddedToWatchlist: true,
            ));
            whenListen(
              mockBloc,
              Stream.fromIterable([
                MovieDetailLoaded(
                  movie: testMovieDetail,
                  recommendationState: RequestState.loaded,
                  recommendations: [],
                  watchlistMessage: '',
                  isAddedToWatchlist: true,
                ),
                MovieDetailLoaded(
                  movie: testMovieDetail,
                  recommendationState: RequestState.loaded,
                  recommendations: [],
                  watchlistMessage: MovieDetailBloc.watchlistRemoveSuccessMessage,
                  isAddedToWatchlist: false,
                ),
              ]),
            );

            // Act
            await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));
            await tester.tap(find.byKey(Key('watchlist_button')));
            await tester.pump();

            // Assert
            verify(() => mockBloc.add(RemoveWatchlistEvent(testMovieDetail))).called(1);
            expect(find.byType(SnackBar), findsOneWidget);
            expect(find.text(MovieDetailBloc.watchlistRemoveSuccessMessage), findsOneWidget);
          },
    );

    testWidgets(
      'should display remove from watchlist button when movie is in watchlist',
          (WidgetTester tester) async {

        when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
          movie: testMovieDetail,
          recommendationState: RequestState.loaded,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: true,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        expect(find.text('Watchlist'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
      },
    );
  });

  group('movie detail recommendations', () {
    testWidgets(
      'should display CircularProgressIndicator when recommendations are loading',
          (WidgetTester tester) async {

        when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
          movie: testMovieDetail,
          recommendationState: RequestState.loading,
          recommendations: [],
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        expect(find.bySemanticsLabel('recommendations_loading'), findsOneWidget);
      },
    );

    testWidgets(
      'should display movies when recommendations are loaded',
          (WidgetTester tester) async {

        when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
          movie: testMovieDetail,
          recommendationState: RequestState.loaded,
          recommendations: testMovieList,
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        for (var movie in testMovieList) {
          expect(find.bySemanticsLabel(movie.title!), findsOneWidget);
        }
        expect(find.bySemanticsLabel('recommendations_loading'), findsNothing);
      },
    );

    testWidgets(
      'should display error message when recommendations are error',
          (WidgetTester tester) async {

        when(() => mockBloc.state).thenReturn(MovieDetailLoaded(
          movie: testMovieDetail,
          recommendationState: RequestState.error,
          recommendations: [],
          message: 'Failed to get recommendations',
          watchlistMessage: '',
          isAddedToWatchlist: false,
        ));

        // Act
        await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

        // Assert
        expect(find.text('Failed to get recommendations'), findsOneWidget);
        expect(find.bySemanticsLabel('recommendations_loading'), findsNothing);

      },
    );

  });
}
