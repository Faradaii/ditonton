import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/pages/now_playing_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieNowPlayingBloc
    extends MockBloc<MovieNowPlayingEvent, MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class FakeMovieNowPlayingEvent extends Fake implements MovieNowPlayingEvent {}

class FakeMovieNowPlayingState extends Fake implements MovieNowPlayingState {}

void main() {
  late MockMovieNowPlayingBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeMovieNowPlayingEvent());
    registerFallbackValue(FakeMovieNowPlayingState());
  });

  setUp(() {
    mockBloc = MockMovieNowPlayingBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<MovieNowPlayingBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieNowPlayingLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(NowPlayingMoviePage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieNowPlayingLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(NowPlayingMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display empty message when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieNowPlayingLoaded([]));

    await tester.pumpWidget(makeTestableWidget(NowPlayingMoviePage()));

    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieNowPlayingError(
      'error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(NowPlayingMoviePage()));

    expect(textFinder, findsOneWidget);
  });
}
