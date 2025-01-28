import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv/created_by.dart';
import 'package:tv/domain/entities/tv/genres.dart';
import 'package:tv/domain/entities/tv/last_episode_to_air.dart';
import 'package:tv/domain/entities/tv/networks.dart';
import 'package:tv/domain/entities/tv/next_episode_to_air.dart';
import 'package:tv/domain/entities/tv/production_companies.dart';
import 'package:tv/domain/entities/tv/production_countries.dart';
import 'package:tv/domain/entities/tv/seasons.dart';
import 'package:tv/domain/entities/tv/spoken_languages.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';
import 'package:tv/presentation/widgets/tv_season_card.dart';

import 'tv_season_card_test.mocks.dart';

@GenerateMocks([NavigatorObserver])
void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "backdropPath updated",
    createdBy: [
      CreatedBy(
          id: 2,
          creditId: "creditId updated",
          name: "name updated",
          originalName: "originalName updated",
          gender: 2,
          profilePath: "profilePath updated")
    ],
    episodeRunTime: [2, 2, 3, 4],
    firstAirDate: "firstAirDate updated",
    genres: [Genres(id: 2, name: "name updated")],
    homepage: "homepage updated",
    id: 2,
    inProduction: false,
    languages: ["languages updated"],
    lastAirDate: "lastAirDate updated",
    lastEpisodeToAir: LastEpisodeToAir(
        id: 2,
        name: "name updated",
        overview: "overview updated",
        voteAverage: 2.0,
        voteCount: 2,
        airDate: "airDate updated",
        episodeNumber: 2,
        episodeType: "episodeType updated",
        productionCode: "productionCode updated",
        runtime: 2,
        seasonNumber: 2,
        showId: 2,
        stillPath: "stillPath updated"),
    name: "name updated",
    nextEpisodeToAir: NextEpisodeToAir(
        id: 2,
        name: "name updated",
        overview: "overview updated",
        voteAverage: 2.0,
        voteCount: 2,
        airDate: "airDate updated",
        episodeNumber: 2,
        episodeType: "episodeType updated",
        productionCode: "productionCode updated",
        runtime: 2,
        seasonNumber: 2,
        showId: 2,
        stillPath: "stillPath updated"),
    networks: [
      Networks(
          id: 2,
          logoPath: "logoPath updated",
          name: "name updated",
          originCountry: "originCountry updated")
    ],
    numberOfEpisodes: 2,
    numberOfSeasons: 2,
    originCountry: ["originCountry updated"],
    originalLanguage: "originalLanguage updated",
    originalName: "originalName updated",
    overview: "overview updated",
    popularity: 2.0,
    posterPath: "posterPath updated",
    productionCompanies: [
      ProductionCompanies(
          id: 2,
          logoPath: "logoPath updated",
          name: "name updated",
          originCountry: "originCountry updated")
    ],
    productionCountries: [
      ProductionCountries(iso31661: "iso31661 updated", name: "name updated")
    ],
    seasons: [
      Seasons(
          airDate: "airDate updated",
          episodeCount: 2,
          id: 2,
          name: "name updated",
          overview: "overview updated",
          posterPath: "posterPath updated",
          seasonNumber: 2,
          voteAverage: 2.0)
    ],
    spokenLanguages: [
      SpokenLanguages(
          englishName: "englishName updated",
          iso6391: "iso6391 updated",
          name: "name updated")
    ],
    status: "status updated",
    tagline: "tagline updated",
    type: "type updated",
    voteAverage: 2.0,
    voteCount: 2,
  );

  testWidgets('should display tv season name, poster etc',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvSeasonCard(
            tvDetailId: tTvSeriesDetail.id,
            season: tTvSeriesDetail.seasons!.first,
          ),
        ),
      ),
    );

    // Assert
    expect(find.bySemanticsLabel(tTvSeriesDetail.seasons!.first.posterPath!),
        findsOneWidget);
    expect(find.text(tTvSeriesDetail.seasons!.first.name!), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byIcon(Icons.error), findsNothing);
  });

  testWidgets('should navigate to TvDetailPage on tap',
      (WidgetTester tester) async {
    // Arrange
    when(mockObserver.navigator).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockObserver],
        onGenerateRoute: (settings) {
          if (settings.name == routeDetailSeasonTv) {
            final arguments = settings.arguments as Map<String, dynamic>;
            final id = arguments['id'] as int;
            final seasonNumber = arguments['seasonNumber'] as int;
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Text('Tv Series ID: $id, seasonNumber: $seasonNumber'),
              ),
            );
          }
          return null;
        },
        home: Scaffold(
          body: TvSeasonCard(
            tvDetailId: tTvSeriesDetail.id,
            season: tTvSeriesDetail.seasons!.first,
          ),
        ),
      ),
    );

    // Verify the initial state
    verify(mockObserver.didPush(any, any)).called(1);

    // Act
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Assert
    verify(mockObserver.didPush(any, any)).called(1);
    expect(find.text('Tv Series ID: 2, seasonNumber: 2'), findsOneWidget);
  });
}
