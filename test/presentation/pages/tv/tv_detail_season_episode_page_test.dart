import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_season_episode_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_season_episode_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_detail_season_episode_page_test.mocks.dart';

@GenerateMocks([TvDetailSeasonEpisodeNotifier])
void main() {
  late MockTvDetailSeasonEpisodeNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailSeasonEpisodeNotifier();
  });

  final tSeriesId = 1;
  final tSeasonNumber = 1;
  final tEpisodeNumber = 1;

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailSeasonEpisodeNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.episodeState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvDetailSeasonEpisodePage(
      id: tSeriesId,
      seasonNumber: tSeasonNumber,
      episodeNumber: tEpisodeNumber,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.episodeState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvDetailSeasonEpisodePage(
      id: tSeriesId,
      seasonNumber: tSeasonNumber,
      episodeNumber: tEpisodeNumber,
    )));

    expect(textFinder, findsOneWidget);
  });
}
