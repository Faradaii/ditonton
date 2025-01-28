import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(getPopularTv: mockGetPopularTv);
  });

  test('initial state should be empty state', () {
    expect(tvPopularBloc.state, TvPopularEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(GetTvPopularEvent()),
      expect: () => [
            TvPopularLoading(),
            TvPopularLoaded(testTvSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(GetTvPopularEvent()),
      expect: () => [
            TvPopularLoading(),
            TvPopularError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute()).called(1);
      });
}
