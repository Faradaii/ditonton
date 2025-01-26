import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int tId;
  late String watchlistAddSuccessMessage;
  late String watchlistRemoveSuccessMessage;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
        getMovieDetail: mockGetMovieDetail,
        getMovieRecommendations: mockGetMovieRecommendations,
        getWatchListStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
    tId = testMovieDetail.id;
    watchlistAddSuccessMessage = 'Added to Watchlist';
    watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  });

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  group('Get Movie Detail', () {
    blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailLoaded(movie: testMovieDetail),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId)).called(1);
        });
    blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailError(message: "Server Failure"),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId)).called(1);
        });
  });

  group('Get Movie Recommendations', () {
    blocTest(
        'Should get data from usecase and update state recommendations and recommendationState when data is gotten successfully',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail));
        },
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(testMovieList));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(GetMovieRecommendationsEvent(tId)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, recommendations: testMovieList, recommendationState: RequestState.loaded),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId)).called(1);
        });

    blocTest(
        'Should get data from usecase and update state recommendationState and message when data is gotten unsuccessfully',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail));
        },
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(GetMovieRecommendationsEvent(tId)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, message: "Server Failure", recommendationState: RequestState.error),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId)).called(1);
        });
  });

  group('Watchlist', () {
    blocTest('Should get the watchlist status',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail));
        },
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistStatusEvent(tId)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: true),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should execute save watchlist status when function called',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(
              movie: testMovieDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testMovieDetail)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: true, watchlistMessage: watchlistAddSuccessMessage),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should execute remove watchlist status when function called',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(
              movie: testMovieDetail, isAddedToWatchlist: true));
        },
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistEvent(testMovieDetail)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: false, watchlistMessage: watchlistRemoveSuccessMessage),

        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest(
        'Should update message watchlist status when add watchlist success',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(
              movie: testMovieDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testMovieDetail)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: true, watchlistMessage: watchlistAddSuccessMessage),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should update message watchlist status when add watchlist failed',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(
              movie: testMovieDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure("Failed Add")));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testMovieDetail)),
        expect: () => [
    MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: false, watchlistMessage: "Failed Add"),

            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });

    blocTest('Should update message watchlist status when remove watchlist failed',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(
              movie: testMovieDetail, isAddedToWatchlist: true));
        },
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure("Failed Remove")));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistEvent(testMovieDetail)),
        expect: () => [
          MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: true, watchlistMessage: "Failed Remove"),

        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });
  });

  group('MovieDetailLoaded.copyWith', () {
    late MovieDetailLoaded movieDetailLoaded;
    setUp(() {
      movieDetailLoaded = MovieDetailLoaded(
        movie: testMovieDetail,
        recommendations: [],
        recommendationState: RequestState.empty,
        isAddedToWatchlist: false,
        watchlistMessage: '',
      );
    });
    group('MovieDetailLoaded.copyWith', () {
      test('should return a new instance with updated movie', () {
        // Act
        final newState = movieDetailLoaded.copyWith(movie: testMovieDetailUpdated);

        // Assert
        expect(newState.movie, testMovieDetailUpdated);
        expect(newState.recommendations, movieDetailLoaded.recommendations);
        expect(newState.recommendationState, movieDetailLoaded.recommendationState);
        expect(newState.isAddedToWatchlist, movieDetailLoaded.isAddedToWatchlist);
        expect(newState.watchlistMessage, movieDetailLoaded.watchlistMessage);
      });

      test('should return a new instance with updated recommendations', () {
        // Act
        final newState = movieDetailLoaded.copyWith(recommendations: testMovieList);

        // Assert
        expect(newState.recommendations, testMovieList);
        expect(newState.movie, movieDetailLoaded.movie);
        expect(newState.recommendationState, movieDetailLoaded.recommendationState);
        expect(newState.isAddedToWatchlist, movieDetailLoaded.isAddedToWatchlist);
        expect(newState.watchlistMessage, movieDetailLoaded.watchlistMessage);
      });

      test('should return a new instance with updated watchlist status', () {
        final newState = movieDetailLoaded.copyWith(isAddedToWatchlist: true);

        // Assert
        expect(newState.isAddedToWatchlist, true);
        expect(newState.movie, movieDetailLoaded.movie);
        expect(newState.recommendations, movieDetailLoaded.recommendations);
        expect(newState.recommendationState, movieDetailLoaded.recommendationState);
        expect(newState.watchlistMessage, movieDetailLoaded.watchlistMessage);
      });

      test('should return a new instance with updated message', () {
        const updatedMessage = 'Updated message';

        // Act
        final newState = movieDetailLoaded.copyWith(message: updatedMessage);

        // Assert
        expect(newState.message, updatedMessage);
        expect(newState.movie, movieDetailLoaded.movie);
        expect(newState.recommendations, movieDetailLoaded.recommendations);
        expect(newState.recommendationState, movieDetailLoaded.recommendationState);
        expect(newState.isAddedToWatchlist, movieDetailLoaded.isAddedToWatchlist);
        expect(newState.watchlistMessage, movieDetailLoaded.watchlistMessage);
      });

      test('should return the same instance if no arguments are provided', () {
        final newState = movieDetailLoaded.copyWith();

        // Assert
        expect(newState, movieDetailLoaded);
      });
    });
  });
}
