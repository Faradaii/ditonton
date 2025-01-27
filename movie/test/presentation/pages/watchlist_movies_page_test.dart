import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieWatchlistBloc extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class FakeMovieWatchlistEvent extends Fake implements MovieWatchlistEvent {}

class FakeMovieWatchlistState extends Fake implements MovieWatchlistState {}

void main() {
  late MockMovieWatchlistBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeMovieWatchlistEvent());
    registerFallbackValue(FakeMovieWatchlistState());
  });

  setUp(() {
    mockBloc = MockMovieWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<MovieWatchlistBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(MovieWatchlistLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(MovieWatchlistLoaded(
            testMovieList
        ));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display empty message when data is loaded and empty',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(MovieWatchlistLoaded(
            []
        ));

        await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));

        expect(find.text('No movies found, try add some!.'), findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(MovieWatchlistError(
          'error message',
        ));

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(makeTestableWidget(WatchlistMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}
