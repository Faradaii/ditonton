import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_search_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvSearchBloc extends MockBloc<TvSearchEvent, TvSearchState>
    implements TvSearchBloc {}

class FakeTvSearchEvent extends Fake implements TvSearchEvent {}

class FakeTvSearchState extends Fake implements TvSearchState {}

void main() {
  late MockTvSearchBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeTvSearchEvent());
    registerFallbackValue(FakeTvSearchState());
  });

  setUp(() {
    mockBloc = MockTvSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvSearchBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display text initial when empty state',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchEmpty());

    final textFinder = find.text('Try searching tv series!');

    await tester.pumpWidget(makeTestableWidget(TvSearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byKey(Key('loading'));

    await tester.pumpWidget(makeTestableWidget(TvSearchPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should execute onChanged when type text',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchLoaded(testTvSeriesList));

    await tester.pumpWidget(makeTestableWidget(TvSearchPage()));
    final textField = find.byType(TextField);

    await tester.enterText(textField, 'Spiderman');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pump();

    expect(find.text('Spiderman'), findsOneWidget);
    expect(textField, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchLoaded(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TvSearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display mo found message when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchLoaded([]));

    await tester.pumpWidget(makeTestableWidget(TvSearchPage()));

    expect(find.text('No tv series found.'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchError(
      'error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvSearchPage()));

    expect(textFinder, findsOneWidget);
  });
}
