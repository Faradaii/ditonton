import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc =
        MovieTopRatedBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  test('initial state should be empty state', () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(GetMovieTopRatedEvent()),
      expect: () => [
            MovieTopRatedLoading(),
            MovieTopRatedLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(GetMovieTopRatedEvent()),
      expect: () => [
            MovieTopRatedLoading(),
            MovieTopRatedError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute()).called(1);
      });
}
