import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season_episode.dart';
import 'package:tv/presentation/bloc/tv_detail_season_episode/tv_detail_season_episode_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_season_episode_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetailSeasonEpisode])
void main() {
  late MockGetTvDetailSeasonEpisode mockGetTvDetailSeasonEpisode;
  late TvDetailSeasonEpisodeBloc tvDetailSeasonEpisodeBloc;
  late int tId;
  late int tSeasonNumber;
  late int tEpisodeNumber;

  setUp(() {
    mockGetTvDetailSeasonEpisode = MockGetTvDetailSeasonEpisode();
    tvDetailSeasonEpisodeBloc = TvDetailSeasonEpisodeBloc(
        getTvDetailSeasonEpisode: mockGetTvDetailSeasonEpisode);
    tId = 1;
    tSeasonNumber = 1;
    tEpisodeNumber = 1;
  });

  test('initial state should be empty state', () {
    expect(tvDetailSeasonEpisodeBloc.state, TvDetailSeasonEpisodeEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetailSeasonEpisode.execute(
                id: tId,
                seasonNumber: tSeasonNumber,
                episodeNumber: tEpisodeNumber))
            .thenAnswer((_) async => Right(testEpisodeDetail));
        return tvDetailSeasonEpisodeBloc;
      },
      act: (bloc) => bloc.add(
          GetTvDetailSeasonEpisodeEvent(tId, tSeasonNumber, tEpisodeNumber)),
      expect: () => [
            TvDetailSeasonEpisodeLoading(),
            TvDetailSeasonEpisodeLoaded(testEpisodeDetail),
          ],
      verify: (bloc) {
        verify(mockGetTvDetailSeasonEpisode.execute(
                id: tId,
                seasonNumber: tSeasonNumber,
                episodeNumber: tEpisodeNumber))
            .called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTvDetailSeasonEpisode.execute(
                id: tId,
                seasonNumber: tSeasonNumber,
                episodeNumber: tEpisodeNumber))
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvDetailSeasonEpisodeBloc;
      },
      act: (bloc) => bloc.add(
          GetTvDetailSeasonEpisodeEvent(tId, tSeasonNumber, tEpisodeNumber)),
      expect: () => [
            TvDetailSeasonEpisodeLoading(),
            TvDetailSeasonEpisodeError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetTvDetailSeasonEpisode.execute(
                id: tId,
                seasonNumber: tSeasonNumber,
                episodeNumber: tEpisodeNumber))
            .called(1);
      });
}
