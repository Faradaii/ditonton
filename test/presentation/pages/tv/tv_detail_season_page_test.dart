import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/crew.dart';
import 'package:ditonton/domain/entities/tv/episodes.dart';
import 'package:ditonton/domain/entities/tv/guest_stars.dart';
import 'package:ditonton/domain/entities/tv/season/season_detail.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_season_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_season_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_detail_season_page_test.mocks.dart';

@GenerateMocks([TvDetailSeasonNotifier])
void main() {
  late MockTvDetailSeasonNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailSeasonNotifier();
  });

  final tSeriesId = 1;
  final tSeasonNumber = 1;
  final tSeason = Season(
      id_alternative: "1",
      airDate: "1994-11-19",
      episodes: [
        Episodes(
            airDate: "1994-11-19",
            episodeNumber: 1,
            episodeType: "standard",
            id: 1,
            name: "Name",
            overview: "overview",
            productionCode: "",
            runtime: 1,
            seasonNumber: 1,
            showId: 1,
            stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
            voteAverage: 1.0,
            voteCount: 1,
            crew: [
              Crew(
                  department: "department",
                  job: "job",
                  creditId: "52540b6e19c29579402f9a93",
                  adult: false,
                  gender: 2,
                  id: 1,
                  knownForDepartment: "Writing",
                  name: "Jname",
                  originalName: "original_name",
                  popularity: 3.21,
                  profilePath: "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"),
            ],
            guestStars: [
              GuestStars(
                  character: "character",
                  creditId: "credit_id",
                  order: 1,
                  adult: false,
                  gender: 2,
                  id: 1,
                  knownForDepartment: "known_for_department",
                  name: "name",
                  originalName: "original_name",
                  popularity: 0.938,
                  profilePath: "profile_path"),
            ]),
      ],
      name: "Season 1",
      overview: "",
      id: 1,
      posterPath: "/f1Dy2F8of9uZiSz6Z3kTlzpWz6L.jpg",
      seasonNumber: 1,
      voteAverage: 1.0);

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailSeasonNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvDetailSeasonPage(
      id: tSeriesId,
      seasonNumber: tSeasonNumber,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView of episode when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
    when(mockNotifier.season).thenReturn(tSeason);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TvDetailSeasonPage(
      id: tSeriesId,
      seasonNumber: tSeasonNumber,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvDetailSeasonPage(
      id: tSeriesId,
      seasonNumber: tSeasonNumber,
    )));

    expect(textFinder, findsOneWidget);
  });
}
