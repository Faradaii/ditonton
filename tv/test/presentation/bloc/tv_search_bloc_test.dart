import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/search_tv.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late TvSearchBloc tvSearchBloc;
  late String tQuery;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(searchTv: mockSearchTv);
    tQuery = 'Spiderman';
  });

  test('initial state should be empty state', () {
    expect(tvSearchBloc.state, TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchLoaded(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery)).called(1);
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is gotten unsuccessfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery)).called(1);
    },
  );
}
