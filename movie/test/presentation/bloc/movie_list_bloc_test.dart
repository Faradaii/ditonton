import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  test('initial state should be empty', () {
    expect(movieListBloc.state, MovieListEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.loaded when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MovieListLoaded(movieNowPlayingState: RequestState.loading),
        MovieListLoaded(
            moviesNowPlaying: testMovieList,
            movieNowPlayingState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute()).called(1);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded.copyWith] with RequestState.loading when another data is already gotten',
      setUp: () {
        movieListBloc.emit(MovieListLoaded(moviesPopular: testMovieList));
      },
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MovieListLoaded(
            moviesPopular: testMovieList,
            movieNowPlayingState: RequestState.loading),
        MovieListLoaded(
            moviesPopular: testMovieList,
            moviesNowPlaying: testMovieList,
            movieNowPlayingState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute()).called(1);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.error when data is gotten unsuccessfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MovieListLoaded(movieNowPlayingState: RequestState.loading),
        MovieListLoaded(
            message: "Server Failure",
            movieNowPlayingState: RequestState.error),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute()).called(1);
      },
    );
  });

  group('Popular Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.loaded when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MovieListLoaded(moviePopularState: RequestState.loading),
        MovieListLoaded(
            moviesPopular: testMovieList,
            moviePopularState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute()).called(1);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded.copyWith] with RequestState.loading when another data is already gotten',
      setUp: () {
        movieListBloc.emit(MovieListLoaded(moviesTopRated: testMovieList));
      },
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MovieListLoaded(
            moviesTopRated: testMovieList,
            moviePopularState: RequestState.loading),
        MovieListLoaded(
            moviesTopRated: testMovieList,
            moviesPopular: testMovieList,
            moviePopularState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute()).called(1);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.error when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MovieListLoaded(moviePopularState: RequestState.loading),
        MovieListLoaded(
            message: "Server Failure", moviePopularState: RequestState.error),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute()).called(1);
      },
    );
  });

  group('Top Rated Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.loaded when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MovieListLoaded(movieTopRatedState: RequestState.loading),
        MovieListLoaded(
            moviesTopRated: testMovieList,
            movieTopRatedState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute()).called(1);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded.copyWith] with RequestState.loading when another data is already gotten',
      setUp: () {
        movieListBloc.emit(MovieListLoaded(moviesNowPlaying: testMovieList));
      },
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MovieListLoaded(
            moviesNowPlaying: testMovieList,
            movieTopRatedState: RequestState.loading),
        MovieListLoaded(
            moviesNowPlaying: testMovieList,
            moviesTopRated: testMovieList,
            movieTopRatedState: RequestState.loaded),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute()).called(1);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loaded] with RequestState.loading and then RequestState.error when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MovieListLoaded(movieTopRatedState: RequestState.loading),
        MovieListLoaded(
            message: "Server Failure", movieTopRatedState: RequestState.error),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute()).called(1);
      },
    );
  });

  group('MovieListLoaded.copyWith', () {
    test('should return a new instance with updated moviesNowPlaying', () {
      final initialState = MovieListLoaded(
        moviesNowPlaying: [],
        movieNowPlayingState: RequestState.loading,
        moviesPopular: [],
        moviePopularState: RequestState.empty,
        moviesTopRated: [],
        movieTopRatedState: RequestState.empty,
        message: '',
      );

      final newState = initialState.copyWith(moviesNowPlaying: testMovieList);

      expect(newState.moviesNowPlaying, testMovieList);
      expect(newState.movieNowPlayingState, initialState.movieNowPlayingState);
      expect(newState.moviesPopular, initialState.moviesPopular);
      expect(newState.moviePopularState, initialState.moviePopularState);
      expect(newState.moviesTopRated, initialState.moviesTopRated);
      expect(newState.movieTopRatedState, initialState.movieTopRatedState);
      expect(newState.message, initialState.message);
    });

    test('should return a new instance with updated message', () {
      final initialState = MovieListLoaded(
        moviesNowPlaying: [],
        movieNowPlayingState: RequestState.loading,
        moviesPopular: [],
        moviePopularState: RequestState.empty,
        moviesTopRated: [],
        movieTopRatedState: RequestState.empty,
        message: '',
      );

      const updatedMessage = 'Error occurred';

      final newState = initialState.copyWith(message: updatedMessage);

      expect(newState.message, updatedMessage);
      expect(newState.moviesNowPlaying, initialState.moviesNowPlaying);
      expect(newState.movieNowPlayingState, initialState.movieNowPlayingState);
      expect(newState.moviesPopular, initialState.moviesPopular);
      expect(newState.moviePopularState, initialState.moviePopularState);
      expect(newState.moviesTopRated, initialState.moviesTopRated);
      expect(newState.movieTopRatedState, initialState.movieTopRatedState);
    });

    test(
        'should return a new instance with no changes when no parameters are provided',
        () {
      final initialState = MovieListLoaded(
        moviesNowPlaying: [],
        movieNowPlayingState: RequestState.loading,
        moviesPopular: [],
        moviePopularState: RequestState.empty,
        moviesTopRated: [],
        movieTopRatedState: RequestState.empty,
        message: '',
      );

      final newState = initialState.copyWith();

      expect(newState, initialState);
    });
  });
}
