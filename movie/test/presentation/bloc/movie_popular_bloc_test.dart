import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movie_popular/movie_popular_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(getPopularMovies: mockGetPopularMovies);
  });

  test('initial state should be empty state', () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(GetMoviePopularEvent()),
      expect: () => [
            MoviePopularLoading(),
            MoviePopularLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(GetMoviePopularEvent()),
      expect: () => [
            MoviePopularLoading(),
            MoviePopularError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute()).called(1);
      });
}
