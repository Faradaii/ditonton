import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_status.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist.dart';
import 'package:tv/domain/usecases/tv/save_watchlist.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendation,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendation mockGetTvRecommendation;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int tId;
  late String watchlistAddSuccessMessage;
  late String watchlistRemoveSuccessMessage;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendation = MockGetTvRecommendation();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvDetailBloc = TvDetailBloc(
        getTvDetail: mockGetTvDetail,
        getTvRecommendation: mockGetTvRecommendation,
        getWatchListStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
    tId = testTvSeriesDetail.id;
    watchlistAddSuccessMessage = 'Added to Watchlist';
    watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  });

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  group('Get Tv Detail', () {
    blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvSeriesDetail));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Right(testTvSeriesList));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
        expect: () => [
              TvDetailLoading(),
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  recommendationState: RequestState.empty,
                  isAddedToWatchlist: false),
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  recommendationState: RequestState.loading,
                  isAddedToWatchlist: false),
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  recommendations: testTvSeriesList,
                  recommendationState: RequestState.loaded,
                  isAddedToWatchlist: false),
            ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId)).called(1);
        });
    blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(GetTvDetailEvent(tId)),
        expect: () => [
              TvDetailLoading(),
              TvDetailError(message: "Server Failure"),
            ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId)).called(1);
        });
  });

  group('Get Tv Recommendation', () {
    blocTest(
        'Should get data from usecase and update state recommendations and recommendationState when data is gotten successfully',
        setUp: () {
          tvDetailBloc.emit(TvDetailLoaded(tv: testTvSeriesDetail));
        },
        build: () {
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Right(testTvSeriesList));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(GetTvRecommendationsEvent(tId)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  recommendations: [],
                  recommendationState: RequestState.loading),
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  recommendations: testTvSeriesList,
                  recommendationState: RequestState.loaded),
            ],
        verify: (bloc) {
          verify(mockGetTvRecommendation.execute(tId)).called(1);
        });

    blocTest(
        'Should get data from usecase and update state recommendationState and message when data is gotten unsuccessfully',
        setUp: () {
          tvDetailBloc.emit(TvDetailLoaded(tv: testTvSeriesDetail));
        },
        build: () {
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(GetTvRecommendationsEvent(tId)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  recommendations: [],
                  recommendationState: RequestState.loading),
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  message: "Server Failure",
                  recommendationState: RequestState.error),
            ],
        verify: (bloc) {
          verify(mockGetTvRecommendation.execute(tId)).called(1);
        });
  });

  group('Watchlist', () {
    blocTest('Should get the watchlist status',
        setUp: () {
          tvDetailBloc.emit(TvDetailLoaded(tv: testTvSeriesDetail));
        },
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistStatusEvent(tId)),
        expect: () => [
              TvDetailLoaded(tv: testTvSeriesDetail, isAddedToWatchlist: true),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should execute save watchlist status when function called',
        setUp: () {
          tvDetailBloc.emit(TvDetailLoaded(
              tv: testTvSeriesDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testTvSeriesDetail))
              .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testTvSeriesDetail)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  isAddedToWatchlist: true,
                  watchlistMessage: watchlistAddSuccessMessage),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvSeriesDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should execute remove watchlist status when function called',
        setUp: () {
          tvDetailBloc.emit(
              TvDetailLoaded(tv: testTvSeriesDetail, isAddedToWatchlist: true));
        },
        build: () {
          when(mockRemoveWatchlist.execute(testTvSeriesDetail))
              .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistEvent(testTvSeriesDetail)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  isAddedToWatchlist: false,
                  watchlistMessage: watchlistRemoveSuccessMessage),
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTvSeriesDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest(
        'Should update message watchlist status when add watchlist success',
        setUp: () {
          tvDetailBloc.emit(TvDetailLoaded(
              tv: testTvSeriesDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testTvSeriesDetail))
              .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testTvSeriesDetail)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  isAddedToWatchlist: true,
                  watchlistMessage: watchlistAddSuccessMessage),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvSeriesDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should update message watchlist status when add watchlist failed',
        setUp: () {
          tvDetailBloc.emit(TvDetailLoaded(
              tv: testTvSeriesDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testTvSeriesDetail))
              .thenAnswer((_) async => Left(DatabaseFailure("Failed Add")));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testTvSeriesDetail)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  isAddedToWatchlist: false,
                  watchlistMessage: "Failed Add"),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvSeriesDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest(
        'Should update message watchlist status when remove watchlist failed',
        setUp: () {
          tvDetailBloc.emit(
              TvDetailLoaded(tv: testTvSeriesDetail, isAddedToWatchlist: true));
        },
        build: () {
          when(mockRemoveWatchlist.execute(testTvSeriesDetail))
              .thenAnswer((_) async => Left(DatabaseFailure("Failed Remove")));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistEvent(testTvSeriesDetail)),
        expect: () => [
              TvDetailLoaded(
                  tv: testTvSeriesDetail,
                  isAddedToWatchlist: true,
                  watchlistMessage: "Failed Remove"),
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTvSeriesDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });
  });

  group('TvDetailLoaded.copyWith', () {
    late TvDetailLoaded tvDetailLoaded;
    setUp(() {
      tvDetailLoaded = TvDetailLoaded(
        tv: testTvSeriesDetail,
        recommendations: [],
        recommendationState: RequestState.empty,
        isAddedToWatchlist: false,
        watchlistMessage: '',
      );
    });
    group('TvDetailLoaded.copyWith', () {
      test('should return a new instance with updated tv', () {
        // Act
        final newState = tvDetailLoaded.copyWith(tv: testTvSeriesDetailUpdated);

        // Assert
        expect(newState.tv, testTvSeriesDetailUpdated);
        expect(newState.recommendations, tvDetailLoaded.recommendations);
        expect(
            newState.recommendationState, tvDetailLoaded.recommendationState);
        expect(newState.isAddedToWatchlist, tvDetailLoaded.isAddedToWatchlist);
        expect(newState.watchlistMessage, tvDetailLoaded.watchlistMessage);
      });

      test('should return a new instance with updated recommendations', () {
        // Act
        final newState =
            tvDetailLoaded.copyWith(recommendations: testTvSeriesList);

        // Assert
        expect(newState.recommendations, testTvSeriesList);
        expect(newState.tv, tvDetailLoaded.tv);
        expect(
            newState.recommendationState, tvDetailLoaded.recommendationState);
        expect(newState.isAddedToWatchlist, tvDetailLoaded.isAddedToWatchlist);
        expect(newState.watchlistMessage, tvDetailLoaded.watchlistMessage);
      });

      test('should return a new instance with updated watchlist status', () {
        final newState = tvDetailLoaded.copyWith(isAddedToWatchlist: true);

        // Assert
        expect(newState.isAddedToWatchlist, true);
        expect(newState.tv, tvDetailLoaded.tv);
        expect(newState.recommendations, tvDetailLoaded.recommendations);
        expect(
            newState.recommendationState, tvDetailLoaded.recommendationState);
        expect(newState.watchlistMessage, tvDetailLoaded.watchlistMessage);
      });

      test('should return a new instance with updated message', () {
        const updatedMessage = 'Updated message';

        // Act
        final newState = tvDetailLoaded.copyWith(message: updatedMessage);

        // Assert
        expect(newState.message, updatedMessage);
        expect(newState.tv, tvDetailLoaded.tv);
        expect(newState.recommendations, tvDetailLoaded.recommendations);
        expect(
            newState.recommendationState, tvDetailLoaded.recommendationState);
        expect(newState.isAddedToWatchlist, tvDetailLoaded.isAddedToWatchlist);
        expect(newState.watchlistMessage, tvDetailLoaded.watchlistMessage);
      });

      test('should return the same instance if no arguments are provided', () {
        final newState = tvDetailLoaded.copyWith();

        // Assert
        expect(newState, tvDetailLoaded);
      });
    });
  });
}
