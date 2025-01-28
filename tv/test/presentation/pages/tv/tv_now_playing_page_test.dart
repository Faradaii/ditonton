import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_now_playing_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvNowPlayingBloc
    extends MockBloc<TvNowPlayingEvent, TvNowPlayingState>
    implements TvNowPlayingBloc {}

class FakeTvNowPlayingEvent extends Fake implements TvNowPlayingEvent {}

class FakeTvNowPlayingState extends Fake implements TvNowPlayingState {}

void main() {
  late MockTvNowPlayingBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeTvNowPlayingEvent());
    registerFallbackValue(FakeTvNowPlayingState());
  });

  setUp(() {
    mockBloc = MockTvNowPlayingBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvNowPlayingBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvNowPlayingLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvNowPlayingPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvNowPlayingLoaded(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TvNowPlayingPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display empty message when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvNowPlayingLoaded([]));

    await tester.pumpWidget(makeTestableWidget(TvNowPlayingPage()));

    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvNowPlayingError(
      'error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvNowPlayingPage()));

    expect(textFinder, findsOneWidget);
  });
}
