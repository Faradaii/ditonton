import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(getTopRatedTv: mockGetTopRatedTv);
  });

  test('initial state should be empty state', () {
    expect(tvTopRatedBloc.state, TvTopRatedEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(GetTvTopRatedEvent()),
      expect: () => [
            TvTopRatedLoading(),
            TvTopRatedLoaded(testTvSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(GetTvTopRatedEvent()),
      expect: () => [
            TvTopRatedLoading(),
            TvTopRatedError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute()).called(1);
      });
}
