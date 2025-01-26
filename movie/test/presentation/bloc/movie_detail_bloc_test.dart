
import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
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
        removeWatchlist: mockRemoveWatchlist
    );
    tId = testMovieDetail.id;
    watchlistAddSuccessMessage = 'Added to Watchlist';
    watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  });

  test('initial state should be empty', (){
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  group('Watchlist', ()
  {
    blocTest(
        'Should get the watchlist status',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail));
        },
        build: () {
          when(mockGetWatchlistStatus.execute(tId)).thenAnswer((
              _) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistStatusEvent(tId)),
        expect: () =>
        [
          isA<MovieDetailLoaded>().having(
                  (state) => state.isAddedToWatchlist,
              'isAddedToWatchlist',
              true
          ),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        }
    );

    blocTest(
        'Should execute save watchlist status when function called',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((
              _) async => Right(watchlistAddSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId)).thenAnswer((
              _) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testMovieDetail)),
        expect: () =>
        [
          isA<MovieDetailLoaded>().having(
                  (state) => state.isAddedToWatchlist,
              'isAddedToWatchlist',
              true
          ),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        }
    );

    blocTest(
        'Should execute remove watchlist status when function called',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: true));
        },
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer((
              _) async => Right(watchlistRemoveSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId)).thenAnswer((
              _) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistEvent(testMovieDetail)),
        expect: () =>
        [
          isA<MovieDetailLoaded>().having(
                  (state) => state.isAddedToWatchlist,
              'isAddedToWatchlist',
              false
          ),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        }
    );

    blocTest(
        'Should update message watchlist status when add watchlist success',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((
              _) async => Right(watchlistAddSuccessMessage));
          when(mockGetWatchlistStatus.execute(tId)).thenAnswer((
              _) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testMovieDetail)),
        expect: () =>
        [
          isA<MovieDetailLoaded>().having(
                  (state) => [state.isAddedToWatchlist, state.watchlistMessage],
              'isAddedToWatchlist and watchlistMessage',
              [true, watchlistAddSuccessMessage]
          ),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        }
    );

    blocTest(
        'Should update message watchlist status when add watchlist failed',
        setUp: () {
          movieDetailBloc.emit(MovieDetailLoaded(movie: testMovieDetail, isAddedToWatchlist: false));
        },
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((
              _) async => Left(DatabaseFailure("Failed")));
          when(mockGetWatchlistStatus.execute(tId)).thenAnswer((
              _) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistEvent(testMovieDetail)),
        expect: () =>
        [
          isA<MovieDetailLoaded>().having(
                  (state) => [state.isAddedToWatchlist, state.watchlistMessage],
              'isAddedToWatchlist and watchlistMessage',
              [false, "Failed"]
          ),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        }
    );
  });
}