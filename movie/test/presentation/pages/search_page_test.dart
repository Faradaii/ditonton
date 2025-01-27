import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState>
    implements MovieSearchBloc {}

class FakeMovieSearchEvent extends Fake implements MovieSearchEvent {}

class FakeMovieSearchState extends Fake implements MovieSearchState {}

void main() {
  late MockMovieSearchBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeMovieSearchEvent());
    registerFallbackValue(FakeMovieSearchState());
  });

  setUp(() {
    mockBloc = MockMovieSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<MovieSearchBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display text initial when empty state',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieSearchEmpty());

    final textFinder = find.text('Try searching movies!');

    await tester.pumpWidget(makeTestableWidget(SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieSearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byKey(Key('loading'));

    await tester.pumpWidget(makeTestableWidget(SearchPage()));

    expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should execute onChanged when type text',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieSearchLoaded(testMovieList));

    await tester.pumpWidget(makeTestableWidget(SearchPage()));
    final textField = find.byType(TextField);

    await tester.enterText(textField, 'Spiderman');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pump();

    expect(find.text('Spiderman'), findsOneWidget);
    expect(textField, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieSearchLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(SearchPage()));

    expect(listViewFinder, findsOneWidget);
      });

  testWidgets(
      'Page should display mo found message when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieSearchLoaded([]));

    await tester.pumpWidget(makeTestableWidget(SearchPage()));

    expect(find.text('No movies found.'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieSearchError(
      'error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(SearchPage()));

    expect(textFinder, findsOneWidget);
      });
}
