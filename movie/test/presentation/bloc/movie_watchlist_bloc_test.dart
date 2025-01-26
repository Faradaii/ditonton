import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc =
        MovieWatchlistBloc(getWatchlistMovies: mockGetWatchlistMovies);
  });

  test('initial state should be empty state', () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest('Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlistEvent()),
      expect: () => [
            MovieWatchlistLoading(),
            MovieWatchlistLoaded(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute()).called(1);
      });

  blocTest('Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlistEvent()),
      expect: () => [
            MovieWatchlistLoading(),
            MovieWatchlistError("Server Failure"),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute()).called(1);
      });
}
