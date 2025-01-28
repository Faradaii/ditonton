import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv/crew.dart';
import 'package:tv/domain/entities/tv/episode/episode.dart';
import 'package:tv/domain/entities/tv/guest_stars.dart';
import 'package:tv/presentation/bloc/tv_detail_season_episode/tv_detail_season_episode_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_season_episode_page.dart';

class MockTvDetailSeasonEpisodeBloc
    extends MockBloc<TvDetailSeasonEpisodeEvent, TvDetailSeasonEpisodeState>
    implements TvDetailSeasonEpisodeBloc {}

class FakeTvDetailSeasonEpisodeEvent extends Fake
    implements TvDetailSeasonEpisodeEvent {}

class FakeTvDetailSeasonEpisodeState extends Fake
    implements TvDetailSeasonEpisodeState {}

void main() {
  late MockTvDetailSeasonEpisodeBloc mockBloc;

  setUpAll(() async {
    registerFallbackValue(FakeTvDetailSeasonEpisodeEvent());
    registerFallbackValue(FakeTvDetailSeasonEpisodeState());
  });

  setUp(() {
    mockBloc = MockTvDetailSeasonEpisodeBloc();
  });

  final tSeriesId = 1;
  final tSeasonNumber = 1;
  final tEpisodeNumber = 1;
  final tEpisode = Episode(
      airDate: "1994-11-19",
      crew: [
        Crew(
            department: "department",
            job: "job",
            creditId: "credit_id",
            adult: false,
            gender: 2,
            id: 1,
            knownForDepartment: "known_for_department",
            name: "crew name",
            originalName: "original_name",
            popularity: 2.293,
            profilePath: "/fLoLNH4aNPRJcbpvduWMGEzyrIT.jpg"),
      ],
      episodeNumber: 1,
      guestStars: [
        GuestStars(
            character: "character",
            creditId: "credit_id",
            order: 1,
            adult: false,
            gender: 2,
            id: 1,
            knownForDepartment: "known_for_department",
            name: "guest star name",
            originalName: "original_name",
            popularity: 0.938,
            profilePath: "profile_path"),
      ],
      name: "episode name",
      overview: "overview",
      id: 1,
      productionCode: "",
      runtime: 1,
      seasonNumber: 1,
      stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
      voteAverage: 1.0,
      voteCount: 1);
  final tEpisodeCrewAndGuestStarEmpty = Episode(
      airDate: "1994-11-19",
      crew: [],
      episodeNumber: 1,
      guestStars: [],
      name: "episode name",
      overview: "overview",
      id: 1,
      productionCode: "",
      runtime: 1,
      seasonNumber: 1,
      stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
      voteAverage: 1.0,
      voteCount: 1);

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailSeasonEpisodeBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => (mockBloc.state)).thenReturn(TvDetailSeasonEpisodeEmpty());

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
    when(() => (mockBloc.state))
        .thenReturn(TvDetailSeasonEpisodeError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvDetailSeasonEpisodePage(
      id: tSeriesId,
      seasonNumber: tSeasonNumber,
      episodeNumber: tEpisodeNumber,
    )));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
    'should display tv details season episode when state is TvDetailLoaded',
    (WidgetTester tester) async {
      when(() => mockBloc.state)
          .thenReturn(TvDetailSeasonEpisodeLoaded(tEpisode));

      // Act
      await tester.pumpWidget(makeTestableWidget(TvDetailSeasonEpisodePage(
        id: tSeriesId,
        seasonNumber: tEpisode.seasonNumber!,
        episodeNumber: tEpisode.episodeNumber!,
      )));

      // Assert
      expect(find.text(tEpisode.name!), findsOneWidget);
      expect(find.text(tEpisode.overview!), findsOneWidget);
      expect(find.text("No GuestStar"), findsNothing);
      expect(find.text("No Crew"), findsNothing);
    },
  );

  testWidgets(
    'should display tv details season episode with no guestStar and no crew when state is TvDetailLoaded with no guestStar and no crew',
    (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(
          TvDetailSeasonEpisodeLoaded(tEpisodeCrewAndGuestStarEmpty));

      // Act
      await tester.pumpWidget(makeTestableWidget(TvDetailSeasonEpisodePage(
        id: tSeriesId,
        seasonNumber: tEpisode.seasonNumber!,
        episodeNumber: tEpisode.episodeNumber!,
      )));

      // Assert
      expect(find.text(tEpisode.name!), findsOneWidget);
      expect(find.text(tEpisode.overview!), findsOneWidget);
      expect(find.text("No Crew"), findsOneWidget);
      expect(find.text("No GuestStar"), findsOneWidget);
    },
  );
}
