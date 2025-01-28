import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvWatchlistBloc extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}

class FakeTvWatchlistEvent extends Fake implements TvWatchlistEvent {}

class FakeTvWatchlistState extends Fake implements TvWatchlistState {}

void main() {
  late MockTvWatchlistBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeTvWatchlistEvent());
    registerFallbackValue(FakeTvWatchlistState());
  });

  setUp(() {
    mockBloc = MockTvWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvWatchlistBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvWatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvWatchlistPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvWatchlistLoaded(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TvWatchlistPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display empty message when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvWatchlistLoaded([]));

    await tester.pumpWidget(makeTestableWidget(TvWatchlistPage()));

    expect(find.text('No tv series found, try add some!.'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvWatchlistError(
      'error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvWatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
