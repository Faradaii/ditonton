import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late TvNowPlayingBloc tvNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(getNowPlayingTv: mockGetNowPlayingTv);
  });

  test('initial state should be empty state', () {
    expect(tvNowPlayingBloc.state, TvNowPlayingEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(GetTvNowPlayingEvent()),
      expect: () => [
            TvNowPlayingLoading(),
            TvNowPlayingLoaded(testTvSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(GetTvNowPlayingEvent()),
      expect: () => [
            TvNowPlayingLoading(),
            TvNowPlayingError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute()).called(1);
      });
}
