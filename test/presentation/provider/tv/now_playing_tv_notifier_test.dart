import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/presentation/provider/tv/now_playing_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late NowPlayingTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    notifier = NowPlayingTvNotifier(getNowPlayingTv: mockGetNowPlayingTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = TvSeries(
    adult: true,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    name: "name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchNowPlayingTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchNowPlayingTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
