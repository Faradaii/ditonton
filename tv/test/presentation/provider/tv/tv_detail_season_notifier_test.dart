import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv/crew.dart';
import 'package:tv/domain/entities/tv/episodes.dart';
import 'package:tv/domain/entities/tv/guest_stars.dart';
import 'package:tv/domain/entities/tv/season/season_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:tv/presentation/provider/tv/tv_detail_season_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_season_notifier_test.mocks.dart';

@GenerateMocks([GetTvDetailSeason])
void main() {
  late MockGetTvDetailSeason mockGetTvDetailSeason;
  late TvDetailSeasonNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetailSeason = MockGetTvDetailSeason();
    notifier = TvDetailSeasonNotifier(getTvDetailSeason: mockGetTvDetailSeason)
      ..addListener(() {
        listenerCallCount++;
      });
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvDetailSeason.execute(
            id: tSeriesId, seasonNumber: tSeasonNumber))
        .thenAnswer((_) async => Right(tSeason));
    // act
    notifier.fetchTvDetailSeason(tSeriesId, tSeasonNumber);
    // assert
    expect(notifier.seasonState, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series season data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvDetailSeason.execute(
            id: tSeriesId, seasonNumber: tSeasonNumber))
        .thenAnswer((_) async => Right(tSeason));
    // act
    await notifier.fetchTvDetailSeason(tSeriesId, tSeasonNumber);
    // assert
    expect(notifier.seasonState, RequestState.loaded);
    expect(notifier.season, tSeason);
    expect(listenerCallCount, 3);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvDetailSeason.execute(
            id: tSeriesId, seasonNumber: tSeasonNumber))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvDetailSeason(tSeriesId, tSeasonNumber);
    // assert
    expect(notifier.seasonState, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
