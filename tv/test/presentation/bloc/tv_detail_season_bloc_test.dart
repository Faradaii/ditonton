import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:tv/presentation/bloc/tv_detail_season/tv_detail_season_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_season_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetailSeason])
void main() {
  late MockGetTvDetailSeason mockGetTvDetailSeason;
  late TvDetailSeasonBloc tvDetailSeasonBloc;
  late int tId;
  late int tSeasonNumber;

  setUp(() {
    mockGetTvDetailSeason = MockGetTvDetailSeason();
    tvDetailSeasonBloc =
        TvDetailSeasonBloc(getTvDetailSeason: mockGetTvDetailSeason);
    tId = 1;
    tSeasonNumber = 1;
  });

  test('initial state should be empty state', () {
    expect(tvDetailSeasonBloc.state, TvDetailSeasonEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetailSeason.execute(
                id: tId, seasonNumber: tSeasonNumber))
            .thenAnswer((_) async => Right(testSeasonDetail));
        return tvDetailSeasonBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailSeasonEvent(tId, tSeasonNumber)),
      expect: () => [
            TvDetailSeasonLoading(),
            TvDetailSeasonLoaded(testSeasonDetail),
          ],
      verify: (bloc) {
        verify(mockGetTvDetailSeason.execute(
                id: tId, seasonNumber: tSeasonNumber))
            .called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTvDetailSeason.execute(
                id: tId, seasonNumber: tSeasonNumber))
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvDetailSeasonBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailSeasonEvent(tId, tSeasonNumber)),
      expect: () => [
            TvDetailSeasonLoading(),
            TvDetailSeasonError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetTvDetailSeason.execute(
                id: tId, seasonNumber: tSeasonNumber))
            .called(1);
      });
}
