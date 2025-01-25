import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv/crew.dart';
import 'package:tv/domain/entities/tv/episode/episode.dart';
import 'package:tv/domain/entities/tv/guest_stars.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season_episode.dart';
import 'package:tv/presentation/provider/tv/tv_detail_season_episode_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_season_episode_notifier_test.mocks.dart';

@GenerateMocks([GetTvDetailSeasonEpisode])
void main() {
  late MockGetTvDetailSeasonEpisode mockGetTvDetailSeasonEpisode;
  late TvDetailSeasonEpisodeNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetailSeasonEpisode = MockGetTvDetailSeasonEpisode();
    notifier = TvDetailSeasonEpisodeNotifier(
        getTvDetailSeasonEpisode: mockGetTvDetailSeasonEpisode)
      ..addListener(() {
        listenerCallCount++;
      });
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
            name: "name",
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
            name: "name",
            originalName: "original_name",
            popularity: 0.938,
            profilePath: "profile_path"),
      ],
      name: "name",
      overview: "overview",
      id: 1,
      productionCode: "",
      runtime: 1,
      seasonNumber: 1,
      stillPath: "/m5ZXbQ4VTLinMwgAvLl53zSOllb.jpg",
      voteAverage: 1.0,
      voteCount: 1);

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvDetailSeasonEpisode.execute(
            id: tSeriesId,
            seasonNumber: tSeasonNumber,
            episodeNumber: tEpisodeNumber))
        .thenAnswer((_) async => Right(tEpisode));
    // act
    notifier.fetchTvDetailSeasonEpisode(
        id: tSeriesId,
        seasonNumber: tSeasonNumber,
        episodeNumber: tEpisodeNumber);
    // assert
    expect(notifier.episodeState, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test(
      'should change tv series season episode data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvDetailSeasonEpisode.execute(
            id: tSeriesId,
            seasonNumber: tSeasonNumber,
            episodeNumber: tEpisodeNumber))
        .thenAnswer((_) async => Right(tEpisode));
    // act
    await notifier.fetchTvDetailSeasonEpisode(
        id: tSeriesId,
        seasonNumber: tSeasonNumber,
        episodeNumber: tEpisodeNumber);
    // assert
    expect(notifier.episodeState, RequestState.loaded);
    expect(notifier.episode, tEpisode);
    expect(listenerCallCount, 3);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvDetailSeasonEpisode.execute(
            id: tSeriesId,
            seasonNumber: tSeasonNumber,
            episodeNumber: tEpisodeNumber))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvDetailSeasonEpisode(
        id: tSeriesId,
        seasonNumber: tSeasonNumber,
        episodeNumber: tEpisodeNumber);
    // assert
    expect(notifier.episodeState, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
