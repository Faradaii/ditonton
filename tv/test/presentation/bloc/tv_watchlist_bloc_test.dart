import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late TvWatchlistBloc tvWatchlistBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(getWatchlistTv: mockGetWatchlistTv);
  });

  test('initial state should be empty state', () {
    expect(tvWatchlistBloc.state, TvWatchlistEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetTvWatchlistEvent()),
      expect: () => [
            TvWatchlistLoading(),
            TvWatchlistLoaded(testTvSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetTvWatchlistEvent()),
      expect: () => [
            TvWatchlistLoading(),
            TvWatchlistError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute()).called(1);
      });
}
