import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc =
        MovieNowPlayingBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  test('initial state should be empty state', () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(GetMovieNowPlayingEvent()),
      expect: () => [
            MovieNowPlayingLoading(),
            MovieNowPlayingLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(GetMovieNowPlayingEvent()),
      expect: () => [
            MovieNowPlayingLoading(),
            MovieNowPlayingError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute()).called(1);
      });
}
