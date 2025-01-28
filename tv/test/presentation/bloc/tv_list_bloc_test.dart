import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_list/tv_list_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
  GetPopularTv,
  GetTopRatedTv,
])
void main() {
  late TvListBloc tvListBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvListBloc = TvListBloc(
      getNowPlayingTvList: mockGetNowPlayingTv,
      getPopularTvList: mockGetPopularTv,
      getTopRatedTvList: mockGetTopRatedTv,
    );
  });

  test('initial state should be empty', () {
    expect(tvListBloc.state, TvListEmpty());
  });

  group('Now Playing Tv', () {
    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.loaded when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvList()),
      expect: () => [
        TvListLoaded(tvNowPlayingState: RequestState.loading),
        TvListLoaded(
            tvListNowPlaying: testTvSeriesList,
            tvNowPlayingState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute()).called(1);
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded.copyWith] with RequestState.loading when another data is already gotten',
      setUp: () {
        tvListBloc.emit(TvListLoaded(tvListPopular: testTvSeriesList));
      },
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvList()),
      expect: () => [
        TvListLoaded(
            tvListPopular: testTvSeriesList,
            tvNowPlayingState: RequestState.loading),
        TvListLoaded(
            tvListPopular: testTvSeriesList,
            tvListNowPlaying: testTvSeriesList,
            tvNowPlayingState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute()).called(1);
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.error when data is gotten unsuccessfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvList()),
      expect: () => [
        TvListLoaded(tvNowPlayingState: RequestState.loading),
        TvListLoaded(
            message: "Server Failure", tvNowPlayingState: RequestState.error),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute()).called(1);
      },
    );
  });

  group('Popular Tv', () {
    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.loaded when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvList()),
      expect: () => [
        TvListLoaded(tvPopularState: RequestState.loading),
        TvListLoaded(
            tvListPopular: testTvSeriesList,
            tvPopularState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute()).called(1);
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded.copyWith] with RequestState.loading when another data is already gotten',
      setUp: () {
        tvListBloc.emit(TvListLoaded(tvListTopRated: testTvSeriesList));
      },
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvList()),
      expect: () => [
        TvListLoaded(
            tvListTopRated: testTvSeriesList,
            tvPopularState: RequestState.loading),
        TvListLoaded(
            tvListTopRated: testTvSeriesList,
            tvListPopular: testTvSeriesList,
            tvPopularState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute()).called(1);
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.error when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvList()),
      expect: () => [
        TvListLoaded(tvPopularState: RequestState.loading),
        TvListLoaded(
            message: "Server Failure", tvPopularState: RequestState.error),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute()).called(1);
      },
    );
  });

  group('Top Rated Tv', () {
    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.loaded when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvList()),
      expect: () => [
        TvListLoaded(tvTopRatedState: RequestState.loading),
        TvListLoaded(
            tvListTopRated: testTvSeriesList,
            tvTopRatedState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute()).called(1);
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded.copyWith] with RequestState.loading when another data is already gotten',
      setUp: () {
        tvListBloc.emit(TvListLoaded(tvListNowPlaying: testTvSeriesList));
      },
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvList()),
      expect: () => [
        TvListLoaded(
            tvListNowPlaying: testTvSeriesList,
            tvTopRatedState: RequestState.loading),
        TvListLoaded(
            tvListNowPlaying: testTvSeriesList,
            tvListTopRated: testTvSeriesList,
            tvTopRatedState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute()).called(1);
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.error when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvList()),
      expect: () => [
        TvListLoaded(tvTopRatedState: RequestState.loading),
        TvListLoaded(
            message: "Server Failure", tvTopRatedState: RequestState.error),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute()).called(1);
      },
    );
  });

  group('TvListLoaded.copyWith', () {
    test('should return a new instance with updated tvNowPlaying', () {
      final initialState = TvListLoaded(
        tvListNowPlaying: [],
        tvNowPlayingState: RequestState.loading,
        tvListPopular: [],
        tvPopularState: RequestState.empty,
        tvListTopRated: [],
        tvTopRatedState: RequestState.empty,
        message: '',
      );

      final newState =
          initialState.copyWith(tvListNowPlaying: testTvSeriesList);

      expect(newState.tvListNowPlaying, testTvSeriesList);
      expect(newState.tvNowPlayingState, initialState.tvNowPlayingState);
      expect(newState.tvListPopular, initialState.tvListPopular);
      expect(newState.tvPopularState, initialState.tvPopularState);
      expect(newState.tvListTopRated, initialState.tvListTopRated);
      expect(newState.tvTopRatedState, initialState.tvTopRatedState);
      expect(newState.message, initialState.message);
    });

    test('should return a new instance with updated message', () {
      final initialState = TvListLoaded(
        tvListNowPlaying: [],
        tvNowPlayingState: RequestState.loading,
        tvListPopular: [],
        tvPopularState: RequestState.empty,
        tvListTopRated: [],
        tvTopRatedState: RequestState.empty,
        message: '',
      );

      const updatedMessage = 'Error occurred';

      final newState = initialState.copyWith(message: updatedMessage);

      expect(newState.message, updatedMessage);
      expect(newState.tvListNowPlaying, initialState.tvListNowPlaying);
      expect(newState.tvNowPlayingState, initialState.tvNowPlayingState);
      expect(newState.tvListPopular, initialState.tvListPopular);
      expect(newState.tvPopularState, initialState.tvPopularState);
      expect(newState.tvListTopRated, initialState.tvListTopRated);
      expect(newState.tvTopRatedState, initialState.tvTopRatedState);
    });

    test(
        'should return a new instance with no changes when no parameters are provided',
        () {
      final initialState = TvListLoaded(
        tvListNowPlaying: [],
        tvNowPlayingState: RequestState.loading,
        tvListPopular: [],
        tvPopularState: RequestState.empty,
        tvListTopRated: [],
        tvTopRatedState: RequestState.empty,
        message: '',
      );

      final newState = initialState.copyWith();

      expect(newState, initialState);
    });
  });
}
