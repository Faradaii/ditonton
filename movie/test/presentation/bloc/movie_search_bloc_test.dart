import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;
  late String tQuery;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
    tQuery = 'Spiderman';
  });

  test('initial state should be empty state', () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery)).called(1);
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is gotten unsuccessfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery)).called(1);
    },
  );
}
