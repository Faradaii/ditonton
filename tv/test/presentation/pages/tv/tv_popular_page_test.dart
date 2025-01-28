import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_popular_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvPopularBloc extends MockBloc<TvPopularEvent, TvPopularState>
    implements TvPopularBloc {}

class FakeTvPopularEvent extends Fake implements TvPopularEvent {}

class FakeTvPopularState extends Fake implements TvPopularState {}

void main() {
  late MockTvPopularBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeTvPopularEvent());
    registerFallbackValue(FakeTvPopularState());
  });

  setUp(() {
    mockBloc = MockTvPopularBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvPopularBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvPopularPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvPopularLoaded(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TvPopularPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display empty message when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvPopularLoaded([]));

    await tester.pumpWidget(makeTestableWidget(TvPopularPage()));

    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvPopularError(
      'error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvPopularPage()));

    expect(textFinder, findsOneWidget);
  });
}
