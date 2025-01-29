import 'package:core/helper/bloc_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/search_movies.dart';

import '../../../domain/entities/movie.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc({required SearchMovies searchMovies})
      : super(MovieSearchEmpty()) {
    on<OnQueryChangedEvent>((event, emit) async {
      emit(MovieSearchLoading());

      final String query = event.query;
      final result = await searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(MovieSearchError(failure.message));
        },
        (movies) {
          emit(MovieSearchLoaded(movies));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
